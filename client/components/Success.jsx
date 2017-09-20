import React, { Component } from 'react';
import { Meteor } from 'meteor/meteor';
import { Contracts, Conversations } from '../../lib/collections';

export default class Success extends Component {
  render() {
    return (
      <div>
        <h1>You're done!</h1>
        <div onClick={() => this.props.onFinish()}>send</div>
      </div>
    );
  }
}
