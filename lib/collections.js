import { Mongo } from 'meteor/mongo';

export const Forms = new Mongo.Collection('forms');
export const Conversations = new Mongo.Collection('conversations');
export const Contracts = [
  {
    _id: 1,
    name: "Gewerbeanmeldung"
  },
  {
    _id: 2,
    name: "A38"
  }
]
