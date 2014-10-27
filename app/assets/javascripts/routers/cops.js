CopCentral.Routers.Cops = Backbone.Router.extend({
	initialize: function(options) {
		this.collection = options.collection;
	},

	routes: {
		"": "index",
		"cops/:id": "show"
	},

	index: function() {
		var view = new CopCentral.Views.CopsIndex({collection: this.collection});
		$('#cops').html(view.render().$el);
	},

	show: function(copId) {
		var cop = this.collection.get(copId);
		console.log("TIME TO FETCH");
		cop.fetch({
			success: function(){
				console.log("COP FETCHED SUCCESSFULLY");
				var view = new CopCentral.Views.CopDetail({ model: cop });
				$('#cops').html(view.render().el);
			},
			error: function(){
				console.log("ERROR, ERROR");
			}
		});
	}
});