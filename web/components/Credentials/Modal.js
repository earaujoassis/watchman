import React from 'react';

import { extractDataForm } from '@utils/forms';

export const Modal = ({
  createCredential,
  internalSetModalDisplay,
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
                internalSetModalDisplay(false);
              }}
              className="global-modal-close">&times;</button>
            <h2>Create a new credential</h2>
            <p>
              Please confirm your password to create a new credential. If you loose or change your password, all your previously
              created credentials will be inactivated.
            </p>
            <form
              className="global-modal-form"
              onSubmit={(e) => {
                e.preventDefault();
                const data = {
                  user: extractDataForm(e.target, ['passphrase_confirmation']),
                  credential: extractDataForm(e.target, ['description'])
                };
                createCredential(user.id, data);
              }}>
              <div className="input-box">
                <label htmlFor="description">Usage description</label>
                <input type="text" maxLength={20} id="description" name="description" required />
              </div>
              <div className="input-box">
                <label htmlFor="user_passphrase_confirmation">Confirm password</label>
                <input type="password" required minLength="16" id="user_passphrase_confirmation" name="passphrase_confirmation" />
              </div>
              <button type="submit" className="button">Create credential</button>
            </form>
          </div>
        </div>
      </div>
    );
  }

  return null;
};
