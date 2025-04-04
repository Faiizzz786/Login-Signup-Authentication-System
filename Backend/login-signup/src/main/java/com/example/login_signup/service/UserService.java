package com.example.login_signup.service;

import com.example.login_signup.exception.CustomException;
import com.example.login_signup.model.JwtToken;
import com.example.login_signup.model.LoginAttempt;
import com.example.login_signup.model.PasswordResetToken;
import com.example.login_signup.model.User;
import com.example.login_signup.repository.LoginAttemptRepository;
import com.example.login_signup.repository.PasswordResetTokenRepository;
import com.example.login_signup.repository.UserRepository;
import com.example.login_signup.repository.JwtTokenRepository;
import com.example.login_signup.security.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class UserService {

    private final UserRepository userRepository;

    private final PasswordEncoder passwordEncoder;
    private final JavaMailSender mailSender;
    private final Map<String, Integer> loginAttempts = new ConcurrentHashMap<>();
    private final JwtUtil jwtUtil;

    @Autowired
    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder,
                       JavaMailSender mailSender, JwtUtil jwtUtil) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.mailSender = mailSender;
        this.jwtUtil = jwtUtil;
    }

    public String registerUser(User user) {
        // Validate email format
        if (!isValidEmail(user.getEmail())) {
            throw new CustomException("Invalid email format", HttpStatus.BAD_REQUEST.value());
        }

        // Check if email already exists
        if (userRepository.existsByEmail(user.getEmail())) {
            throw new CustomException("Email already exists", HttpStatus.BAD_REQUEST.value());
        }

        // Validate password
        if (!isValidPassword(user.getPassword())) {
            throw new CustomException("Password must be at least 8 characters long and contain at least one uppercase letter, one digit, and one special character.", HttpStatus.BAD_REQUEST.value());
        }

        // Encrypt password and set verification token
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setVerificationToken(UUID.randomUUID().toString());
        user.setVerified(false);
        userRepository.save(user);

        // Send verification email
        sendVerificationEmail(user);
        return "Registration successful! Verify your email.";
    }

    public String verifyEmail(String token) {
        Optional<User> optionalUser = userRepository.findByVerificationToken(token);
        if (optionalUser.isPresent()) {
            User user = optionalUser.get();
            user.setVerified(true);
            user.setVerificationToken(null);
            userRepository.save(user);
            return "Email verification successful!";
        } else {
            throw new CustomException("Invalid or expired verification token.", HttpStatus.BAD_REQUEST.value());
        }
    }
    @Autowired
    private JwtTokenRepository jwtTokenRepository;
    public JwtToken authenticateUser(String email, String password) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new CustomException("User not found", HttpStatus.BAD_REQUEST.value()));

        if (!user.isVerified()) {
            throw new CustomException("Please verify your email before logging in.", HttpStatus.FORBIDDEN.value());
        }

        if (!passwordEncoder.matches(password, user.getPassword())) {
            trackFailedLogin(email);
            throw new CustomException("Invalid credentials", HttpStatus.UNAUTHORIZED.value());
        }

       resetFailedLoginAttempts(email);
