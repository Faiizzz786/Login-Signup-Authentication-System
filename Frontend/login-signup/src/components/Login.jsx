import React, { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { loginUser } from '../api';
import FormField from './FormField';

const Login = () => {
  const [formData, setFormData] = useState({ email: '', password: '' });
  const [errors, setErrors] = useState({});
  const [isLoading, setIsLoading] = useState(false);
  const [isLocked, setIsLocked] = useState(false);
  const [remainingTime, setRemainingTime] = useState(0);

  const navigate = useNavigate();

  useEffect(() => {
    let timer;
    if (isLocked && remainingTime > 0) {
      timer = setInterval(() => {
        setRemainingTime((prev) => {
          if (prev <= 1000) {
            clearInterval(timer);
            setIsLocked(false);
            return 0;
          }
          return prev - 1000;
        });
      }, 1000);
    }
    return () => clearInterval(timer);
  }, [isLocked, remainingTime]);

  const formatTime = () => {
    if (remainingTime >= 60000) {
      return `${Math.floor(remainingTime / 60000)} min`;
    } else {
      return `${Math.ceil(remainingTime / 1000)} sec`;
    }
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });

    if (errors[name]) {
      setErrors({ ...errors, [name]: '' });
    }
  };

  const validateForm = () => {
    const newErrors = {};
    if (!formData.email) newErrors.email = 'Email is required';
    if (!formData.password) newErrors.password = 'Password is required';
    return newErrors;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    const formErrors = validateForm();
    if (Object.keys(formErrors).length > 0) {
      setErrors(formErrors);
      return;
    }

    setIsLoading(true);
    setErrors({});

    try {
      const response = await loginUser(formData.email, formData.password);

      if (response.locked) {
        
        setIsLocked(true);
        setRemainingTime(response.remainingTime);
        setErrors({ submit: "Your account is locked. Try again later." });
      } else {
        localStorage.setItem('token', response.token);
        navigate('/dashboard');
      }
    } catch (error) {
      setErrors({ submit: error.message });
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="container mt-5">
      <div className="row justify-content-center">
        <div className="col-md-6">
          <div className="card p-4 shadow-sm">
            <h2 className="card-title text-center mb-4">Login to Your Account</h2>

            {errors.submit && !isLocked && (
              <div className="alert alert-danger">{errors.submit}</div>
            )}

            {isLocked && remainingTime > 0 && (
              <div className="alert alert-warning text-center">
                Your account is locked. Try again in <strong>{formatTime()}</strong>.
              </div>
            )}

            <form onSubmit={handleSubmit}>
              <FormField
                label="Email"
                type="email"
                id="email"
                value={formData.email}
                onChange={handleChange}
                error={errors.email}
                required
              />

              <FormField
                label="Password"
                type="password"
                id="password"
                value={formData.password}
                onChange={handleChange}
                error={errors.password}
                required
              />

              <div className="d-flex justify-content-end mb-3">
                <Link to="/forgot-password" className="text-primary">
                  Forgot password?
                </Link>
              </div>

              <button
                type="submit"
                className="btn btn-primary w-100"
                disabled={isLoading || isLocked}
              >
                {isLoading ? 'Logging in...' : 'Login'}
              </button>
            </form>

            <p className="mt-3 text-center">
              Don't have an account? <Link to="/register" className="text-primary">Register</Link>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Login;





// import React, { useState, useEffect } from 'react';
// import { Link, useNavigate } from 'react-router-dom';
// import { loginUser } from '../api';
// import FormField from './FormField';

// const Login = () => {
//   const [formData, setFormData] = useState({ email: '', password: '' });
//   const [errors, setErrors] = useState({});
//   const [isLoading, setIsLoading] = useState(false);
//   const [isLocked, setIsLocked] = useState(false);
//   const [remainingTime, setRemainingTime] = useState(0);

//   const navigate = useNavigate();

//   useEffect(() => {
//     let timer;
//     if (isLocked && remainingTime > 0) {
//       timer = setInterval(() => {
//         setRemainingTime((prev) => {
//           if (prev <= 1000) {
//             clearInterval(timer);
//             setIsLocked(false);
//             return 0;
//           }
//           return prev - 1000;
//         });
//       }, 1000);
//     }
//     return () => clearInterval(timer);
//   }, [isLocked, remainingTime]);

//   const formatTime = () => {
//     if (remainingTime >= 60000) {
//       return `${Math.floor(remainingTime / 60000)} min`;
//     } else {
//       return `${Math.ceil(remainingTime / 1000)} sec`;
//     }
//   };

//   const handleChange = (e) => {
//     const { name, value } = e.target;
//     setFormData({ ...formData, [name]: value });

//     if (errors[name]) {
//       setErrors({ ...errors, [name]: '' });
//     }
//   };

//   const validateForm = () => {
//     const newErrors = {};
//     if (!formData.email) newErrors.email = 'Email is required';
//     if (!formData.password) newErrors.password = 'Password is required';
//     return newErrors;
//   };

//   const handleSubmit = async (e) => {
//     e.preventDefault();
    
//     const formErrors = validateForm();
//     if (Object.keys(formErrors).length > 0) {
//       setErrors(formErrors);
//       return;
//     }

//     setIsLoading(true);
//     setErrors({});

//     try {
//       const response = await loginUser(formData.email, formData.password);

//       if (response.locked) {
//         setIsLocked(true);
//         setRemainingTime(response.remainingTime);
//         setErrors({ submit: "Your account is locked. Try again later." });
//       } else {
//         // Important: Store the auth token in localStorage
//         if (response.token) {
//           localStorage.setItem('authToken', response.token);
//         }
//         navigate('/dashboard');
//       }
//     } catch (error) {
//       setErrors({ submit: error.message });
//     } finally {
//       setIsLoading(false);
//     }
//   };

//   return (
//     <div className="container mt-5">
//       <div className="row justify-content-center">
//         <div className="col-md-6">
//           <div className="card p-4 shadow-sm">
//             <h2 className="card-title text-center mb-4">Login to Your Account</h2>

//             {errors.submit && !isLocked && (
//               <div className="alert alert-danger">{errors.submit}</div>
//             )}

//             {isLocked && remainingTime > 0 && (
//               <div className="alert alert-warning text-center">
//                 Your account is locked. Try again in <strong>{formatTime()}</strong>.
//               </div>
//             )}

//             <form onSubmit={handleSubmit}>
//               <FormField
//                 label="Email"
//                 type="email"
//                 id="email"
//                 name="email" // Added name attribute to match handleChange
//                 value={formData.email}
//                 onChange={handleChange}
//                 error={errors.email}
//                 required
//               />

//               <FormField
//                 label="Password"
//                 type="password"
//                 id="password"
//                 name="password" // Added name attribute to match handleChange
//                 value={formData.password}
//                 onChange={handleChange}
//                 error={errors.password}
//                 required
//               />

//               <div className="d-flex justify-content-end mb-3">
//                 <Link to="/forgot-password" className="text-primary">
//                   Forgot password?
//                 </Link>
//               </div>

//               <button
//                 type="submit"
//                 className="btn btn-primary w-100"
//                 disabled={isLoading || isLocked}
//               >
//                 {isLoading ? 'Logging in...' : 'Login'}
//               </button>
//             </form>

//             <p className="mt-3 text-center">
//               Don't have an account? <Link to="/register" className="text-primary">Register</Link>
//             </p>
//           </div>
//         </div>
//       </div>
//     </div>
//   );
// };

// export default Login;




