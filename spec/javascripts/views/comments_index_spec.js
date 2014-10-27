describe("CopCentral.Views.CommentsIndex", function(){
	var $el, comment1, comment2;
	beforeEach(function(){
		comment1 = Factory.attributes('comment');
		comment2 = Factory.attributes('comment', {text: "Nice person."});
		var commentsCollection = new CopCentral.Collections.Comments([comment1, comment2]);
		var commentsView = new CopCentral.Views.CommentsIndex({ collection: commentsCollection });
		$el = $(commentsView.render().el);
	});

	it("renders a comments collection", function(){
		expect($el).toContainText(comment1.title);
		expect($el).toContainText(comment1.author);
		expect($el).toContainText(comment1.text);
		expect($el).toContainText(comment2.title);
		expect($el).toContainText(comment2.author);
		expect($el).toContainText(comment2.text);
	});
});