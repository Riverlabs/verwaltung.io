import React, { Component } from 'react';
import { Meteor } from 'meteor/meteor';
import { Contracts, Conversations } from '../../lib/collections';

export default class Done extends Component {
  render() {
    return (
      <div>
        <h1>Your form was successfully sent.</h1>
        <div className="Spacer"/>
        <a className="Button" href="/">Back to Home</a>
      </div>
    );
  }
}
