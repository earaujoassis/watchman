import React from 'react';
import { withRouter } from 'react-router-dom';

import Header from '@components/Header';
import Menu from '@components/Menu';
import Footer from '@components/Footer';
import UserRealm from '@components/UserRealm';
import Terminal from '@components/Terminal';
import Toast from '@components/Toast';

import './style.css';

const withTerminal = (path) => {
  return [
    '/configuration',
    '/projects',
    '/applications',
    '/servers'
  ].includes(path);
};

const layout = ({ children, location }) => {
  return (
    <UserRealm>
      <div role="main" className="layout-root">
        <Menu />
        <div className="layout-root__corpus">
          <Header />
          <div className="layout-root__siblings">
            <div className="layout-root__corpus">
              {children}
              <Footer />
            </div>
            {withTerminal(location.pathname) ? <Terminal /> : null}
            <Toast />
          </div>
        </div>
      </div>
    </UserRealm>
  );
};

export default withRouter(layout);
