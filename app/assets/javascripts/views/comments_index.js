CopCentral.Views.CommentsIndex = Backbone.View.extend({
	render: function(){
		this.$el.html(JST['comments/index']({ comments: this.collection }));
		return this;
	}
});