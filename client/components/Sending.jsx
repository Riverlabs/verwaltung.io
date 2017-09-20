import React, { Component } from 'react';
import { Meteor } from 'meteor/meteor';
import { Contracts, Conversations } from '../../lib/collections';

export default class Sending extends Component {
  componentDidMount() {
    window.setTimeout(this.props.onFinish, 4000);
  }

  render() {
    return (
      <div>
        <h1>sending</h1>
      </div>
    );
  }
}
