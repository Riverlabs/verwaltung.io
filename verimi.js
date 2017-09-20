import { HTTP } from 'meteor/http';
import { Meteor } from 'meteor/meteor';
import { Random } from 'meteor/random';

export default class Verimi {
  get redirectUrl(){
    return `${Meteor.absoluteUrl()}verimi`;
  }

  get verimiTokenUrl() {
    return `https://verimi.com/dipp/api/oauth/service_provider_access/${this.settings.clientId}?redirect_uri=${this.redirectUrl}&scope=login read_basket`;
  }

  get settings() {
    return {
      clientId: "DB",
      clientSecret: "G|41|0an18ZIs_w"
    }
  }

  get users() {
    return Meteor.users;
  }

  get user() {
    return Meteor.user;
  }

  requestBaskets(access_token) {
    const url = `https://verimi.com/dipp/api/query/baskets`;
    const options = {

    };
    const response = HTTP.get(url, options);
    return response.data.dataScopes;
  }

  requestToken(code) {
    const url = `https://verimi.com/dipp/api/oauth/token?grant_type=authorization_code&code=${code}&redirect_uri=${encodeURIComponent(this.redirectUrl)}`;
    const auth = new Buffer(([this.settings.clientId, this.settings.clientSecret].join(":"))).toString('base64');
    const options = {
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": `Basic ${auth}`
      }
    };
    const response = HTTP.post(url, options).data;
    const access_token = response.access_token;
    const id_token = response.id_token;
    const basket = this.requestBaskets(access_token);
    var basketData = {};
    basket.forEach(basket => {
      var data = {};
      basket.data.forEach(value => {
        data[value.name] = value.value;
      });
      basketData[basket.scopeId.replace("r_", "")] = data;
    });
    var user = this.users.findOne({"profile.token": id_token});
    if(user) {
      this.users.update({_id: user._id}, { $set: { profile: { access_token: access_token } } })
    } else {
      user = this.users.insert({
        emails: [
        ],
        createdAt: new Date(),
        profile: {
          token: id_token,
          access_token: access_token,
          name: 'Joe Schmoe',
          data: basketData
        }
      });
    }
    return this.users.findOne({"profile.token": id_token});
  }

  startFlow() {
    document.location = this.verimiTokenUrl;
  }

  endFlow() {
    document.location = ""
  }

  finishLogin(code) {
    console.log(`logging in with ${code}`);
    Meteor.call('finishLogin', code, (error, result) => {
      if (error) {
        console.error(error);
      } else {
        console.log(`setting user id: ${result}`);
        Meteor.connection.setUserId(result);
        reactHistory.push("/chat")
      }
    });
  }
}

Meteor.methods({
  finishLogin(code){
    const verimi = new Verimi();
    if(!this.isSimulation){
      const user = verimi.requestToken(code);
      this.setUserId(user._id);
      return user._id;
    }
  }
});
