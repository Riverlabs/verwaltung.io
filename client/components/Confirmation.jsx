import React, { Component } from 'react';
import { withTracker } from 'meteor/react-meteor-data';

class Confirmation extends Component {
  send() {
    reactHistory.push("/submission");
  }

  render() {
    return (
      <main>
        <h1>Confirmation</h1>
        <div onClick={this.send.bind(this)}>senden</div>
      </main>
    );
  }
}

export default withTracker((query) => {
  return {  };
})(Confirmation);
