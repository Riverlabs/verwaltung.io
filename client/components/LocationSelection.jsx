import React, { Component } from 'react';
import { withTracker } from 'meteor/react-meteor-data';
import { Conversations } from '../../lib/collections';

class LocationSelection extends Component {
  onSubmit(event) {
    event.preventDefault();
    Conversations.update({ _id: this.props.conversation._id }, { $set: { location: event.target.location.value } })
    reactHistory.push("/login")
  }

  render() {
    return (
      <main>
        <h1>wo?</h1>
        <form onSubmit={this.onSubmit.bind(this)}>
          <input name="location" type="search"/>
        </form>
      </main>
    );
  }
}

export default withTracker((query) => {
  return {
    conversation: Conversations.findOne({})
  };
})(LocationSelection);
