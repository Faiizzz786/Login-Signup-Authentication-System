package com.example.login_signup.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

import java.sql.Timestamp;
@Entity
public class LoginAttempt {



    @Id
    private String email;  
    private int failedAttempts;
    private boolean locked;
    private Timestamp lockTime;


    public LoginAttempt() {}


    public LoginAttempt(String email) {
        this.email = email;
        this.failedAttempts = 0;  
        this.locked = false;     
        this.lockTime = null;    
    }

    // Getters and Setters
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getFailedAttempts() {
        return failedAttempts;
    }

    public void setFailedAttempts(int failedAttempts) {
        this.failedAttempts = failedAttempts;
    }

    public boolean isLocked() {
        return locked;
    }

    public void setLocked(boolean locked) {
        this.locked = locked;
    }

    public Timestamp getLockTime() {
        return lockTime;
    }

    public void setLockTime(Timestamp lockTime) {
        this.lockTime = lockTime;
    }

}
