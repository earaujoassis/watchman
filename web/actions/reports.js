import * as actionTypes from './types';
import fetch from './fetch';

export const reportRecordStart = () => {
  return {
    type: actionTypes.REPORT_RECORD_START
  };
};

export const reportRecordSuccess = (data) => {
  return {
    type: actionTypes.REPORT_RECORD_SUCCESS,
    reportTopics: data.reports,
    reportView: data.report
  };
};

export const reportRecordError = (error) => {
  return {
    type: actionTypes.REPORT_RECORD_ERROR,
    error: error
  };
};

export const fetchReports = (id) => {
  return dispatch => {
    dispatch(reportRecordStart());
    fetch.get(`servers/${id}/reports`)
      .then(response => {
        dispatch(reportRecordSuccess(response.data));
      })
      .catch(error => {
        dispatch(reportRecordError(error));
      });
  };
};

export const fetchReport = (serverId, reportId) => {
  return dispatch => {
    dispatch(reportRecordStart());
    fetch.get(`servers/${serverId}/reports/${reportId}`)
      .then(response => {
        dispatch(reportRecordSuccess(response.data));
      })
      .catch(error => {
        dispatch(reportRecordError(error));
      });
  };
};
