import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import Login from './components/Login';
import Register from './components/Register';
import VerifyEmail from './components/VerifyEmail';
import Dashboard from './components/Dashboard';
import ForgotPassword from './components/ForgotPassword';
import ResetPassword from './components/ResetPassword';
import VerifyResetToken from './components/VerifyResetToken';

const ProtectedRoute = ({ element }) => {
  const token = localStorage.getItem('token'); 
  return token ? element : <Navigate to="/login" replace />;
};

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
          
          <Route path="/dashboard" element={<ProtectedRoute element={<Dashboard />} />} />

          <Route path="/forgot-password" element={<ForgotPassword />} />
          <Route path="/reset-password" element={<ResetPassword />} />
          <Route path="/verify-reset-token" element={<VerifyResetToken />} />
        </Routes>
      </div>
    </Router>
  );
};

export default App;

