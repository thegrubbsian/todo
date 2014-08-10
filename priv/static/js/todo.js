var app = app || {};

(function () {
	"use strict";

	app.Todo = Backbone.Model.extend({
		defaults: function() {
      return {
        title: "",
        completed: false,
        order_index: 0
      };
		},

    destroy: function() {
      Backbone.Model.prototype.destroy.apply(this);
    },

		toggle: function () {
      this.save({ completed: !this.get("completed") });
		}
	});
})();
