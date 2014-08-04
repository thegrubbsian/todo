var app = app || {};

(function() {
  "use strict";

  var LiveUpdater = function(todos) {

    var socket = new Phoenix.Socket("ws://" + location.host +  "/ws");

    socket.join("todo_items", "todo_items", {}, function(channel) {
      channel.on("todo:created", handleTodoCreated);
      channel.on("todo:updated", handleTodoUpdated);
      channel.on("todo:deleted", handleTodoDeleted);
    });

    function handleTodoCreated(todo) {
      todo = JSON.parse(todo);
      if (!todos.findWhere({ guid: todo.guid })) { todos.add(todo); }
    }

    function handleTodoUpdated(todo) {
      todo = JSON.parse(todo);
      var existing = todos.get(todo.id);
      existing.set(todo);
    }

    function handleTodoDeleted(todo) {
      todo = JSON.parse(todo);
      todos.remove(todos.get(todo.id));
    }

    return {
      socket: socket
    };
  };

  app.liveUpdater = new LiveUpdater(app.todos);
})();
