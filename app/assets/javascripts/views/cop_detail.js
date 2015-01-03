CopCentral.Views.CopDetail = Support.CompositeView.extend({
	events: {
		"click #cop_approve": "addApprove",
		"click #cop_disapprove": "addDisapprove",
		"click #cpr_submit": "addCPR"
	},

	initialize: function(){
		_.bindAll(this, "render");
		_.bindAll(this, "saved");
	},

	render: function(){
		console.log("RENDERING DETAILS");
		this.model.parseComments();
		this.$el.html(JST['cops/detail']({ cop: this.model, cpr_rating: this.model.get("cpr_rating") }));
		this.renderCPR();
		this.renderComments();
		return this;
	},

	renderComments: function(){
		var commentsView = new CopCentral.Views.CommentsIndex({ collection: this.model.comments });
		this.renderChild(commentsView);
		this.$('#comments-list').empty();
		this.$('#comments-list').append(commentsView.el);
	},

	renderRatings: function(){
		var RatingsView = new CopCentral.Views.RatingsIndex({ model: this.model });
		this.renderChild(RatingsView);
		this.$('#ratings').append(RatingsView.el); 
	},

	addCPR: function(e){
		e.preventDefault();
		var courtesy_rating = $('input:radio[name=cop-courtesy]:checked').val();
		var professionalism_rating = $('input:radio[name=cop-professionalism]:checked').val();
		var respect_rating = $('input:radio[name=cop-respect]:checked').val();
		this.model.save({})
		console.log("CPR", courtesy_rating, professionalism_rating, respect_rating);
	},

	addApprove: function(e){
		e.preventDefault();
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