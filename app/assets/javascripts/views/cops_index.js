CopCentral.Views.CopsIndex = Backbone.View.extend({
	initialize: function(){
		_.bindAll(this, "render");
	},

	render: function(){
		this.$el.html(JST['index']);
		return this;
	}
})