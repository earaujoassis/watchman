import React from 'react';

import './style.css';

const layout = ({ children }) => {
  return (
    <div role="main" className="layout-root">
      {children}
    </div>
  );
};

export default layout;
