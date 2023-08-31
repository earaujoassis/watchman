import React from 'react';
import { Link } from 'react-router-dom';

import './style.css';

const menu = () => {
  return (
    <div role="menu" className="menu-root">
      <ul className="menu-list">
        <li>
          <Link to="/dashboard" title="Dashboard"><i className="fas fa-solid fa-chart-line"></i></Link>
        </li>
        <li>
          <Link to="/configuration" title="Configuration"><i className="fas fa-cog"></i></Link>
        </li>
        <li>
          <Link to="/projects" title="GitHub Projects"><i className="fab fa-github"></i></Link>
        </li>
        <li>
          <Link to="/applications" title="Applications"><i className="fas fa-rocket"></i></Link>
        </li>
        <li>
          <Link to="/servers" title="Servers"><i className="fas fa-server"></i></Link>
        </li>
        <li>
          <Link to="/reports" title="Reports"><i className="fas fa-file-medical-alt"></i></Link>
        </li>
      </ul>
    </div>
  );
};

export default menu;
