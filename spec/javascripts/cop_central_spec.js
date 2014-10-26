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

});