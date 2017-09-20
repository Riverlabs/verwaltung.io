import React, { Component } from 'react';
import { withTracker } from 'meteor/react-meteor-data';

class Start extends Component {
  start(){
    reactHistory.push("/contracts");
  }
  
  render() {
    return (
      <div onClick={this.start.bind(this)}>Start</div>
    );
  }
}

export default withTracker((query) => {
  return {  };
})(Start);
