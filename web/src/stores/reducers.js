import * as actionTypes from '../actions/types';

const initialState = {
  user: undefined,
  projects: undefined,
  applications: undefined,
  servers: undefined,
  error: undefined,
  loading: false,
  success: false
};

const userRecordStart = (state, action) => {
  return Object.assign({}, state, { loading: true });
};

const userRecordSuccess = (state, action) => {
  return Object.assign({}, state, {
    loading: false,
    success: true,
    error: null,
    user: action.user || { error: true }
  });
};

const userRecordError = (state, action) => {
  return Object.assign({}, state, { loading: false, success: false, error: action.error });
};

const projectRecordStart = (state, action) => {
  return Object.assign({}, state, { loading: true });
};

const projectRecordSuccess = (state, action) => {
  return Object.assign({}, state, {
    loading: false,
    success: true,
    error: null,
    projects: action.user.repos
  });
};

const projectRecordError = (state, action) => {
  return Object.assign({}, state, { loading: false, success: false, error: action.error });
};

const applicationRecordStart = (state, action) => {
  return Object.assign({}, state, { loading: true });
};

const applicationRecordSuccess = (state, action) => {
  return Object.assign({}, state, {
    loading: false,
    success: true,
    error: null,
    applications: action.user.apps
  });
};

const applicationRecordError = (state, action) => {
  return Object.assign({}, state, { loading: false, success: false, error: action.error });
};

const serverRecordStart = (state, action) => {
  return Object.assign({}, state, { loading: true });
};

const serverRecordSuccess = (state, action) => {
  return Object.assign({}, state, {
    loading: false,
    success: true,
    error: null,
    servers: action.servers
  });
};

const serverRecordError = (state, action) => {
  return Object.assign({}, state, { loading: false, success: false, error: action.error });
};

const reducer = (state = initialState, action) => {
  switch (action.type) {
    case actionTypes.USER_RECORD_START: return userRecordStart(state, action);
    case actionTypes.USER_RECORD_SUCCESS: return userRecordSuccess(state, action);
    case actionTypes.USER_RECORD_ERROR: return userRecordError(state, action);
    case actionTypes.PROJECT_RECORD_START: return projectRecordStart(state, action);
    case actionTypes.PROJECT_RECORD_SUCCESS: return projectRecordSuccess(state, action);
    case actionTypes.PROJECT_RECORD_ERROR: return projectRecordError(state, action);
    case actionTypes.APPLICATION_RECORD_START: return applicationRecordStart(state, action);
    case actionTypes.APPLICATION_RECORD_SUCCESS: return applicationRecordSuccess(state, action);
    case actionTypes.APPLICATION_RECORD_ERROR: return applicationRecordError(state, action);
    case actionTypes.SERVER_RECORD_START: return serverRecordStart(state, action);
    case actionTypes.SERVER_RECORD_SUCCESS: return serverRecordSuccess(state, action);
    case actionTypes.SERVER_RECORD_ERROR: return serverRecordError(state, action);
    default: return state;
  }
};

export default reducer;
