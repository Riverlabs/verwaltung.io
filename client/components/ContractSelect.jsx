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
        <h1>Which application are you looking for?</h1>
        <div className="BoxSelect">
          {
            Contracts.map((contract, index) => {
              return (
                <div key={index} onClick={this.selectContract.bind(this, contract)}>
                  <img src={contract.image}/>
                  <h2>{contract.name}</h2>
                </div>
              )
            })
          }
        </div>
      </div>
    );
  }
}
