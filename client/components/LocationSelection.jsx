import React, { Component } from 'react';
import { withTracker } from 'meteor/react-meteor-data';

class LocationSelection extends Component {
  onSubmit(event) {
    event.preventDefault();
    reactHistory.push("/login")
  }

  render() {
    return (
      <main>
        <h1>wo?</h1>
        <form onSubmit={this.onSubmit.bind(this)}>
          <input type="search"/>
        </form>
      </main>
    );
  }
}

export default withTracker((query) => {
  return {  };
})(LocationSelection);
