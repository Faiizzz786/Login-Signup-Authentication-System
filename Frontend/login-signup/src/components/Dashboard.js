// import React from 'react';

// const Dashboard = () => {
//   return (
//     <div className="container mt-5">
//       <div className="row justify-content-center">
//         <div className="col-md-8">
//           <div className="card p-4 shadow-sm text-center">
//             <h1 className="card-title">Welcome to Your Dashboard!</h1>
//             <p className="text-muted mt-3">
//               You have successfully logged in.
//             </p>
//           </div>
//         </div>
//       </div>
//     </div>
//   );
// };

// export default Dashboard;


import React from 'react';
import { useNavigate } from 'react-router-dom';

const Dashboard = () => {
  const navigate = useNavigate();

  const handleLogout = () => {
    localStorage.removeItem('token'); // Remove token from storage
    navigate('/login'); // Redirect to login page
  };

  return (
    <div className="container mt-5">
      <div className="row justify-content-center">
        <div className="col-md-8">
          <div className="card p-4 shadow-sm text-center">
            <h1 className="card-title">Welcome to Your Dashboard!</h1>
            <p className="text-muted mt-3">
              You have successfully logged in.
            </p>
            <button className="btn btn-danger mt-3" onClick={handleLogout}>
              Logout
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
