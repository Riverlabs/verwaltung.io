import React, { Component } from 'react';
import { Meteor } from 'meteor/meteor';
import { Contracts, Conversations } from '../../lib/collections';

export default class ContractSelect extends Component {
  selectContract(contract){
    Conversations.update({_id: this.props.conversation._id}, { $set: { contract: contract } });
    this.props.onFinish();
  }

  render() {
    return (
      <div>
        <h1>Select your contract</h1>
        {
          Contracts.map((contract, index) => {
            return <div key={index} onClick={this.selectContract.bind(this, contract)}>{contract.name}</div>
          })
        }
      </div>
    );
  }
}
