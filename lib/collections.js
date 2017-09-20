import { Mongo } from 'meteor/mongo';

export const Forms = new Mongo.Collection('forms');
export const Conversations = new Mongo.Collection('conversations');
export const Contracts = [
  {
    _id: 1,
    name: "Gewerbeanmeldung",
    steps: [
      {}, // select contract
      {
        type: "location",
        sender: "bot"
      },
      {
        type: "login",
        sender: "bot"
      },
      {
        type: "token",
        sender: "bot"
      },
      {
        type: "data-confirmation",
        sender: "bot"
      },
      {
        type: "success",
        sender: "bot"
      },
      {
        type: "send",
        sender: "bot"
      },
      {
        type: "done",
        sender: "bot"
      }
    ]
  },
  {
    _id: 2,
    name: "A38",
    steps: []
  }
]

export const nextStep = function(conversation) {
  const contract = conversation.contract;
  const nextStep = conversation.messages.length;
  const message = contract.steps[nextStep];
  Conversations.update({_id: conversation._id}, { $push: { messages: message} });
  reactHistory.push(`/conversation/${conversation._id}/${nextStep}`);
}
