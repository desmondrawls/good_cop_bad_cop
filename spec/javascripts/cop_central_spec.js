describe("CopCentral", function(){
	it("has a namespace for models", function(){
		expect(CopCentral.Models).toBeTruthy();
	});

	it("has a namespace for collections", function(){
		expect(CopCentral.Collections).toBeTruthy();
	});

	it("has a namespace for views", function(){
		expect(CopCentral.Views).toBeTruthy();
	});

	it("has a namespace for routers", function(){
		expect(CopCentral.Routers).toBeTruthy();
	});

	describe("ititialize()", function(){
		it("accepts data JSON and instantiates a collection from it", function(){
			var data = {
				"cops": [{"name": "Rick Deckard", "badge_number":"01101"}, 
								{"name": "Marge Gunderson", "badge_number":"9999"}]
			};
			CopCentral.initialize(data);

			expect(CopCentral.cops).not.toEqual(undefined);
			expect(CopCentral.cops.length).toEqual(2);
			expect(CopCentral.cops.models[0].get('name')).toEqual("Rick Deckard");
			expect(CopCentral.cops.models[1].get('name')).toEqual("Marge Gunderson");
		});

		it("instantiates a Cops router", function() {
			spyOn(CopCentral.Routers, 'Cops');
			CopCentral.initialize({});
			expect(CopCentral.Routers.Cops).toHaveBeenCalled();
		});

		it("starts Backbone.history", function() {
			Backbone.history.started = null;
			Backbone.history.stop();
			spyOn(Backbone.history, 'start');
			CopCentral.initialize({});

			expect(Backbone.history.start).toHaveBeenCalled();
		});

		it("doesn't start Backbone.history if its already been started", function() {
			Backbone.history.start();
			Backbone.history.started = true;
			spyOn(Backbone.history, 'start');
			CopCentral.initialize({});

			expect(Backbone.history.start).not.toHaveBeenCalled();
		})
	});
});