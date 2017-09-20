import React, { Component } from 'react';
import { withTracker } from 'meteor/react-meteor-data';

class Done extends Component {
  render() {
    return (
      <main>Done</main>
    );
  }
}

export default withTracker((query) => {
  return {  };
})(Done);
