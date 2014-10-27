CopCentral.Routers.Cops = Backbone.Router.extend({
	initialize: function(options) {
		this.collection = options.collection;
	},

	routes: {
		"": "index"
	},

	index: function() {
		var view = new CopCentral.Views.CopsIndex({collection: this.collection});
		$('#cops').html(view.render().$el);
	}
});