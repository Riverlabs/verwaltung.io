import React from 'react';
import { Router, Route } from 'react-router';
import createBrowserHistory from 'history/createBrowserHistory';

import Chat from './components/Chat';
import Verimi from './components/Verimi';

const browserHistory = createBrowserHistory();
window.reactHistory = browserHistory;

export const renderRoutes = () => (
  <Router history={browserHistory}>
    <div>
      <Route path="/verimi" component={Verimi}/>
      <Route path="/chat" component={Chat}/>
    </div>
  </Router>
);
