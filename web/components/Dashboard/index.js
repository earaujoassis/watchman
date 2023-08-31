import React from 'react';
import { connect } from 'react-redux';

import { SpinningSquare } from '@common/UI';

import './style.css';

const dashboard = ({ loading, user = {} }) => {
  if (loading.includes('dashboard')) {
    return (
      <div className="applications-root">
        <h2>Applications</h2>
        <SpinningSquare />
      </div>
    );
  }

  return (
    <div className="dashboard-root">
      <h2>Dashboard</h2>
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
  return {};
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(dashboard);
