CopCentral.Views.CopDetail = Support.CompositeView.extend({
	initialize: function(){
		_.bindAll(this, "render");
	},

	render: function(){
		this.model.parseComments();
		this.$el.html(JST['cops/detail']({ cop: this.model }));
		this.renderComments();
		return this;
	},

	renderComments: function(){
		var commentsView = new CopCentral.Views.CommentsIndex({ collection: this.model.comments });
		this.renderChild(commentsView);
		this.$('#comments-list').empty();
		this.$('#comments-list').append(commentsView.el);
	}
});