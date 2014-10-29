describe("CopCentral.Views.NewCop", function(){
	var view, cops, $el, e, model;

	beforeEach(function(){
		cops = new CopCentral.Collections.Cops();
		view = new CopCentral.Views.NewCop({ collection: cops });
		e = new Event(undefined);
		model = view.model;
	});

	it("renders a NewCop view", function(){
		$el = $(view.render().el);
		expect($el).toContainText("Enter a New Cop");
	});

	it("renders a form", function(){
		$el = $(view.render().el);
		expect($el).toContainHtml("<input id=\"cop-name\" name=\"name\" type=\"text\" />");
		expect($el).toContainHtml("<input id=\"cop-badge-number\" name=\"badge-number\" type=\"text\" />");
		// expect($el).toContainHtml("<input id=\"cop-precinct-number\" name=\"precinct-number\" type=\"text\" />");	
		expect($el).toContainHtml("<input type=\"submit\" value=\"Submit\" />");	
	});

	it("saves a new cop", function(){
		spyOn(model, 'save');
		view.save(e);
		expect(model.save).toHaveBeenCalled();
	});

	it("saves the cop with the form data", function(){
		view.render();
		view.$('input[name=name]').val('SuperTrooper');
		view.$('input[name=badge-number]').val('9999');
		view.save(e);

		expect(model.get('name')).toEqual('SuperTrooper');
	});

	it("adds the model to the collection", function(){
		spyOn(cops, 'add');
		view.saved();
		expect(cops.add).toHaveBeenCalled();
	});

	it("leaves after saving", function(){
		spyOn(view, 'leave');
		view.saved();
		expect(view.leave).toHaveBeenCalled();
	});
});

