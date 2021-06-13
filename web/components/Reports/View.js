import React, { useEffect } from 'react';
import moment from 'moment';

import { SpinningSquare } from '../UI';

const ADDITIONAL_WIDTH = 45;

let width;

const fromNow = (updatedAt) => {
  return moment.utc(updatedAt, 'YYYY-MM-DD HH:mm:ss UTC').startOf('minute').fromNow();
};

const view = ({ fetchReport, topic, server, report }) => {
  useEffect(() => {
    fetchReport(server.id, topic.id);
  }, []);

  if (!topic && !server) {
    return <SpinningSquare style={{ padding: '30px 0' }} />;
  }

  return (
    <div className="reports-view">
      <div
        className={`report-entry-view ${topic.body_available ? '' : 'body_unavailable'}`}
        ref={elem => { width = elem ? elem.getBoundingClientRect().width + ADDITIONAL_WIDTH : null; }}>
        <div className="report-info">
          <h3 className="report-title">{topic.subject}</h3>
          <p>{server.hostname}</p>
          <p>{server.ip}</p>
          <p title={topic.updated_at}>{fromNow(topic.updated_at)}</p>
        </div>
      </div>
      {topic.body_available ? (
        <div className="report-body terminal-root" style={{ maxWidth: `${width}px` }}>
          {width && report && report.body
            ? <pre>{report.body}</pre>
            : <SpinningSquare style={{ padding: '30px 0', color: '#fff' }} />}
        </div>
      ) : (
        <div className="report-body terminal-root" style={{ maxWidth: `${width}px` }}>
          <p>Report file is not available</p>
        </div>
      )}
    </div>
  );
};

export default view;
