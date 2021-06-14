import axios from 'axios';
import fileDownload from 'js-file-download';

import * as actionTypes from './types';
import fetch from './fetch';

export const credentialRecordStart = () => {
  return {
    type: actionTypes.CREDENTIAL_RECORD_START
  };
};

export const credentialRecordSuccess = (data) => {
  return {
    type: actionTypes.CREDENTIAL_RECORD_SUCCESS,
    user: data.user
  };
};

export const credentialRecordError = (error) => {
  return {
    type: actionTypes.CREDENTIAL_RECORD_ERROR,
    error: error
  };
};

export const createCredential = (userId, _description) => {
  return dispatch => {
    dispatch(credentialRecordStart());
    axios({
      url: `/api/users/${userId}/credentials`,
      method: 'POST',
      responseType: 'blob'
    })
      .then(response => {
        fileDownload(response.data, 'credentials.csv');
        dispatch(fetchCredentials(userId));
      })
      .catch(error => {
        dispatch(credentialRecordError(error));
      });
  };
};

export const fetchCredentials = (id) => {
  return dispatch => {
    dispatch(credentialRecordStart());
    fetch.get(`users/${id}/credentials`)
      .then(response => {
        dispatch(credentialRecordSuccess(response.data));
      })
      .catch(error => {
        dispatch(credentialRecordError(error));
      });
  };
};

export const inactivateCredential = (userId, credentialId) => {
  return dispatch => {
    dispatch(credentialRecordStart());
    fetch.put(`users/${userId}/credentials/${credentialId}/inactivate`)
      .then(response => {
        dispatch(credentialRecordSuccess(response.data));
      })
      .catch(error => {
        dispatch(credentialRecordError(error));
      });
  };
};
