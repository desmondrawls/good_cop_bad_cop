CopCentral.Views.CopsIndex = Support.CompositeView.extend({
	initialize: function(){
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
			var itemView = new CopCentral.Views.CopItem({model: cop});
			self.renderChild(itemView);
			self.$('#cops-list').append(itemView.el);
		});
	}
});