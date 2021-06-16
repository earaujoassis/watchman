import React, { useEffect, useState } from 'react';
import { connect } from 'react-redux';

import * as actions from '../../actions';
import { SpinningSquare } from '../UI';

import { Entries } from './Entries';
import { View } from './View';

import './style.css';

const reports = (props) => {
  const {
    match: { params: { report_id: reportId, server_id: serverId } },
    history,
    fetchServers,
    fetchReports,
    fetchReport,
    servers = [],
    reportsTopics = [],
    report,
    loading
  } = props;

  const [currentServer, setServer] = useState(null);
  const [currentTopic, setTopic] = useState(null);

  let innerView;

  useEffect(() => {
    fetchServers();

    if ((reportId && serverId) && (!currentServer && !currentTopic)) {
      history.replace('/reports');
    }
  }, []);

  if (currentServer && currentTopic) {
    innerView = <View
      server={currentServer}
      topic={currentTopic}
      report={report}
      fetchReport={fetchReport} />;
  } else if (currentServer) {
    innerView = <Entries
      server={currentServer}
      reportsTopics={reportsTopics}
      loading={loading}
      onSetTopic={setTopic} />;
  } else {
    innerView = null;
  }

  if (loading.includes('server')) {
    return (
      <div className="reports-root">
        <div className="reports-header">
          <h2>Reports</h2>
        </div>
        <div className="reports-body">
          <aside className="reporters-menu">
            <SpinningSquare style={{ padding: '30px 0' }} />
          </aside>
          {innerView}
        </div>
      </div>
    );
  }

  return (
    <div className="reports-root">
      <div className="reports-header">
        <h2>Reports</h2>
      </div>
      <div className="reports-body">
        <aside className="reporters-menu">
          <ul className="servers-list">
            {servers.map((server, i) => (
              <li key={i}>
                <div className="servers-box">
                  <h3 className="servers-title">
                    <button
                      className="anchor"
                      onClick={(e) => {
                        e.preventDefault();
                        setServer(server);
                        setTopic(null);
                        history.replace('/reports');
                        fetchReports(server.id);
                      }}>
                      {server.hostname}
                    </button>
                  </h3>
                  <p className="servers-description">
                    <span>{server.ip}</span>
                    <span className="servers-spacer">&mdash;</span>
                    <span>v{server.latest_version || '?'}</span>
                  </p>
                </div>
              </li>
            ))}
          </ul>
        </aside>
        {innerView}
      </div>
    </div>
  );
};

const mapStateToProps = state => {
  return {
    servers: state.root.servers,
    reportsTopics: state.root.reportTopics,
    loading: state.root.loading,
    report: state.root.reportView
  };
};

const mapDispatchToProps = dispatch => {
  return {
    fetchServers: () => dispatch(actions.fetchServers()),
    fetchReports: (id) => dispatch(actions.fetchReports(id)),
    fetchReport: (serverId, reportId) => dispatch(actions.fetchReport(serverId, reportId))
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(reports);
