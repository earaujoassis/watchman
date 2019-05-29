import React from 'react';

import './style.css';

const layout = props => {
  return (
    <div role="main" className="root-layout">
      {props.children}
    </div>
  );
};

export default layout;
