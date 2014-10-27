//= require application

describe("CopCentral.Views.CopsIndex", function(){
	var copsCollection, view;

	beforeEach(function(){
		copsCollection = new CopCentral.Collections.Cops([{"name": "Rick Deckard", "badge_number":"01101"}, 
							{"name": "Marge Gunderson", "badge_number":"9999"}]);
		view = new CopCentral.Views.CopsIndex({collection: copsCollection});
	});


	it("renders a collection of cops", function(){
		var $el = $(view.render().el);

		expect($el).toHaveText(/Rick Deckard/);
		expect($el).toHaveText(/01101/);
		expect($el).toHaveText(/Marge Gunderson/);
		expect($el).toHaveText(/9999/);
	});

	xit("renders an item view for each cop", function(){
		spyOn(CopCentral.Views, 'CopItem');
		view.render();
		expect(CopCentral.Views.CopItem).toHaveBeenCalled();
	});
});