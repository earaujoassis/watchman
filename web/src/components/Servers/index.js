import React, { useEffect, useState } from 'react';
import { connect } from 'react-redux';
import moment from 'moment';

import * as actions from '../../actions';
import { useInterval } from '../../utils/hooks';
import { SpinningSquare } from '../UI';

import './style.css';

const THRESHOLD = 15.0; // min

const diffAboveThreshold = (serverUpdate) => {
  const now = moment(new Date());
  const then = moment.utc(serverUpdate, 'YYYY-MM-DD HH:mm:ss UTC');
  const diff = now.diff(then);
  return (diff / 1000 / 60) > THRESHOLD;
};

const diffDisplay = (serverUpdate) => {
  const then = moment.utc(serverUpdate, 'YYYY-MM-DD HH:mm:ss UTC');
  return moment().diff(then, 'minutes');
};

const servers = ({ fetchServers, loading, servers = [] }) => {
  useEffect(() => {
    fetchServers();
  }, []);

  let [seconds, setSeconds] = useState(0);

  useInterval(() => {
    setSeconds(seconds + 1 > 960 ? 0 : seconds + 1);
  }, 1000);

  return (
    <div className="servers-root">
      <h2>Servers</h2>
      {loading ? <SpinningSquare /> : (
        <ul className="servers-list">
          {servers.map((server, i) => (
            <li key={i}>
              <div className="servers-box">
                <span className="server-status-box"
                  title={diffAboveThreshold(server.updated_at) ? 'Inactive' : 'Active'}>
                  <span
                    className={`server-status ${diffAboveThreshold(server.updated_at) ? 'inactive' : 'active'}`}></span>
                  <span className="server-time-lapse">{diffDisplay(server.updated_at)}min</span>
                </span>
                <h3 className="servers-title">{server.hostname}</h3>
                <p className="servers-description">{server.ip}</p>
                <ul className="servers-actions">
                  <li>
                    <button className="anchor"
                      onClick={e => { e.preventDefault(); }}>
                      Re-deploy all projects
                    </button>
                  </li>
                </ul>
              </div>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
};

const mapStateToProps = state => {
  return {
    loading: state.root.loading,
    servers: state.root.servers
  };
};

const mapDispatchToProps = dispatch => {
  return {
    fetchServers: () => dispatch(actions.fetchServers())
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(servers);
