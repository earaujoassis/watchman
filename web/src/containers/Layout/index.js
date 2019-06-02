import React from 'react';

import Header from '@components/Header';
import Menu from '@components/Menu';
import Footer from '@components/Footer';
import Terminal from '@components/Terminal';

import './style.css';

const layout = ({ children }) => {
  return (
    <div role="main" className="layout-root">
      <Menu />
      <div className="layout-root__corpus">
        <Header />
        <div className="layout-root__siblings">
          <div className="layout-root__corpus">
            {children}
            <Footer />
          </div>
          <Terminal />
        </div>
      </div>
    </div>
  );
};

export default layout;
