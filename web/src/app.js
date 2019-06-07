import React, { Suspense } from 'react';
import { Route, Switch, withRouter } from 'react-router-dom';

import Layout from './containers/Layout';
import Configuration from './components/Configuration';
import Projects from './components/Projects';
import Applications from './components/Applications';
import Servers from './components/Servers';

import './app.css';

const app = props => {
  let routes = (
    <Switch>
      <Route path="/configuration" exact component={Configuration} />
      <Route path="/projects" exact component={Projects} />
      <Route path="/applications" exact component={Applications} />
      <Route path="/servers" exact component={Servers} />
    </Switch>
  );

  return (
    <Layout>
      <Suspense fallback={<p>Pending...</p>}>{routes}</Suspense>
    </Layout>
  );
};

export default withRouter(app);
