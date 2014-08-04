var app = app || {};

(function () {
	"use strict";

	app.Todo = Backbone.Model.extend({
		defaults: function() {
      return {
        title: "",
        completed: false,
        guid: _.times(6, function() { return _.random(1000,9999); }).join("-")
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
