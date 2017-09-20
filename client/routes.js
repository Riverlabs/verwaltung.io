import React from 'react';
import { Router, Route } from 'react-router';
import createBrowserHistory from 'history/createBrowserHistory';

import Chat from './components/Chat';
import Start from './components/Start';
import ContractSelection from './components/ContractSelection';
import LocationSelection from './components/LocationSelection';
import Login from './components/Login';
import Confirmation from './components/Confirmation';
import Submission from './components/Submission';
import Done from './components/Done';
import Verimi from './components/Verimi';

const browserHistory = createBrowserHistory();
window.reactHistory = browserHistory;

export const renderRoutes = () => (
  <Router history={browserHistory}>
    <div>
      <Route path="/" exact={true} component={Start}/>
      <Route path="/contracts" component={ContractSelection}/>
      <Route path="/location" component={LocationSelection}/>
      <Route path="/login" component={Login}/>
      <Route path="/verimi" component={Verimi}/>
      <Route path="/chat" component={Chat}/>
      <Route path="/confirmation" component={Confirmation}/>
      <Route path="/submission" component={Submission}/>
      <Route path="/done" component={Done}/>
    </div>
  </Router>
);
