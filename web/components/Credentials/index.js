import React, { useEffect } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';

import * as actions from '../../actions';
import { SpinningSquare } from '../UI';
import { ListCredentials } from './ListCredentials';
import { Modal } from './Modal';

import './style.css';

const configuration = ({
  createCredential,
  fetchCredentials,
  inactivateCredential,
  internalSetModalDisplay,
  displayModal,
  loading,
  user = {},
  credentials = []
}) => {
  useEffect(() => {
    if (user.id) {
      fetchCredentials(user.id);
    }
  }, [user]);

  if (loading.includes('credential')) {
    return (
      <div className="credentials-root">
        <h2>Configuration &gt; Credentials</h2>
        <SpinningSquare />
      </div>
    );
  }

  return (
    <div className="credentials-root">
      <h2><Link to="/configuration">Configuration</Link> &gt; Credentials</h2>
      <div className="configuration-section">
        <div className="input-box">
          <button className="anchor" type="button" onClick={() => internalSetModalDisplay(true)}>
            Generate credential for agents or bots
          </button>
        </div>
        <ListCredentials
          inactivateCredential={inactivateCredential}
          credentials={credentials}
          user={user}
        />
        <Modal
          createCredential={createCredential}
          internalSetModalDisplay={internalSetModalDisplay}
          displayModal={displayModal}
          user={user}
        />
        <div className="input-box">
          <Link to="/configuration">Get back to configuration</Link>
        </div>
      </div>
    </div>
  );
};

const mapStateToProps = state => {
  return {
    credentials: state.root.credentials,
    displayModal: state.root.displayModal,
    loading: state.root.loading,
    user: state.root.user
  };
};

const mapDispatchToProps = dispatch => {
  return {
    createCredential: (userId, data) => dispatch(actions.createCredential(userId, data)),
    fetchCredentials: (id) => dispatch(actions.fetchCredentials(id)),
    inactivateCredential: (userId, credentialId) => dispatch(actions.inactivateCredential(userId, credentialId)),
    internalSetModalDisplay: (displayModal) => dispatch(actions.internalSetModalDisplay(displayModal))
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(configuration);
