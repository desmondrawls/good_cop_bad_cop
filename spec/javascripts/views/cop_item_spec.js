describe("CopCentral.Views.CopItem", function(){
	var cop, view;

	beforeEach(function() {
		cop = new CopCentral.Models.Cop({ id: 3, name: "Riggs", badge_number: "55555"});
		view = new CopCentral.Views.CopItem({ model: cop });
	});

	it("renders an individual cop", function(){
		$el = $(view.render().el);
		expect($el).toHaveText(/Riggs/);
		expect($el).toHaveText(/55555/);
	});

	it("links to the cop detail view", function() {
		$el = $(view.render().el);
		expect($el).toContainElement('a[href="#cops/' + cop.get('id') + '"]');
	});
});