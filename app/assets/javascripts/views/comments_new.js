CopCentral.Views.NewComment = Support.CompositeView.extend({
	tagName: 'form',
	id: "new-comment-form",

	events: {
		"submit": "save"
	},

	initialize: function(options){
		console.log("COLLECTION FOR NEW COMMENT VIEW:", options.collection);
		_.bindAll(this, "render", "saved");
		this.newComment();
	},

	newComment: function(){
		this.model = new CopCentral.Models.Comment();
		this.model.urlRoot = this.collection.url;
	},

	render: function(){
		this.$el.html(JST['comments/form_fields']);
		console.log("DONE:", this.el);
		return this;
	},

	save: function(e){
		e.preventDefault();

		this.commitForm();
    this.model.save({}, { success: this.saved, error: this.handleError });
	},

	commitForm: function() {
		this.model.set({ title: this.$('input[name=title]').val() });
		this.model.set({ text: this.$('input[name=text]').val() });
		this.model.set({ author: this.$('input[name=author]').val() });
		var auth_options = {};
    auth_options[$("meta[name='csrf-param']").attr('content')] =
                 $("meta[name='csrf-token']").attr('content');
    this.model.set(auth_options, {silent: true});
	},

	// TODO: flash proper error messages. Maybe create an errors model/collection with parsing methods.
	// Connect errors to the corresponding input field.
	handleError: function(model, response) {
		console.log("ERROR:", response.responseText);
	},

	saved: function(){
		this.collection.add(this.model);
		this.leave();
	}
});