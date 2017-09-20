import React, { Component } from 'react';
import { withTracker } from 'meteor/react-meteor-data';
import { Contracts, Conversations } from '../../lib/collections';

class ContractSelection extends Component {
  selectContract(contract){
    Conversations.update({_id: this.props.conversation._id}, { $set: { contract: contract } })
    reactHistory.push("/location");
  }

  render() {
    return (
      <main>
        <h1>Contracts</h1>
        {
          this.props.contracts.map((contract, index) => {
            return <div key={index} onClick={this.selectContract.bind(this, contract)}>{contract.name}</div>
          })
        }
      </main>
    );
  }
}

export default withTracker((query) => {
  return {
    contracts: Contracts,
    conversation: Conversations.findOne({})
  };
})(ContractSelection);
