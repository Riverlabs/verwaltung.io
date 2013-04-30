Package.describe({
  summary: 'Simple client side page routing for Meteor'
});
Npm.depends({'page': 'https://github.com/tmeasday/page.js/tarball/62a90ec21c89211ba0b9799677a3d06e3150e647'});

Package.on_use(function (api) {
  api.use([
    'deps',
    'startup',
    'session',
    'underscore',
    'templating'
  ], 'client');
  api.add_files('.npm/node_modules/page/index.js', 'client');
  api.add_files('HTML5-History-API/history.iegte8.js', 'client');
  api.add_files('HTML5-History-API/settings.js', 'client');
  api.add_files(['mini-pages.js', 'helpers.js'], 'client');
});
