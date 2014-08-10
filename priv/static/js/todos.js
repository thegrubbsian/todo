var app = app || {};

(function () {
	"use strict";

	var Todos = Backbone.Collection.extend({
		model: app.Todo,

    url: "/todos",

		completed: function () {
			return this.where({ completed: true });
		},

		remaining: function () {
			return this.where({ completed: false });
		},

		nextOrder: function () {
      return (this.pluck("order_index").sort().reverse()[0] || 0) + 1;
		},

		comparator: function(item_a, item_b) {
      var order_a = item_a.get("order_index") || 0;
      var order_b = item_b.get("order_index") || 0;
      if (order_a > order_b) { return -1; }
      if (order_a == order_b) { return 0; }
      if (order_a < order_b) { return 1; }
    }
	});

	app.todos = new Todos();
})();
