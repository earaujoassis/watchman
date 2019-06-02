import React from 'react';

import './style.css';

const terminal = (props) => {
  return (
    <div className="terminal-root">
      <span className="terminal-status" title="Active"></span>
      <i className="fas fa-greater-than"></i>
    </div>
  );
};

export default terminal;
