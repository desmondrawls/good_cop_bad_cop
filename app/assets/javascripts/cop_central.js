window.CopCentral = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function(data){
  	this.cops = new CopCentral.Collections.Cops(data.cops);

  	new CopCentral.Routers.Cops({ });
  	if (!Backbone.history.started) {
  		Backbone.history.start();
  		Backbone.history.started = true;
  	}
  }
};
