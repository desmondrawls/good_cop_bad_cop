CopCentral.Routers.Cops = Support.SwappingRouter.extend({
	initialize: function(options) {
		this.el = $('#cops');
		this.collection = options.collection;
	},

	routes: {
		"": "index",
		"cops/new": "new",
		"cops/:id": "show"
	},

	index: function() {
		var view = new CopCentral.Views.CopsIndex({collection: this.collection});
		this.swap(view);
	},

	show: function(copId) {
		var cop = this.collection.get(copId);
		var self = this;
		cop.fetch({
			success: function(){
				console.log("Cop:", cop);
				var view = new CopCentral.Views.CopDetail({ model: cop });
				self.swap(view);
			},
			error: function(){
				console.log("ERROR FETCHING COP FOR SHOW");
			}
		});
	},

	new: function() {
		var view = new CopCentral.Views.NewCop({ collection: this.collection });
		this.swap(view);
	}
});