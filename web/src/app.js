import React, { Suspense } from 'react';
import { Route, Switch, withRouter } from 'react-router-dom';

import Layout from './containers/Layout';
import Applications from './components/Applications';
import Configuration from './components/Configuration';
import Projects from './components/Projects';

import './app.css';

const app = props => {
  let routes = (
    <Switch>
      <Route path="/" exact component={Applications} />
      <Route path="/configuration" exact component={Configuration} />
      <Route path="/projects" exact component={Projects} />
    </Switch>
  );

  return (
    <Layout>
      <Suspense fallback={<p>Pending...</p>}>{routes}</Suspense>
    </Layout>
  );
};

export default withRouter(app);
