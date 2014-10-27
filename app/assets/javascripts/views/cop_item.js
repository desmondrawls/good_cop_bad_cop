CopCentral.Views.CopItem = Backbone.View.extend({
	initialize: function() {
		_.bindAll(this, "render");
	},

	render: function(){
		console.log("RENDERING COPITEM");
		this.$el.html(JST['cops/item']({ cop: this.model }));
		return this;
	}
});