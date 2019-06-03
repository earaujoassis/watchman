import React from 'react';

import './style.css';

const terminal = (props) => {
  return (
    <div className="terminal-root">
      <span className="terminal-status" title="Active"></span>
      <p><i className="fas fa-angle-right"></i> whoami</p>
      <p>watchman</p>
    </div>
  );
};

export default terminal;
