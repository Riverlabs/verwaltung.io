import React from 'react';
import { Meteor } from 'meteor/meteor';
import { render } from 'react-dom';
import { Forms, Conversations } from '../lib/collections';
import { renderRoutes } from './routes';

Meteor.startup(() => {
  render(renderRoutes(), document.getElementById('react-app'));
});

window.Forms = Forms
window.Conversations = Conversations
