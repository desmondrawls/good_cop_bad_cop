describe("CopCentral.Views.CopDetail", function(){
	var cop, comments, view, $el;
	beforeEach(function(){
		comments = [{"title": "No Sympathy", "author": "Penguin", "text": "He doesn't even try to understand where you're coming from."},
										{"title": "Awesome Gear", "author": "Regular Cop", "text": "I wish I was as cool as Robocop."}]
		cop = new CopCentral.Models.Cop({"name": "Robocop", "badge_number": "010101", "precinct_number": 99, "approval_rating": .875, "comments": comments, "cpr_rating": {"courtesy": 2.0, "professionalism": 1.5, "respect": 3.2} });
		view = new CopCentral.Views.CopDetail({ model: cop });
	});

	it("renders a cop", function(){
		$el = view.render().el;
		expect($el).toHaveText(/Robocop/);
		expect($el).toHaveText(/010101/);
		expect($el).toHaveText(/99/);
		expect($el).toHaveText(/.875/);
	});

	it("renders comments for the cop", function(){
		$el = view.render().el;
		expect($el).toHaveText(/No Sympathy/);
		expect($el).toHaveText(/Regular Cop/);
		expect($el).toHaveText(/I wish I was as cool as Robocop/);
	});

	it("renders a CPR rating for the cop", function(){
		$el = view.render().el;
		expect($el).toHaveText(/C: 2.0/);
		expect($el).toHaveText(/P: 1.5/);
		expect($el).toHaveText(/R: 3.2/);
	});

	xit("calls for a new CommentsIndex view", function(){
		spyOn(CopCentral.Views, 'CommentsIndex');
		view.render();
		expect(CopCentral.Views.CommentsIndex).toHaveBeenCalled();
	});
});