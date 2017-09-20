import React, { Component } from 'react';
import { withTracker } from 'meteor/react-meteor-data';
import { Random } from 'meteor/random';
import VerimiAPI from "../../verimi";

class Verimi extends Component {
  verimi = new VerimiAPI()

  finishLogin(event) {
    this.verimi.finishLogin(this.props.code);
  }

  render() {
    return (
      <main onClick={this.finishLogin.bind(this)}>{`logging You In (code:${this.props.code})`}</main>
    );
  }
}

export default withTracker((query) => {
  const code = query.location.search.split("=")[1];
  return { code };
})(Verimi);
