import React, { Component } from 'react';
import { Meteor } from 'meteor/meteor';
import { Contracts, Conversations } from '../../lib/collections';
import { withTracker } from 'meteor/react-meteor-data';

class DataConfirmation extends Component {
  render() {
    const user = this.props.user;
    const data = user.profile.data;
    return (
      <div>
        <h1>This is what we know about you</h1>
        <div className="BoxSelect">
          <div>
            <strong>Name</strong>
            <div>{`${data.personal.name} ${data.personal.surname}`}</div>
            <strong>Address</strong>
            <div>{`${data.address.street} ${data.address.number}, ${data.address.city}`}</div>
          </div>
        </div>
        <div className="Spacer"/>
        <div className="Button" onClick={() => this.props.onFinish()}>Use this</div>
      </div>
    );
  }
}

export default withTracker((route) => {
  return {
    user: Meteor.users.findOne({})
  };
})(DataConfirmation);
