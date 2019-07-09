/* global Watchman */
import React from 'react';

import './style.css';

const footer = () => {
  return (
    <div role="footer" className="footer-root">
      <p>Copyright &copy; 2016-present, Ewerton Carlos Assis</p>
      <p>Watchman helps keep track of GitHub projects; a tiny continuous deployment service</p>
      <p>Application version v{Watchman.version}</p>
    </div>
  );
};

export default footer;
