describe("CopCentral.Models.Cop", function(){
	describe("#parseComments()", function(){
		var commentsAttr, copAttr, copModel;

		beforeEach(function(){
			commentsAttr = [{"title": "Funny Accent", "author": "Fargo Resident", "text": "She talks funny but she does her job professionally."},
									{"title": "Pregnant?", "author": "Shep Proudfoot", "text": "What sort of woman becomes a cop and then runs around with a gun while she's pregnant?"}]
			copAttr = { "name": "Marge Gunderson", "badge_number":"9999", "comments": commentsAttr }

			copModel = new CopCentral.Models.Cop(copAttr);
		});

		it("calls for a new Comments collection", function(){
			spyOn(CopCentral.Collections, 'Comments');
			copModel.parseComments();
			expect(CopCentral.Collections.Comments).toHaveBeenCalled();
		});

		it("creates a Comments collection of the right length", function(){
			copModel.parseComments();
			var comments = copModel.comments;
			var typeCheck = comments instanceof CopCentral.Collections.Comments;
			expect(typeCheck).toEqual(true);
			expect(comments.length).toEqual(2);
		});

		it("populates the collection with Comment models", function(){
			copModel.parseComments();
			var comments = copModel.comments;
			var typeCheck = comments.first() instanceof CopCentral.Models.Comment
			expect(typeCheck).toEqual(true);
			expect(comments.first().get('title')).toEqual('Funny Accent');
		});
	});
});