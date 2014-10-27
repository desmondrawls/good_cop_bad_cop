describe("CopCentral.Views.CopItem", function(){
	it("renders an individual cop", function(){
		var cop = new CopCentral.Models.Cop({ name: "Riggs", badge_number: "55555"});
		view = new CopCentral.Views.CopItem({ model: cop });

		$el = $(view.render().el);
		expect($el).toHaveText(/Riggs/);
		expect($el).toHaveText(/55555/);
	});
});