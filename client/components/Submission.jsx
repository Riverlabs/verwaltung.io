import React, { Component } from 'react';
import { withTracker } from 'meteor/react-meteor-data';

class Submission extends Component {
  componentDidMount() {
    setTimeout(function(){
      reactHistory.push("/done");
    }, 3000);
  }

  render() {
    return (
      <main>
        <span>submitting...</span>
      </main>
    );
  }
}

export default withTracker((query) => {
  return {  };
})(Submission);
