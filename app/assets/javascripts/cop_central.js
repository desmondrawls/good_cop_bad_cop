window.CopCentral = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function(data){
  	console.log("INITIALIZING COP CENTRAL");
  	
  	this.cops = new CopCentral.Collections.Cops(data.cops);

  	this.cops_router = new CopCentral.Routers.Cops({ collection: this.cops });

  	if (!Backbone.history.started) {
  		Backbone.history.start();
  		Backbone.history.started = true;
  	}
  }
};
