import React from 'react';
import { Link } from 'react-router-dom';

import './style.css';

const menu = () => {
  return (
    <div role="menu" className="menu-root">
      <ul className="menu-list">
        <li>
          <Link to="/projects" title="GitHub Projects"><i className="fab fa-github"></i></Link>
        </li>
        <li>
          <Link to="/configuration" title="Configuration"><i className="fas fa-cog"></i></Link>
        </li>
        <li>
          <Link to="/" title="Applications"><i className="fas fa-server"></i></Link>
        </li>
      </ul>
    </div>
  );
};

export default menu;
