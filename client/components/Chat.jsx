import React, { Component } from 'react';
import { withTracker } from 'meteor/react-meteor-data';
import { Conversations } from '../../lib/collections';
import { Random } from 'meteor/random';

class Chat extends Component {
  sendMessage(event){
    console.log(event);
    const messageText = event.target.text.value;
    const message = { type: "text", sender: "user", text: messageText, _id: Random.id };
    Conversations.update({_id: this.props.conversation._id}, { $push: { messages: message} });
  }

  render() {
    const conversation = this.props.conversation;
    if(!conversation) {
      return null;
    }
    const messages = conversation.messages || [];
    return (
      <main>
        {
          messages.map(message => {
            return <div key={message._id}>{message.text}</div>
          })
        }
        <form onSubmit={this.sendMessage.bind(this)}>
          <input name="text"/>
        </form>
      </main>
    );
  }
}

export default withTracker(() => {
  return {
    conversation: Conversations.findOne({}),
  };
})(Chat);