//        String token = jwtUtil.generateToken(email);
//        return new JwtToken(token);

        String token = jwtUtil.generateToken(email);
        JwtToken jwtToken = new JwtToken(email, token);
        jwtTokenRepository.save(jwtToken);  // ✅ Save token in DB

        return jwtToken;
    }

    private boolean isValidPassword(String password) {
        // Password must contain at least one uppercase letter, one digit, and one special character
        return password.matches("^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$");
    }

    private boolean isValidEmail(String email) {
        // Regex for basic email validation
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@" +
                "(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pattern = Pattern.compile(emailRegex);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

    private void sendVerificationEmail(User user) {
        String subject = "Email Verification";
        String verificationUrl = "http://localhost:9097/api/auth/verify?token=" + user.getVerificationToken();
        String message = "Hello " + user.getName() + ",\n\nPlease verify your email by clicking the link below:\n" + verificationUrl +
                "\n\nIf you did not register, please ignore this email.";

        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setTo(user.getEmail());
        mailMessage.setSubject(subject);
        mailMessage.setText(message);
        mailMessage.setFrom("your_email@gmail.com");

        mailSender.send(mailMessage);
    }


    @Autowired
    private PasswordResetTokenRepository passwordResetTokenRepository;





    // Request Password Reset (forgot password)
    public String requestPasswordReset(String email) {
        System.out.println("Received email: " + email);
//        User user = userRepository.findByEmail(email)
//                .orElseThrow(() -> new CustomException("User not found", 400));

        System.out.println("🔍 Received email for reset: [" + email + "]");  // Debug log

        if (email == null || email.trim().isEmpty()) {
            throw new CustomException("Email cannot be empty", 400);
        }

        Optional<User> userOpt = userRepository.findByEmail(email.trim());
        if (userOpt.isEmpty()) {
            System.out.println("❌ No user found with email: [" + email + "]");
            throw new CustomException("User not found", 400);
        }

        User user = userOpt.get();
        System.out.println("✅ User found: " + user.getEmail());

        String token = UUID.randomUUID().toString();
        PasswordResetToken resetToken = new PasswordResetToken();
        resetToken.setEmail(email);
        resetToken.setToken(token);
        resetToken.setExpiryDate(new Timestamp(System.currentTimeMillis() + 3600000));  // Token valid for 1 hour
        passwordResetTokenRepository.save(resetToken);

        // Send email with token
        sendResetEmail(user, token);
        return "Password reset email sent!";
    }

    // Reset Password using token
    public boolean verifyResetToken(String token) {
        Optional<PasswordResetToken> tokenOptional = passwordResetTokenRepository.findByToken(token);
        return tokenOptional.isPresent();
    }

    public String resetPassword(String token, String newPassword) {
        PasswordResetToken resetToken = passwordResetTokenRepository.findByToken(token)
                .orElseThrow(() -> new CustomException("Invalid or expired token", 400));

        if (resetToken.getExpiryDate().before(new Timestamp(System.currentTimeMillis()))) {
            throw new CustomException("Token has expired", 400);
        }

        User user = userRepository.findByEmail(resetToken.getEmail())
                .orElseThrow(() -> new CustomException("User not found", 400));

        // Update password
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);

        // Delete the token (once it's used)
        passwordResetTokenRepository.delete(resetToken);

        return "Password successfully reset!";
    }

    private void sendResetEmail(User user, String token) {
        String resetUrl = "http://localhost:9097/api/auth/reset-password?token=" + token;
        String subject = "Password Reset Request";
        String message = "Hello " + user.getName() + ",\n\n" +
                "To reset your password, click the link below:\n" +
                resetUrl +
                "\n\nIf you did not request a password reset, please ignore this email.";

        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setTo(user.getEmail());
        mailMessage.setSubject(subject);
        mailMessage.setText(message);
        mailMessage.setFrom("your_email@gmail.com");

        mailSender.send(mailMessage);
    }





//    private void trackFailedLogin(String email) {
//        loginAttempts.put(email, loginAttempts.getOrDefault(email, 0) + 1);
//        if (loginAttempts.get(email) >= 5) {
//            throw new CustomException("Account locked due to multiple failed login attempts.", HttpStatus.LOCKED.value());
//        }
//    }
@Autowired
private LoginAttemptRepository loginAttemptRepository;



    public void trackFailedLogin(String email) {
        LoginAttempt loginAttempt = loginAttemptRepository.findById(email)
                .orElse(new LoginAttempt(email));

        loginAttempt.setFailedAttempts(loginAttempt.getFailedAttempts() + 1);

        if (loginAttempt.getFailedAttempts() >= 5) {
            loginAttempt.setLocked(true);
            loginAttempt.setLockTime(new Timestamp(System.currentTimeMillis()));
            loginAttemptRepository.save(loginAttempt);
            throw new CustomException("Account locked due to multiple failed login attempts.", HttpStatus.LOCKED.value());
        } else {
            loginAttemptRepository.save(loginAttempt);
        }
    }


   public void resetFailedLoginAttempts(String email) {
        LoginAttempt loginAttempt = loginAttemptRepository.findById(email)
                .orElseThrow(() -> new CustomException("User not found", HttpStatus.BAD_REQUEST.value()));

        loginAttempt.setFailedAttempts(0);
        loginAttempt.setLocked(false);
        loginAttempt.setLockTime(null);
        loginAttemptRepository.save(loginAttempt);
    }
    public boolean isAccountLocked(LoginAttempt loginAttempt) {
        if (loginAttempt.isLocked()) {
            long lockDuration = 30 * 60 * 1000; // 30 minutes
            long timeSinceLock = System.currentTimeMillis() - loginAttempt.getLockTime().getTime();
            if (timeSinceLock > lockDuration) {
                // Unlock account after cooldown
                loginAttempt.setLocked(false);
                loginAttempt.setFailedAttempts(0);
                loginAttempt.setLockTime(null);
                loginAttemptRepository.save(loginAttempt);
                return false; // Account unlocked
            }
            return true; // Account still locked
        }
        return false; // Account not locked
    }

}

