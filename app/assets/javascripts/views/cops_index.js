CopCentral.Views.CopsIndex = Backbone.View.extend({
	initialize: function(){
		console.log("COPSINDEX INITIALIZED WITH:", this.collection);
		_.bindAll(this, "render");
	},

	render: function(){
		this.$el.html(JST['cops/index']({}));
		this.renderCops();
		return this;
	},

	renderCops: function(){
		var self = this;
		self.$('#cops-list').empty();
		this.collection.each(function(cop){
			var item = new CopCentral.Views.CopItem({model: cop});
			self.$('#cops-list').append(item.render().el);
		});
	}
});