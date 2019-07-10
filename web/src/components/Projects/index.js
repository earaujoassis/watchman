import React, { useEffect, useState } from 'react';
import { connect } from 'react-redux';
import Select from 'react-select';
import Files from 'react-files';
import Blob from 'blob';

import * as actions from '../../actions';
import { extractDataForm } from '../../utils';
import { formatGroupLabel } from '../../utils/select-styles';
import { SpinningSquare } from '../UI';

import './style.css';

const projects = ({ fetchProjects, fetchServers, createApplication, loading, user, projects = [], applications = [], servers = [] }) => {
  const [displayModal, setDisplayModal] = useState(false);
  const [currentProject, setCurrentProject] = useState(false);
  const [selectedServerId, setSelectedServerId] = useState(null);
  const [selectedFiles, setSelectedFiles] = useState([]);

  const serversOptions = servers.map(s => { return { value: s.id, label: s.hostname }; });

  useEffect(() => {
    if (user) {
      fetchProjects(user.id);
      fetchServers();
    }
  }, [user]);

  useEffect(() => {
    if (applications && applications.length && currentProject) {
      const selected = applications.filter((app) => app.full_name === currentProject.full_name);
      if (selected.length > 0) {
        setDisplayModal(false);
        setSelectedServerId(null);
        setSelectedFiles([]);
      }
    }
  }, [applications]);

  return (
    <div className="projects-root">
      <h2>Projects</h2>
      {loading.includes('project') ? <SpinningSquare /> : (
        <ul className="projects-list">
          {projects.map((project, i) => (
            <li key={i}>
              <div className="project-box">
                <h3 className="project-title"><a href={project.html_url}>{project.full_name}</a></h3>
                <p className="project-description">{project.description}</p>
                <ul className="project-actions">
                  <li>
                    <button className="anchor"
                      onClick={e => {
                        e.preventDefault();
                        setCurrentProject(project);
                        setDisplayModal(true);
                      }}>
                      Deploy project
                    </button>
                  </li>
                </ul>
              </div>
            </li>
          ))}
        </ul>
      )}
      {displayModal && (
        <div className="global-modal-container">
          <div className="global-modal-overlay"></div>
          <div className="global-modal-box">
            <div className="global-modal-box-body">
              <button
                onClick={e => {
                  e.preventDefault();
                  setCurrentProject(null);
                  setDisplayModal(false);
                }}
                className="global-modal-close">&times;</button>
              <h2>{currentProject.full_name}</h2>
              <p>
                In order to deploy the selected project, you must select which server it should be deployed to
                and what is the process name under the <span className="code">docker-compose.yml</span> file.
                For every new deployment, the following commands will be executed: <span className="code">docker-compose up -d --build</span>.
                For every re-deployment (to update containers), the following commands will be executed: <span className="code">docker-compose build watchman</span> and <span className="code">docker-compose up --no-deps -d watchman</span>
              </p>
              <p>
                Every deployment happens once the server does a notification. It will receive a payload with
                actions to perform (including but not limited to deployments). If the server doesn't notify,
                no deployment will happen. All deployments are based over the <span className="code">master</span> branch.
              </p>
              <form
                className="global-modal-form"
                onSubmit={(e) => {
                  e.preventDefault();
                  const file = selectedFiles[0] || {};
                  const formData = new FormData();
                  formData.append('application[full_name]', currentProject.full_name);
                  formData.append('application[description]', currentProject.description);
                  formData.append('application[server_id]', selectedServerId);
                  formData.append('application[process_name]', extractDataForm(e.target, ['process']).process);
                  formData.append('application[configuration_file_name]', file.name);
                  formData.append('application[configuration_file]', new Blob([file], { type: file.type }), file.name);
                  createApplication(user.id, formData);
                }}>
                <div className="input-box">
                  <label htmlFor="process">Process name under <span className="code">docker-compose.yml</span></label>
                  <input type="text" id="process" name="process" required />
                </div>
                <div className="input-box selector">
                  <label htmlFor="servers">Servers</label>
                  <Select
                    options={serversOptions}
                    formatGroupLabel={formatGroupLabel}
                    onChange={o => setSelectedServerId(o.value)}
                    required
                  />
                </div>
                <div className="input-box">
                  <label htmlFor="servers">Configuration files</label>
                  <Files
                    className="files-dropzone"
                    onChange={f => setSelectedFiles(f)}
                    onError={(e) => console.warn(e)}
                    multiple={false}
                    maxFiles={1}
                    maxFileSize={1500}
                    minFileSize={0}
                    clickable
                    required>
                    Drop a file to be included under the project root (max 1 file)
                  </Files>
                  {selectedFiles.length > 0 ? (
                    <div className="files-selected">
                      <p>File selected: {selectedFiles.map((file, i) => <span key={i}><span className="code">{file.name}</span> ({file.sizeReadable}) {selectedFiles.length > i + 1 ? (<span> &amp; </span>) : null}</span>)}</p>
                    </div>
                  ) : null}
                </div>
                <button type="submit" className="button">Create deployment</button>
              </form>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

const mapStateToProps = state => {
  return {
    loading: state.root.loading,
    user: state.root.user,
    projects: state.root.projects,
    applications: state.root.applications,
    servers: state.root.servers
  };
};

const mapDispatchToProps = dispatch => {
  return {
    fetchProjects: (id) => dispatch(actions.fetchProjects(id)),
    fetchServers: () => dispatch(actions.fetchServers()),
    createApplication: (id, data) => dispatch(actions.createApplication(id, data))
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(projects);
