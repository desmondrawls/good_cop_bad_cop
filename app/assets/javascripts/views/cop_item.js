CopCentral.Views.CopItem = Backbone.View.extend({
	initialize: function() {
		_.bindAll(this, "render");
	},

	render: function(){
		this.$el.html(JST['cops/item']({ cop: this.model }));
		this.fillTemplate();
		return this;
	},

	fillTemplate: function(){
		this.$('a').text(this.model.escape('name'));
		this.$('a').attr("href", this.copUrl());
		this.$('p').text(this.model.escape('badge_number'));
	},

	copUrl: function() {
		return "#cops/" + this.model.get('id');
	}
});