CopCentral.Models.Cop = Backbone.Model.extend({
	parseComments: function() {
		var commentsAttr = this.get('comments');
		this.comments = new CopCentral.Collections.Comments(commentsAttr);
	}
});