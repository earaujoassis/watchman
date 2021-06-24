import React from 'react';

import { extractDataForm } from '@utils/forms';

export const Modal = ({
  createApplication,
  internalSetModalDisplay,
  setCurrentProject,
  currentProject,
  displayModal = false,
  user
}) => {
  if (displayModal) {
    return (
      <div className="global-modal-container">
        <div className="global-modal-overlay"></div>
        <div className="global-modal-box">
          <div className="global-modal-box-body">
            <button
              onClick={e => {
                e.preventDefault();
                setCurrentProject(null);
                internalSetModalDisplay(false);
              }}
              className="global-modal-close">&times;</button>
            <h2>{currentProject.full_name}</h2>
            <p>
              In order to setup the selected project as a GitOps project, you must define where the deployable charts are located (top-level folder).
              For every new deployment triggered by an agent/robot, a given project under the charts top-level folder will be updated accordingly.
              It is important to name all projects managed through the GitOps project, to avoid any problem.
            </p>
            <p>
              Every deployment happens once an agent/robot sends a notification. It will receive a payload with
              actions to perform (including but not limited to deployments). If any agent/robot doesn&apos;t notify,
              no deployment will happen.
            </p>
            <form
              className="global-modal-form"
              onSubmit={(e) => {
                e.preventDefault();
                const formData = new FormData();
                formData.append('application[full_name]', currentProject.full_name);
                formData.append('application[description]', currentProject.description);
                formData.append('application[managed_realm]', extractDataForm(e.target, ['managed_realm']).managed_realm);
                formData.append('application[managed_projects]', extractDataForm(e.target, ['managed_projects']).managed_projects);
                createApplication(user.id, formData);
              }}>
              <div className="input-box">
                <label htmlFor="managed_realm">Deployable charts top-level folder</label>
                <input type="text" id="managed_realm" name="managed_realm" required />
              </div>
              <div className="input-box">
                <label htmlFor="managed_projects">Managed projects</label>
                <textarea id="managed_projects" name="managed_projects"></textarea>
              </div>
              <button type="submit" className="button">Setup project</button>
            </form>
          </div>
        </div>
      </div>
    );
  }

  return null;
};
