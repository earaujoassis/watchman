import React, { useEffect } from 'react';
import { connect } from 'react-redux';

import * as actions from '@actions';
import { extractDataForm } from '@utils/forms';
import { SpinningSquare } from '@common/UI';
import EmptyCorpus from '@components/EmptyCorpus';

import './style.css';

const root = ({ children, loading, user, fetchUser, createUser, subscribeUser }) => {
  useEffect(() => {
    fetchUser();
    subscribeUser();
  }, []);

  if (loading.includes('server') && !user) {
    return <div className="galaxy-center"><SpinningSquare /></div>;
  }

  if (user === null || user === undefined || user.error) {
    return (
      <div className="userRealm-root">
        {
          // children
        }
        <EmptyCorpus />
        <div>
          <div className="userRealm-creation-overlay global-modal-overlay"></div>
          <div className="userRealm-creation-box global-modal-box">
            <h2>Master user: login through OAuth 2 provider</h2>
            <p>
              First, you must associate the master user with your account in the Identity Provider
              (OAuth 2 provider). Please follow the link below to authorize the application.
            </p>
            <a href="/signin" className="button">Sign-in</a>
          </div>
        </div>
      </div>
    );
  }

  if (!user.is_user_complete) {
    return (
      <div className="userRealm-root">
        {
          // children
        }
        <EmptyCorpus />
        <div>
          <div className="userRealm-creation-overlay global-modal-overlay"></div>
          <div className="userRealm-creation-box global-modal-box">
            <h2>Master user creation: GitHub token</h2>
            <p>
              In order to use this application, you must create a master user with
              your <a href="https://github.com/settings/tokens/new">GitHub Token</a> with
              the following access scopes:
            </p>
            <ul className="userRealm-scopes-list">
              <li>
                <span className="monospace">repo</span> <span>(Full control of private repositories)</span>
                <ul>
                  <li className="monospace">repo:status</li>
                  <li className="monospace">repo_deployment</li>
                  <li className="monospace">public_repo</li>
                  <li className="monospace">repo:invite</li>
                  <li className="monospace">security_events</li>
                </ul>
              </li>
              <li>
                <span className="monospace">user</span>
                <ul>
                  <li className="monospace">read:user</li>
                  <li className="monospace">user:email</li>
                </ul>
              </li>
            </ul>
            <form onSubmit={(e) => {
              e.preventDefault();
              const data = { user: extractDataForm(e.target, ['github_token', 'passphrase']) };
              createUser(data);
            }}>
              <div className="input-box">
                <label htmlFor="user_passphrase">Password</label>
                <input type="password" required minLength="16" id="user_passphrase" name="passphrase" />
              </div>
              <div className="input-box">
                <label htmlFor="user_github_token">GitHub Token</label>
                <input type="text" required id="user_github_token" name="github_token" />
              </div>
              <button type="submit" className="button">Save</button>
            </form>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="userRealm-root">
      {children}
    </div>
  );
};

const mapStateToProps = state => {
  return {
    loading: state.root.loading,
    user: state.root.user
  };
};

const mapDispatchToProps = dispatch => {
  return {
    fetchUser: () => dispatch(actions.fetchUser()),
    createUser: (data) => dispatch(actions.createUser(data)),
    subscribeUser: () => dispatch(actions.subscribeUser())
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(root);
