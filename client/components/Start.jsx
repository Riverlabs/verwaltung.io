import React, { Component } from 'react';
import { withTracker } from 'meteor/react-meteor-data';
import { Conversations } from '../../lib/collections';

class Start extends Component {
  start(){
    const conversation = {
      messages: [
        {
          type: "contract",
          sender: "bot"
        }
      ]
    }
    const conversationId = Conversations.insert(conversation);
    reactHistory.push(`/conversation/${conversationId}/${0}`);
  }

  render() {
    return (
      <main className="Container">
        <div className="Header">
          <img src="Header-logo" src="/logo.svg"/>
        </div>
        <h1 className="center">Welcome at Verwaltung.io</h1>
        <p>
          Verwaltung.io helps you to get your application work done.
          <br/>
          All you need is a verimi account.
          <span className="Spacer"/>
          <span className="Button" onClick={this.start.bind(this)}>Start</span>
        </p>
      </main>
    );
  }
}

export default withTracker((query) => {
  return {  };
})(Start);
