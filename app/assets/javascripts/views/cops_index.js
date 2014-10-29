CopCentral.Views.CopsIndex = Support.CompositeView.extend({
	events: {
		"click #new-cop-link": "renderNew"
	},

	initialize: function(){
		_.bindAll(this, "render");
		this.bindTo(this.collection, "add", this.renderAfterSave);
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
	},

	renderNew: function(){
		this.newView = new CopCentral.Views.NewCop({ collection: this.collection });
		this.renderChild(this.newView);
		self.$('#new-cop').html(this.newView.el);
	},


	renderFlash: function(flashType, flashText) {
    this.$el.prepend(JST['flash']({ flashText: flashText, type: flashType }));
  },

  renderAfterSave: function() {
  	this.render();
  	this.renderFlash("success", "Saved successfully");
  }
});