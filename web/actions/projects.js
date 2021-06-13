import * as actionTypes from './types';
import fetch from './fetch';

export const projectRecordStart = () => {
  return {
    type: actionTypes.PROJECT_RECORD_START
  };
};

export const projectRecordSuccess = (data) => {
  return {
    type: actionTypes.PROJECT_RECORD_SUCCESS,
    user: data.user
  };
};

export const projectRecordError = (error) => {
  return {
    type: actionTypes.PROJECT_RECORD_ERROR,
    error: error
  };
};

export const fetchProjects = (id) => {
  return dispatch => {
    dispatch(projectRecordStart());
    fetch.get(`users/${id}/repositories`)
      .then(response => {
        dispatch(projectRecordSuccess(response.data));
      })
      .catch(error => {
        dispatch(projectRecordError(error));
      });
  };
};
