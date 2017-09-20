import React from 'react';
import { Router, Route } from 'react-router';
import createBrowserHistory from 'history/createBrowserHistory';

import Chat from './components/Chat';
import Start from './components/Start';

const browserHistory = createBrowserHistory();
window.reactHistory = browserHistory;

export const renderRoutes = () => (
  <Router history={browserHistory}>
    <div>
      <Route path="/" exact={true} component={Start}/>
      <Route path="/conversation/:id/:step" component={Chat}/>
    </div>
  </Router>
);
