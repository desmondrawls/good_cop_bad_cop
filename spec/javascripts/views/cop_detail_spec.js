describe("CopCentral.Views.CopDetail", function(){
	it("renders a cop", function(){
		var cop = new CopCentral.Models.Cop({"name": "Robocop", "badge_number": "010101"});
		var view = new CopCentral.Views.CopDetail({ model: cop });

		var $el = view.render().el;

		expect($el).toHaveText(/Robocop/);
		expect($el).toHaveText(/010101/);
	});
});