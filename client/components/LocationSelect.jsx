import React, { Component } from 'react';
import { Meteor } from 'meteor/meteor';
import { Contracts, Conversations } from '../../lib/collections';

export default class LocationSelect extends Component {
  selectLocation(event){
    event.preventDefault();
    const name = event.target.location.value;
    Conversations.update({_id: this.props.conversation._id}, { $set: { location: location } });
    this.props.onFinish();
  }

  render() {
    return (
      <div>
        <h1>What will be the address of the company?</h1>
        <form onSubmit={this.selectLocation.bind(this)}>
          <input className="Input" type="search" name="location"/>
          <div className="Spacer" />
          <input type="submit" value="Continue" className="Button"/>
        </form>
      </div>
    );
  }
}
