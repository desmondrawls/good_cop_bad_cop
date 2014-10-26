CopCentral.Routers.Cops = Backbone.Router.extend({
	initialize: function(options) {
		console.log("ROUTER");
		this.collection = options.collection;
	},

	routes: {
		"": "index"
	},

	index: function() {
		console.log("INDEX");
		var view = new CopCentral.Views.CopsIndex({collection: this.collection});
		$('#cops').html(view.render().$el);
	}
});