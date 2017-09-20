import React, { Component } from 'react';
import { withTracker } from 'meteor/react-meteor-data';

class ContractSelection extends Component {
  selectContract(contract){
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
    contracts: [
      {
        name: "Gewerbeanmeldung"
      },
      {
        name: "A38"
      }
    ]
  };
})(ContractSelection);
