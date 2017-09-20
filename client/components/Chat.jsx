import React, { Component } from 'react';
import { withTracker } from 'meteor/react-meteor-data';
import { Contracts, Conversations } from '../../lib/collections';
import { Random } from 'meteor/random';
import { Meteor } from 'meteor/meteor';
import Verimi from "../../verimi";
import ContractSelect from "./ContractSelect";
import LocationSelect from "./LocationSelect";
import DataConfirmation from "./DataConfirmation";
import Success from "./Success";
import Sending from "./Sending";
import Done from "./Done";

class Chat extends Component {
  verimi = new Verimi()

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

  updateConversation(update) {
    Conversations.update({_id: this.props.conversation._id}, update)
  }

  goToNextStep(){
    const contract = this.props.conversation.contract;
    const nextStep = this.props.step + 1;
    this.pushMessage(Object.assign({}, contract.steps[nextStep]));
    reactHistory.push(`/conversation/${this.props.conversation._id}/${nextStep}`);
  }

  login(event) {
    this.pushMessage({ type: "token", sender: "bot" });
    this.verimi.startFlow({id: this.props.conversation._id, step: this.props.step + 1});
  }

  updateUser(){
    const code = this.props.location.search.split("=")[1];
    this.verimi.finishLogin(code, () => { this.goToNextStep() }, { step: 3, id: this.props.conversation._id });
  }

  renderMessage(message) {
    switch (message.type) {
      case "contract":
        return <ContractSelect conversation={this.props.conversation} onFinish={this.goToNextStep.bind(this)}/>
      case "location":
        return <LocationSelect conversation={this.props.conversation} onFinish={this.goToNextStep.bind(this)}/>
      case "login":
        return (
          <div onClick={this.login.bind(this)}>Login</div>
        )
      case "token":
        return (
          <div onClick={this.updateUser.bind(this)}>loggin in</div>
        )
      case "data-confirmation":
        return <DataConfirmation conversation={this.props.conversation} onFinish={this.goToNextStep.bind(this)}/>
      case "success":
        return <Success conversation={this.props.conversation} onFinish={this.goToNextStep.bind(this)}/>
      case "send":
        return <Sending conversation={this.props.conversation} onFinish={this.goToNextStep.bind(this)}/>
      case "done":
        return <Done conversation={this.props.conversation} onFinish={this.goToNextStep.bind(this)}/>
      default:
        return null
    }
  }

  render() {
    const conversation = this.props.conversation;
    if(!conversation) {
      return null;
    }
    const messages = conversation.messages || [];
    const message = messages[this.props.step];
    return (
      <main>
        { this.renderMessage(message) }
      </main>
    );
  }
}

export default withTracker((route) => {
  const conversation = Conversations.findOne({_id: route.match.params.id});
  const step = route.match.params.step ? parseInt(route.match.params.step) : conversation.messages.length - 1;
  return {
    conversation,
    step,
  };
})(Chat);
