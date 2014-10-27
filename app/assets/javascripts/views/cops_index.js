CopCentral.Views.CopsIndex = Backbone.View.extend({
	initialize: function(){
		console.log("COPSINDEX INITIALIZED WITH:", this.collection);
		_.bindAll(this, "render");
	},

	render: function(){
		this.$el.html(JST['cops/index']({ cops: this.collection }));
		console.log("COPPERS VIEW THIS:", this);
		return this;
	}
})