CopCentral.Views.NewCop = Support.CompositeView.extend({
	tagName: 'form',
	id: "new-cop-form",

	events: {
		"submit": "save"
	},

	initialize: function(options){
		console.log("OPTIONS:", options.collection);
		_.bindAll(this, "render", "saved");
		this.newCop();
	},

	newCop: function(){
		this.model = new CopCentral.Models.Cop();
	},

	render: function(){
		this.$el.html(JST['cops/form_fields']);
		console.log("DONE:", this.el);
		return this;
	},

	save: function(e){
		e.preventDefault();

		this.commitForm();
		this.setTokenAndSave();
	},

	commitForm: function() {
		this.model.set({ name: this.$('input[name=name]').val() });
		this.model.set({ badge_number: this.$('input[name=badge-number]').val() });
		// this.model.set({ precinct_number: this.$('input[name=precinct-number]').val() });
		console.log("COMMITED FORM MODEL:", this.model);
	},

	setTokenAndSave: function() {
		var auth_options = {};
    auth_options[$("meta[name='csrf-param']").attr('content')] =
                 $("meta[name='csrf-token']").attr('content');
    this.model.set(auth_options, {silent: true});
    this.model.save({}, { success: this.saved, error: this.handleError });
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