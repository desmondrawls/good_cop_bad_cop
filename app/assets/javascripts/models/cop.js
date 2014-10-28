CopCentral.Models.Cop = Backbone.Model.extend({
	urlRoot: '/backbone/cops',
	
	parseComments: function() {
		var commentsAttr = this.get('comments');
		this.comments = new CopCentral.Collections.Comments(commentsAttr);
		console.log("COMMENTS HERE:", this.comments);
	}
});