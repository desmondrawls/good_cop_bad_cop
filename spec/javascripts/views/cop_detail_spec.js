describe("CopCentral.Views.CopDetail", function(){
	var cop, comments, view, $el;
	beforeEach(function(){
		comments = [{"title": "No Sympathy", "author": "Penguin", "text": "He doesn't even try to understand where you're coming from."},
										{"title": "Awesome Gear", "author": "Regular Cop", "text": "I wish I was as cool as Robocop."}]
		cop = new CopCentral.Models.Cop({"id": 3,
																		"name": "Robocop", 
																		"badge_number": "010101", 
																		"precinct_number": 99,
																		"approves": 4,
																		"disapproves": 1, 
																		"approval_rating": .8, 
																		"comments": comments, 
																		"cpr_rating": {"courtesy": 2.0, 
																		"professionalism": 1.5, 
																		"respect": 3.2} });
		view = new CopCentral.Views.CopDetail({ model: cop });
		$el = view.render().el;
	});

	it("renders a cop", function(){
		expect($el).toHaveText(/Robocop/);
		expect($el).toHaveText(/010101/);
		expect($el).toHaveText(/99/);
		expect($el).toHaveText(/80%/);
	});

	it("renders comments for the cop", function(){
		expect($el).toHaveText(/No Sympathy/);
		expect($el).toHaveText(/Regular Cop/);
		expect($el).toHaveText(/I wish I was as cool as Robocop/);
	});

	it("renders a CPR rating for the cop", function(){
		expect($el).toHaveText(/C: 2.0/);
		expect($el).toHaveText(/P: 1.5/);
		expect($el).toHaveText(/R: 3.2/);
	});

	it("has buttons for approve and disapprove", function(){
		expect($el).toContainElement('a#cop_approve');
		expect($el).toHaveText(/Approve/);
		expect($el).toContainElement('a#cop_disapprove');
		expect($el).toHaveText(/Disapprove/);
	});

	it("updates the model's approval rating when an approval button is clicked", function(){
		var e = new Event(undefined);
		spyOn(cop, "save");
		view.addApprove(e);
		expect(cop.save).toHaveBeenCalledWith({approves: 5}, {success: view.saved, error: view.handleError});
	});

	it("calls the saved callback on success", function(){
		var e = new Event(undefined);
		var server = sinon.fakeServer.create();
		server.respondWith("PUT", "/backbone/cops/3", [ 204, null, "" ]);
		spyOn(view, "saved");
		view.addApprove(e);
 		server.respond();
 		expect(view.saved).toHaveBeenCalled();
	});

	it("calls fetch on the model from the saved function", function(){
		spyOn(cop, "fetch");
		view.saved();
		expect(cop.fetch).toHaveBeenCalled();
	});

	it("calls render on the view when fetch within saved is successful", function(){
		var server = sinon.fakeServer.create();
		server.respondWith([200, {"Content-Type":"text/html","Content-Length":2}, '{"OK":"True"}']);
		spyOn(view, "render");
		view.saved();
		server.respond();
		expect(view.render).toHaveBeenCalled();
	});

	xit("calls for a new CommentsIndex view", function(){
		spyOn(CopCentral.Views, 'CommentsIndex');
		view.render();
		expect(CopCentral.Views.CommentsIndex).toHaveBeenCalled();
	});
});