import React, { Component } from 'react';
import { createContainer } from 'meteor/react-meteor-data';
import { Forms } from '../../lib/collections';

class Chat extends Component {
  render() {
    return (
      <main>
        <h1>Hallo Welt!</h1>
        {
          this.props.forms.map(form => {
            return <div key={form._id}>{form.name}</div>
          })
        }
      </main>
    );
  }
}

export default createContainer(() => {
  return {
    forms: Forms.find({}).fetch(),
  };
}, Chat);
