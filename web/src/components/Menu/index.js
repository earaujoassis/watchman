import React from 'react';

import './style.css';

const menu = () => {
  return (
    <div role="menu" className="menu-root">
      <ul className="menu-list">
        <li>
          <a href="/projects" title="GitHub Projects"><i className="fab fa-github"></i></a>
        </li>
        <li>
          <a href="/configuration" title="Configuration"><i className="fas fa-cog"></i></a>
        </li>
        <li>
          <a href="/" title="Applications"><i className="fas fa-server"></i></a>
        </li>
      </ul>
    </div>
  );
};

export default menu;
