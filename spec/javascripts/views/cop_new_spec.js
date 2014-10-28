describe("CopCentral.Views.NewCop", function(){
	var view, $el, e, model;

	beforeEach(function(){
		view = new CopCentral.Views.NewCop();
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
		view.$('input[name=badge-number]').val('999');
		// view.$('input[name=precinct-number]').val('19');
		view.save(e);

		expect(model.get('name')).toEqual('SuperTrooper');
	});
});

