import React, { Suspense } from 'react';
import { Route, Switch, withRouter } from 'react-router-dom';

import Layout from './containers/Layout';
import Dashboard from './components/Dashboard';
import Configuration from './components/Configuration';
import Credentials from './components/Credentials';
import Projects from './components/Projects';
import Applications from './components/Applications';
import Servers from './components/Servers';
import Reports from './components/Reports';

import './app.css';

const app = props => {
  const routes = (
    <Switch>
      <Route path="/dashboard" exact component={Dashboard} />
      <Route path="/configuration" exact component={Configuration} />
      <Route path="/configuration/credentials" exact component={Credentials} />
      <Route path="/projects" exact component={Projects} />
      <Route path="/applications" exact component={Applications} />
      <Route path="/servers" exact component={Servers} />
      <Route path="/reports" exact component={Reports} />
      <Route path="/reports/:report_id/from/:server_id" exact component={Reports} />
    </Switch>
  );

  return (
    <Layout>
      <Suspense fallback={<p>Pending...</p>}>{routes}</Suspense>
    </Layout>
  );
};

export default withRouter(app);
