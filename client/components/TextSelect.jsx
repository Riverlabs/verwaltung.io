import React, { Component } from 'react';
import { Meteor } from 'meteor/meteor';
import { Contracts, Conversations } from '../../lib/collections';

export default class TextSelect extends Component {
  selectText(event){
    event.preventDefault();
    const name = event.target.content.value;
    Conversations.update({_id: this.props.conversation._id}, { $set: { [this.props.prop]: location } });
    this.props.onFinish();
  }

  render() {
    return (
      <div>
        <h1>{this.props.question}</h1>
        <form onSubmit={this.selectText.bind(this)}>
          <input className="Input" type="text" name="content"/>
          <div className="Spacer" />
          <input type="submit" value="Continue" className="Button"/>
        </form>
      </div>
    );
  }
}
