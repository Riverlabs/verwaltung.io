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
      <div onClick={this.start.bind(this)}>Start</div>
    );
  }
}

export default withTracker((query) => {
  return {  };
})(Start);
