CopCentral.Views.NewCop = Backbone.View.extend({
	tagName: 'form',
	id: "new-cop",

	events: {
		"submit": "save"
	},

	initialize: function(){
		_.bindAll(this, "render");
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
    /* set it as a model attribute without triggering events */
    console.log("AUTH OPTIONS:", auth_options);
    this.model.set(auth_options, {silent: true});
    this.model.save({}, { success: this.saved, error: this.handleError });
	},

	handleError: function() {
		console.log("ERROR ERROR ERROR");
	},

	saved: function(){
		console.log("SAVED SAVED SAVED");
	}
});