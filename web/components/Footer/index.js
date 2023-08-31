/* global Watchman */
import React from 'react';
import { connect } from 'react-redux';

import './style.css';

const Signout = ({ user }) => {
  if (user === null || user === undefined || user.error) {
    return (
      <p>((:</p>
    );
  }

  return (
    <p><a href="/signout">Sign-out</a></p>
  );
};

const footer = ({ user }) => {
  return (
    <div role="footer" className="footer-root">
      <div className="footer-division footer-left">
        <p>Copyright &copy; 2016-present, Ewerton Carlos Assis</p>
        <p>Watchman helps to keep track of automating services; a tiny continuous deployment service</p>
        <p>Application version v{Watchman.version} ({__COMMIT_HASH__})</p>
      </div>
      <div className="footer-division footer-right">
        <Signout user={user} />
      </div>
    </div>
  );
};

const mapStateToProps = state => {
  return {
    user: state.root.user
  };
};

export default connect(mapStateToProps)(footer);
