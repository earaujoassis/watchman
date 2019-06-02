import React from 'react';

import './style.css';

const configuration = (props) => {
  return (
    <div className="configuration-root">
      <h2>Configuration</h2>
      <div className="configuration-section">
        <form onSubmit={(e) => { e.preventDefault(); }}>
          <div className="input-box">
            <label htmlFor="user_email">E-mail</label>
            <input type="email" id="user_email" />
          </div>
          <div className="input-box">
            <label htmlFor="github_token">GitHub Token</label>
            <input type="text" id="github_token" />
          </div>
          <button type="submit" className="button">Save</button>
        </form>
      </div>
    </div>
  );
};

export default configuration;
