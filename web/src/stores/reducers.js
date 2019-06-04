import * as actionTypes from '../actions/types';

const initialState = {
  user: undefined,
  projects: undefined,
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
    user: action.user
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

const reducer = (state = initialState, action) => {
  switch (action.type) {
    case actionTypes.USER_RECORD_START: return userRecordStart(state, action);
    case actionTypes.USER_RECORD_SUCCESS: return userRecordSuccess(state, action);
    case actionTypes.USER_RECORD_ERROR: return userRecordError(state, action);
    case actionTypes.PROJECT_RECORD_START: return projectRecordStart(state, action);
    case actionTypes.PROJECT_RECORD_SUCCESS: return projectRecordSuccess(state, action);
    case actionTypes.PROJECT_RECORD_ERROR: return projectRecordError(state, action);
    default: return state;
  }
};

export default reducer;
