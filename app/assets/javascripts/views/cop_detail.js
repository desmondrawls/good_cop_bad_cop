CopCentral.Views.CopDetail = Backbone.View.extend({
	initialize: function(){
		_.bindAll(this, "render");
	},

	render: function(){
		this.model.parseComments();
		this.$el.html(JST['cops/detail']({ cop: this.model }));
		return this;
	}
});