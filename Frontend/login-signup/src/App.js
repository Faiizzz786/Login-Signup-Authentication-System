import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import Login from './components/Login';
import Register from './components/Register';
import VerifyEmail from './components/VerifyEmail';
import Dashboard from './components/Dashboard';
import ForgotPassword from './components/ForgotPassword';
import ResetPassword from './components/ResetPassword';
import VerifyResetToken from './components/VerifyResetToken';

const App = () => {
  return (
    <Router>
      <div className="min-h-screen bg-gray-100 flex flex-col justify-center py-12 px-6 lg:px-8">
        <div className="sm:mx-auto sm:w-full sm:max-w-md mb-8">
          <h1 className="text-center text-3xl font-extrabold text-gray-900">
            
          </h1>
        </div>
        
        <Routes>
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
          <Route path="/verify-email" element={<VerifyEmail />} />
          <Route path="/" element={<Navigate replace to="/login" />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/forgot-password" element={<ForgotPassword />} />
          <Route path="/reset-password" element={<ResetPassword />} />
          <Route path="/verify-reset-token" element={<VerifyResetToken />} />
        </Routes>
      </div>
    </Router>
  );
};

export default App;

// import React, { useEffect, useState } from 'react';
// import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
// import Login from './components/Login';
// import Register from './components/Register';
// import VerifyEmail from './components/VerifyEmail';
// import Dashboard from './components/Dashboard';

// const App = () => {
//   const [isAuthenticated, setIsAuthenticated] = useState(false);
//   const [isLoading, setIsLoading] = useState(true);

//   // Effect to check for token when app loads
//   useEffect(() => {
//     const token = localStorage.getItem('authToken');
//     setIsAuthenticated(!!token);
//     setIsLoading(false);
//   }, []);

//   // This function is no longer needed as Login handles this directly
//   // It's kept for any other components that might need it
//   const login = (token) => {
//     localStorage.setItem('authToken', token);
//     setIsAuthenticated(true);
//   };

//   const logout = () => {
//     localStorage.removeItem('authToken');
//     setIsAuthenticated(false);
//   };

//   if (isLoading) {
//     return <div className="flex items-center justify-center min-h-screen">Loading...</div>;
//   }

//   return (
//     <Router>
//       <div className="min-h-screen bg-gray-100 flex flex-col justify-center py-12 px-6 lg:px-8">
//         <Routes>
//           {/* Public Routes */}
//           <Route path="/register" element={<Register />} />
//           <Route path="/verify-email" element={<VerifyEmail />} />

//           {/* Authentication Handling - Removed onLogin prop since Login component doesn't use it */}
//           <Route 
//             path="/login" 
//             element={isAuthenticated ? <Navigate replace to="/dashboard" /> : <Login />} 
//           />

//           {/* Protected Routes */}
//           <Route 
//             path="/dashboard" 
//             element={isAuthenticated ? <Dashboard onLogout={logout} /> : <Navigate replace to="/login" />} 
//           />

//           {/* Redirect root to appropriate page */}
//           <Route path="/" element={<Navigate replace to={isAuthenticated ? "/dashboard" : "/login"} />} />
//         </Routes>
//       </div>
//     </Router>
//   );
// };

// export default App;