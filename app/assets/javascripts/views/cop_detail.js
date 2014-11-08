CopCentral.Views.CopDetail = Support.CompositeView.extend({
	events: {
		"click #cop_approve": "addApprove",
		"click #cop_disapprove": "addDisapprove"
	},

	initialize: function(){
		_.bindAll(this, "render");
		_.bindAll(this, "saved");
	},

	render: function(){
		console.log("RENDERING DETAILS");
		this.model.parseComments();
		this.$el.html(JST['cops/detail']({ cop: this.model, cpr_rating: this.model.get("cpr_rating") }));
		this.renderComments();
		return this;
	},

	renderComments: function(){
		var commentsView = new CopCentral.Views.CommentsIndex({ collection: this.model.comments });
		this.renderChild(commentsView);
		this.$('#comments-list').empty();
		this.$('#comments-list').append(commentsView.el);
	},

	addApprove: function(e){
		e.preventDefault();
		console.log("ADDING APPROVE");
		var self = this;
    this.model.save({approves: this.model.get("approves") + 1}, {success: this.saved, error: this.handleError});
	},

	addDisapprove: function(e){
		e.preventDefault();
    this.model.save({disapproves: this.model.get("disapproves") + 1}, {success: this.saved, error: this.handleError});
	},

	saved: function(model, response, options) {
		console.log("GOT BACK:", this.model);
		var self = this;
		this.model.fetch({
			success: function(){
				console.log("COP SAVED");
				self.render();
			},
			error: function(){
				console.log("ERROR FETCHING COP");
			}
		});
	},

	handleError: function(){ console.log("Error saving!"); }
});