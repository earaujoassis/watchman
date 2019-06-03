import React from 'react';

import './style.css';

const applications = (props) => {
  return (
    <div className="applications-root">
      <h2>Applications</h2>
      <p className="application-name">Space</p>
      <div className="application-box">
        <span className="app-square app-normal"></span>
        <span className="app-square app-normal"></span>
        <span className="app-square app-normal"></span>
        <span className="app-square app-normal"></span>
      </div>
    </div>
  );
};

export default applications;
