import React, { Component } from 'react';
import { withTracker } from 'meteor/react-meteor-data';
import { Conversations } from '../../lib/collections';
import { Random } from 'meteor/random';
import { Meteor } from 'meteor/meteor';

class Chat extends Component {
  sendMessage(event){
    event.preventDefault();
    const messageText = event.target.text.value;
    const message = { type: "text", sender: "user", text: messageText };
    Conversations.update({_id: this.props.conversation._id}, { $push: { messages: message} });
  }

  confirm() {
    reactHistory.push("/confirmation")
  }

  render() {
    const conversation = this.props.conversation;
    if(!conversation) {
      return null;
    }
    const messages = conversation.messages || [];
    const username = (this.props.user && this.props.user.profile.name) || "not logged in";
    return (
      <main>
        <div>{username}</div>
        {
          messages.map((message, index) => {
            return <div key={index}>{message.text}</div>
          })
        }
        <div onClick={this.confirm.bind(this)}>Done!</div>
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
    user: Meteor.user()
  };
})(Chat);
