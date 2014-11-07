CopCentral.Models.Cop = Backbone.Model.extend({
	urlRoot: '/backbone/cops',
	
	parseComments: function() {
		var commentsAttr = this.get("comments");
		this.comments = new CopCentral.Collections.Comments(commentsAttr);
		this.comments.url = '/backbone/cops/' + this.id + '/comments'
		console.log("COMMENTS HERE:", this.comments);
	},

	formattedApproval: function() {
		return this.get("approval_rating").toFixed(2).toString().split(".")[1] + "%";
	}
});