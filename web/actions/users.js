import * as actionTypes from './types';
import fetch from './fetch';

export const userRecordStart = () => {
  return {
    type: actionTypes.USER_RECORD_START
  };
};

export const userRecordSuccess = (data) => {
  return {
    type: actionTypes.USER_RECORD_SUCCESS,
    user: data.user
  };
};

export const userRecordError = (error) => {
  return {
    type: actionTypes.USER_RECORD_ERROR,
    error: error
  };
};

export const fetchUser = () => {
  return dispatch => {
    dispatch(userRecordStart());
    fetch.get('users/')
      .then(response => {
        dispatch(userRecordSuccess(response.data));
      })
      .catch(error => {
        dispatch(userRecordError(error));
      });
  };
};

export const createUser = (data) => {
  return dispatch => {
    dispatch(userRecordStart());
    fetch.post('users/', data)
      .then(response => {
        dispatch(userRecordSuccess(response.data));
      })
      .catch(error => {
        dispatch(userRecordError(error));
      });
  };
};

export const updateUser = (id, data) => {
  return dispatch => {
    dispatch(userRecordStart());
    fetch.patch(`users/${id}`, data)
      .then(response => {
        dispatch(userRecordSuccess(response.data));
      })
      .catch(error => {
        dispatch(userRecordError(error));
      });
  };
};

export const subscribeUser = () => {
  return dispatch => dispatch({
    type: actionTypes.CABLE_SUBSCRIBE_TO_USER_CHANNEL,
    event: 'message',
    handle: data => {
      return dispatch({
        type: actionTypes.RECEIVED_CHANNEL_BROADCAST_MESSAGE,
        data: data
      });
    }
  });
};

export const unsubscribeUser = () => {
  return {
    type: actionTypes.CABLE_UNSUBSCRIBE_TO_USER_CHANNEL,
    event: 'message',
    unsubscribe: true
  };
};
