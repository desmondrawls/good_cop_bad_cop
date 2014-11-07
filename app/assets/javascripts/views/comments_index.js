CopCentral.Views.CommentsIndex = Support.CompositeView.extend({
	events: {
		"click #new-comment-link": "renderNew"
	},

	initialize: function(){
		_.bindAll(this, "render");
		this.bindTo(this.collection, "add", this.render);
	},

	render: function(){
		this.$el.html(JST['comments/index']({ comments: this.collection }));
		return this;
	},

	renderNew: function(e){
		e.preventDefault();
		console.log("New comment form tba");
		this.newView = new CopCentral.Views.NewComment({ collection: this.collection });
		this.renderChild(this.newView);
		self.$('#new-comment').html(this.newView.el);
	}
});