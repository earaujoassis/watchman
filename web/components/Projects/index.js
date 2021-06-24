import React, { useEffect, useState } from 'react';
import { connect } from 'react-redux';

import * as actions from '@actions';
import { ListProjects } from './ListProjects';
import { Modal } from './Modal';

import './style.css';

const projects = ({
  fetchProjects,
  createApplication,
  internalSetModalDisplay,
  loading,
  user = {},
  projects = [],
  applications = [],
  displayModal
}) => {
  const [currentProject, setCurrentProject] = useState(false);

  useEffect(() => {
    if (user.id) {
      fetchProjects(user.id);
    }
  }, [user]);

  return (
    <div className="projects-root">
      <h2>Projects</h2>
      <ListProjects
        internalSetModalDisplay={internalSetModalDisplay}
        setCurrentProject={setCurrentProject}
        currentProject={currentProject}
        loading={loading}
        projects={projects}
      />
      <Modal
        createApplication={createApplication}
        internalSetModalDisplay={internalSetModalDisplay}
        setCurrentProject={setCurrentProject}
        currentProject={currentProject}
        user={user}
        displayModal={displayModal}
        applications={applications} />
    </div>
  );
};

const mapStateToProps = state => {
  return {
    loading: state.root.loading,
    user: state.root.user,
    projects: state.root.projects,
    applications: state.root.applications,
    displayModal: state.root.displayModal
  };
};

const mapDispatchToProps = dispatch => {
  return {
    fetchProjects: (id) => dispatch(actions.fetchProjects(id)),
    createApplication: (id, data) => dispatch(actions.createApplication(id, data)),
    internalSetModalDisplay: (display) => dispatch(actions.internalSetModalDisplay(display))
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(projects);
