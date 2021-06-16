import React from 'react';
import { Link } from 'react-router-dom';
import moment from 'moment';

import { SpinningSquare } from '../UI';

const fromNow = (updatedAt) => {
  return moment.utc(updatedAt, 'YYYY-MM-DD HH:mm:ss UTC').startOf('minute').fromNow();
};

export const Entries = ({ server, reportsTopics, loading, onSetTopic }) => {
  if (loading.includes('topics')) {
    return (
      <div className="reports-list-box">
        <SpinningSquare style={{ padding: '30px 0' }} />
      </div>
    );
  }

  return (
    <div className="reports-list-box">
      <ul className="reports-list">
        {reportsTopics.map((topic, i) => (
          <li key={i} className={`report-entry ${topic.body_available ? '' : 'body_unavailable'}`}>
            <div className="quarter">
              <p>{server.hostname.split('.')[0]}</p>
            </div>
            <div className="half divisor">
              <p>
                <Link to={`/reports/${topic.id}/from/${server.id}`} onClick={() => onSetTopic(topic)}>
                  {topic.subject}
                </Link>
              </p>
            </div>
            <div className="quarter">
              <p title={topic.updated_at}><i className="far fa-clock"></i> {fromNow(topic.updated_at)}</p>
            </div>
          </li>
        ))}
      </ul>
    </div>
  );
};
