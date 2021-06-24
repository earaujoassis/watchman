import React from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';

import * as actions from '@actions';
import { extractDataForm } from '@utils/forms';

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
          <span className="input">(information unavailable)</span>
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
        <div className="input-box">
          <Link to="/configuration/credentials">Manage credentials</Link>
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
          const data = { user: extractDataForm(e.target, ['github_token', 'passphrase_confirmation']) };
          updateUser(user.id, data);
        }}>
          <div className="input-box">
            <span className="label">E-mail</span>
            <span className="input">{user.email}</span>
          </div>
          <div className="input-box">
            <label htmlFor="user_github_token">GitHub Token</label>
            <input type="text" required id="user_github_token" name="github_token" />
          </div>
          <div className="input-box">
            <label htmlFor="user_passphrase_confirmation">Confirm password</label>
            <input type="password" required minLength="16" id="user_passphrase_confirmation" name="passphrase_confirmation" />
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
