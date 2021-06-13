import * as actionTypes from '../actions/types';

const initialState = {
  user: undefined,
  projects: undefined,
  applications: undefined,
  servers: undefined,
  reportTopics: undefined,
  reportView: undefined,
  error: undefined,
  loading: [],
  success: false
};

const addLoading = (state, entity) => {
  const loading = JSON.parse(JSON.stringify(state.loading));
  loading.push(entity);
  return loading;
};

const reduceLoading = (state, entity) => {
  const loading = JSON.parse(JSON.stringify(state.loading));
  return loading.filter(element => element !== entity);
};

const receivedBroadcastMessage = (state, action) => {
  return Object.assign({}, state, action.data);
};

const userRecordStart = (state, action) => {
  return Object.assign({}, state, { loading: addLoading(state, 'user') });
};

const userRecordSuccess = (state, action) => {
  return Object.assign({}, state, {
    loading: reduceLoading(state, 'user'),
    success: true,
    error: null,
    user: action.user || { error: true }
  });
};

const userRecordError = (state, action) => {
  return Object.assign({}, state, {
    loading: reduceLoading(state, 'user'),
    success: false,
    error: action.error
  });
};

const projectRecordStart = (state, action) => {
  return Object.assign({}, state, { loading: addLoading(state, 'project') });
};

const projectRecordSuccess = (state, action) => {
  return Object.assign({}, state, {
    loading: reduceLoading(state, 'project'),
    success: true,
    error: null,
    projects: action.user.repos
  });
};

const projectRecordError = (state, action) => {
  return Object.assign({}, state, {
    loading: reduceLoading(state, 'project'),
    success: false,
    error: action.error
  });
};

const applicationRecordStart = (state, action) => {
  return Object.assign({}, state, { loading: addLoading(state, 'application') });
};

const applicationRecordSuccess = (state, action) => {
  return Object.assign({}, state, {
    loading: reduceLoading(state, 'application'),
    success: true,
    error: null,
    applications: action.user.apps
  });
};

const applicationRecordError = (state, action) => {
  return Object.assign({}, state, {
    loading: reduceLoading(state, 'application'),
    success: false,
    error: action.error
  });
};

const serverRecordStart = (state, action) => {
  return Object.assign({}, state, { loading: addLoading(state, 'server') });
};

const serverRecordSuccess = (state, action) => {
  return Object.assign({}, state, {
    loading: reduceLoading(state, 'server'),
    success: true,
    error: null,
    servers: action.servers
  });
};

const serverRecordError = (state, action) => {
  return Object.assign({}, state, {
    loading: reduceLoading(state, 'server'),
    success: false,
    error: action.error
  });
};

const reportRecordStart = (state, action) => {
  return Object.assign({}, state, { loading: addLoading(state, 'report') });
};

const reportRecordSuccess = (state, action) => {
  let data;

  if (action.reportTopics) {
    data = { reportTopics: action.reportTopics };
  } else {
    data = { reportView: action.reportView };
  }

  return Object.assign({}, state, data, {
    loading: reduceLoading(state, 'report'),
    success: true,
    error: null
  });
};

const reportRecordError = (state, action) => {
  return Object.assign({}, state, {
    loading: reduceLoading(state, 'report'),
    success: false,
    error: action.error
  });
};

const reducer = (state = initialState, action) => {
  switch (action.type) {
    case actionTypes.RECEIVED_CHANNEL_BROADCAST_MESSAGE: return receivedBroadcastMessage(state, action);
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
    case actionTypes.REPORT_RECORD_START: return reportRecordStart(state, action);
    case actionTypes.REPORT_RECORD_SUCCESS: return reportRecordSuccess(state, action);
    case actionTypes.REPORT_RECORD_ERROR: return reportRecordError(state, action);
    default: return state;
  }
};

export default reducer;