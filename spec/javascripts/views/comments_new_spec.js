describe("CopCentral.Views.NewComment", function(){
	var view, comments, $el, e, model;

	beforeEach(function(){
		comments = new CopCentral.Collections.Comments();
		comments.url = '/backbone/cops/' + this.id + '/comments'
		view = new CopCentral.Views.NewComment({ collection: comments });
		e = new Event(undefined);
		model = view.model;
	});

	it("renders a NewCop view", function(){
		$el = $(view.render().el);
		expect($el).toContainText("Enter a New Comment");
	});

	it("renders a form", function(){
		$el = $(view.render().el);
		expect($el).toContainHtml("<input id=\"comment-title\" name=\"title\" type=\"text\" />");
		expect($el).toContainHtml("<input id=\"comment-text\" name=\"text\" type=\"text\" />");
		expect($el).toContainHtml("<input id=\"comment-author\" name=\"author\" type=\"text\" />");	
		expect($el).toContainHtml("<input type=\"submit\" value=\"Submit\" />");	
	});

	it("saves a new comment", function(){
		spyOn(model, 'save');
		view.save(e);
		expect(model.save).toHaveBeenCalled();
	});

	it("saves the comment with the form data", function(){
		view.render();
		view.$('input[name=title]').val('Smelly');
		view.$('input[name=text]').val('I think he only owns one uniform. I saw him with the same jelly stain on his coat two days in a row.');
		view.$('input[name=author]').val('Grandma Mardy')
		view.save(e);

		expect(model.get('title')).toEqual('Smelly');
		expect(model.get('text')).toEqual('I think he only owns one uniform. I saw him with the same jelly stain on his coat two days in a row.');
		expect(model.get('author')).toEqual('Grandma Mardy');
	});

	it("adds the model to the collection", function(){
		spyOn(comments, 'add');
		view.saved();
		expect(comments.add).toHaveBeenCalled();
	});

	it("leaves after saving", function(){
		spyOn(view, 'leave');
		view.saved();
		expect(view.leave).toHaveBeenCalled();
	});
});

