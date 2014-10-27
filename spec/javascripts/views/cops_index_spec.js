//= require application

describe("CopCentral.Views.CopsIndex", function(){
	it("renders a collection of cops", function(){
		var copsCollection = new CopCentral.Collections.Cops([{"name": "Rick Deckard", "badge_number":"01101"}, 
								{"name": "Marge Gunderson", "badge_number":"9999"}]);

		var view = new CopCentral.Views.CopsIndex({collection: copsCollection});

		var $el = $(view.render().el);

		expect($el).toHaveText(/Rick Deckard/);
		expect($el).toHaveText(/01101/);
		expect($el).toHaveText(/Marge Gunderson/);
		expect($el).toHaveText(/9999/);
	});
});