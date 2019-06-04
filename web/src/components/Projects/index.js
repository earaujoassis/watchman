import React, { useEffect } from 'react';
import { connect } from 'react-redux';

import * as actions from '../../actions';
import { SpinningSquare } from '../UI';

import './style.css';

const projects = ({ fetchProjects, loading, user, projects = [] }) => {
  useEffect(() => {
    if (user) {
      fetchProjects(user.id);
    }
  }, [user]);

  return (
    <div className="projects-root">
      <h2>Projects</h2>
      {loading ? <SpinningSquare /> : (
        <ul className="projects-list">
          {projects.map((project, i) => (
            <li key={i}>
              <div className="project-box">
                <h3 className="project-title"><a href={project.html_url}>{project.full_name}</a></h3>
                <p className="project-description">{project.description}</p>
                <ul className="project-actions">
                  <li><button className="anchor">Deploy project</button></li>
                </ul>
              </div>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
};

const mapStateToProps = state => {
  return {
    loading: state.root.loading,
    user: state.root.user,
    projects: state.root.projects
  };
};

const mapDispatchToProps = dispatch => {
  return {
    fetchProjects: (id, data) => dispatch(actions.fetchProjects(id, data))
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(projects);
