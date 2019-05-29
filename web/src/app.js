import React, { Suspense } from 'react';
import { Route, Switch, withRouter } from 'react-router-dom';

import Layout from './containers/Layout';
import Configuration from './components/Configuration';

import './app.css';

const app = props => {
  let routes = (
    <Switch>
      <Route path="/" component={Configuration} />
    </Switch>
  );

  return (
    <Layout>
      <Suspense fallback={<p>Pending...</p>}>{routes}</Suspense>
    </Layout>
  );
};

export default withRouter(app);
