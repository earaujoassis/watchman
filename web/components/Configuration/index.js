import React, { useState } from 'react';
import { connect } from 'react-redux';

import * as actions from '../../actions';
import { extractDataForm } from '../../utils';

import './style.css';

const defaultConfiguration = ({ internalSetConfigurationDisplayMode, user = {} }) => {
  return (
    <div className="configuration-root">
      <h2>Configuration</h2>
      <div className="configuration-section">
        <div className="input-box">
          <span className="label">E-mail</span>
          <span className="input">{user.email}</span>
        </div>
        <div className="input-box">
          <span className="label">GitHub Token</span>
          <span className="input">{user.github_token}</span>
        </div>
        <div className="input-box">
          <a href={`/api/users/${user.id}/credentials`}
            title="It regenerates the client's key &amp; secret for security reasons"
            rel="noopener noreferrer"
            target="_blank"
          >
            Download credentials for agents
          </a>
        </div>
        <div className="input-box">
          <button
            type="button"
            className="anchor"
            onClick={() => internalSetConfigurationDisplayMode('editable')}
          >
            Update GitHub Token
          </button>
        </div>
      </div>
    </div>
  );
};

const editableConfiguration = ({ internalSetConfigurationDisplayMode, updateUser, user = {}, loading }) => {
  return (
    <div className="configuration-root">
      <h2>Configuration</h2>
      <div className="configuration-section">
        <form onSubmit={(e) => {
          e.preventDefault();
          const data = { user: extractDataForm(e.target, ['github_token', 'password_confirmation']) };
          updateUser(user.id, data);
        }}>
          <div className="input-box">
            <span className="label">E-mail</span>
            <span className="input">{user.email}</span>
          </div>
          <div className="input-box">
            <label htmlFor="user_github_token">GitHub Token</label>
            <input type="text" id="user_github_token" name="github_token" />
          </div>
          <div className="input-box">
            <label htmlFor="user_password_confirmation">Confirm password</label>
            <input type="password" id="user_password_confirmation" name="password_confirmation" />
          </div>
          <button type="submit" className="button" disabled={loading.includes('user')}>Save</button>
          <div className="input-box">
            <button
              type="button"
              className="anchor"
              onClick={() => internalSetConfigurationDisplayMode('default')}
            >
              Cancel
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

const configuration = ({ updateUser, internalSetConfigurationDisplayMode, user = {}, displayMode, loading }) => {
  if (displayMode.mode === 'editable') return editableConfiguration({ internalSetConfigurationDisplayMode, updateUser, user, loading });
  else return defaultConfiguration({ internalSetConfigurationDisplayMode, user });
};

const mapStateToProps = state => {
  return {
    user: state.root.user,
    displayMode: state.root.configurationMode,
    loading: state.root.loading
  };
};

const mapDispatchToProps = dispatch => {
  return {
    updateUser: (id, data) => dispatch(actions.updateUser(id, data)),
    internalSetConfigurationDisplayMode: (mode) => dispatch(actions.internalSetConfigurationDisplayMode(mode))
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(configuration);
