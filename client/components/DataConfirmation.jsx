import React, { Component } from 'react';
import { Meteor } from 'meteor/meteor';
import { Contracts, Conversations } from '../../lib/collections';

export default class DataConfirmation extends Component {
  render() {
    return (
      <div>
        <h1>This is what we know about you</h1>
        <div onClick={() => this.props.onFinish()}>Use this</div>
      </div>
    );
  }
}
