import React from 'react';

const CredentialAction = ({ inactivateCredential, credential, user }) => {
  if (credential.is_active) {
    return (
      <button
        className="anchor"
        type="button"
        onClick={() => inactivateCredential(user.id, credential.id)}
      >
        Make inactive
      </button>
    );
  }

  return null;
};

export const ListCredentials = ({ inactivateCredential, credentials, user }) => {
  if (!credentials.length) {
    return null;
  }

  return (
    <table cellPadding="0" cellSpacing="0">
      <thead>
        <tr>
          <th scope="col">Client key</th>
          <th scope="col">Description</th>
          <th scope="col">Current state</th>
          <th scope="col">Actions</th>
        </tr>
      </thead>
      <tbody>
        {credentials.map((credential, i) => (
          <tr key={i}>
            <td>{credential.client_key}</td>
            <td>{credential.description}</td>
            <td>{credential.is_active ? 'Active' : 'Inactive'}</td>
            <td>
              <CredentialAction
                inactivateCredential={inactivateCredential}
                credential={credential}
                user={user}
              />
            </td>
          </tr>
        ))}
      </tbody>
    </table>
  );
};
