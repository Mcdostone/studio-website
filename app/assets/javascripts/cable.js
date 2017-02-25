//= require_tree ./channels
ActionCable = require('actioncable')
//require('./channels/upload_progress')


(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();

}).call(this);
