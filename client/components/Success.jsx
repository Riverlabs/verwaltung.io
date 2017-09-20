import React, { Component } from 'react';
import { Meteor } from 'meteor/meteor';
import { Contracts, Conversations } from '../../lib/collections';

export default class Success extends Component {
  render() {
    return (
      <div>
        <h1>Awesome, your form was generated.</h1>
        <div className="Line">
          <img src="/contract.png"/>
          <div>
            Your filled form is now ready to send to the following authority:
            <br/>
            Gewerbeamt Chartlottenburg-Wilmersdorf
          </div>
        </div>
        <div className="Line">
          <a href="/case/129783.pdf" className="Button" target="new">Download</a>
          <div onClick={() => this.props.onFinish()} className="Button">Send Now</div>
        </div>
      </div>
    );
  }
}
