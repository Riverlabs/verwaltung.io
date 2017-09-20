import React, { Component } from 'react';
import { withTracker } from 'meteor/react-meteor-data';
import { Conversations } from '../../lib/collections';
import { Random } from 'meteor/random';
import { Meteor } from 'meteor/meteor';

class Chat extends Component {
  pushMessage(message){
    Conversations.update({_id: this.props.conversation._id}, { $push: { messages: message} });
  }

  sendMessage(event){
    event.preventDefault();
    const messageText = event.target.text.value;
    this.pushMessage({ type: "text", sender: "user", text: messageText, canAnswer: true });
    this.finishOff();
  }

  finishOff(){
    this.pushMessage({ type: "done", sender: "bot", canAnswer: false });
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
    const lastMessage = messages.length > 0 ? messages[messages.length - 1] : nil;
    let inputBox = null;
    if(lastMessage && lastMessage.canAnswer) {
      inputBox = (
        <form onSubmit={this.sendMessage.bind(this)}>
          <input name="text"/>
        </form>
      )
    }
    return (
      <main>
        {
          messages.map((message, index) => {
            switch (message.type) {
              case "text":
                return <div key={index}>{message.text}</div>
              case "done":
                return (<div onClick={this.confirm.bind(this)}>Done!</div>);
              default:

            }

          })
        }
        {inputBox}
      </main>
    );
  }
}

export default withTracker(() => {
  return {
    conversation: Conversations.findOne({}),
    user: Meteor.users.findOne({})
  };
})(Chat);
