/* global Watchman */
import React from 'react';

import './style.css';

const footer = () => {
  return (
    <div role="footer" className="footer-root">
      <p>Copyright &copy; 2016-present, Ewerton Carlos Assis</p>
      <p>Watchman helps to keep track of automating services; a tiny continuous deployment service</p>
      <p>Application version v{Watchman.version} ({Watchman.commitHash})</p>
    </div>
  );
};

export default footer;
