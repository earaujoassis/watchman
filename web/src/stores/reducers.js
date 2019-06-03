import * as actionTypes from '../actions/types';

const initialState = {
  user: undefined,
  loading: false,
  error: false,
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

const reducer = (state = initialState, action) => {
  switch (action.type) {
    case actionTypes.USER_RECORD_START: return userRecordStart(state, action);
    case actionTypes.USER_RECORD_SUCCESS: return userRecordSuccess(state, action);
    case actionTypes.USER_RECORD_ERROR: return userRecordError(state, action);
    default: return state;
  }
};

export default reducer;
