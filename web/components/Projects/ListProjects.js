import React from 'react';

import { SpinningSquare } from '@common/UI';

export const ListProjects = ({ internalSetModalDisplay, setCurrentProject, currentProject, loading, projects }) => {
  if (loading.includes('project')) return <SpinningSquare />;

  return (
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
                    internalSetModalDisplay(true);
                  }}>
                  Setup GitOps project
                </button>
              </li>
            </ul>
          </div>
        </li>
      ))}
    </ul>
  );
};
