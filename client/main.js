import React from 'react';
import { Meteor } from 'meteor/meteor';
import { render } from 'react-dom';
import { Forms } from '../lib/collections';

import App from './components/App';

Meteor.startup(() => {
  render(<App />, document.getElementById('react-app'));
});

window.Forms = Forms
