CopCentral.Models.Cop = Backbone.Model.extend({
	urlRoot: '/backbone/cops',
	
	parseComments: function() {
		var commentsAttr = this.get("comments");
		this.comments = new CopCentral.Collections.Comments(commentsAttr);
		this.comments.url = '/backbone/cops/' + this.id + '/comments'
		console.log("COMMENTS HERE:", this.comments);
	},

	formattedApproval: function() {
		var approval_rating = this.get("approval_rating");
		if (_.isString(approval_rating)) {
			return approval_rating;
		}
		else if (_.isNumber(approval_rating)) {
			return approval_rating.toFixed(2).toString().split(".")[1] + "%";
		}
		else {
			console.log("UNKNOWN APPROVAL RATING FORMAT:", approval_rating);
		}
	}
});