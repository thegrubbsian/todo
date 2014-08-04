var app = app || {};

(function () {
	"use strict";

	var Todos = Backbone.Collection.extend({
		model: app.Todo,

    url: "/todos",

		completed: function () {
			return this.where({completed: true});
		},

		remaining: function () {
			return this.where({completed: false});
		},

    // TODO: Get rid of this
		nextOrder: function () {
			return this.length ? this.last().get("order") + 1 : 1;
		},

		comparator: "order"
	});

	app.todos = new Todos();
})();
