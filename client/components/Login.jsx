import React, { Component } from 'react';
import { withTracker } from 'meteor/react-meteor-data';
import Verimi from "../../verimi";

class Login extends Component {
  verimi = new Verimi()

  login(event) {
    this.verimi.startFlow()
  }

  render() {
    return (
      <main>
        <div onClick={this.login.bind(this)}>Login with verimi</div>
      </main>
    );
  }
}

export default withTracker((query) => {
  return {  };
})(Login);
