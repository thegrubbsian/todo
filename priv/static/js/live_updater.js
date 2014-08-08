var app = app || {};

(function() {
  "use strict";

  var LiveUpdater = function(todos) {

    var socket = new Phoenix.Socket("ws://" + location.host +  "/ws");
    var identifier = _.times(6, function() { return _.random(1000,9999); }).join("-");

    socket.join("todo_items", "todo_items", identifier, function(channel) {
      channel.on("todo:created", handleTodoCreated);
      channel.on("todo:updated", handleTodoUpdated);
      channel.on("todo:deleted", handleTodoDeleted);
    });

    function handleTodoCreated(data) {
      if (data.identifier == identifier) { return; }
      todos.add(data.data);
    }

    function handleTodoUpdated(todo) {
      if (data.identifier == identifier) { return; }
      var existing = todos.get(data.data.id);
      existing.set(data.todo);
    }

    function handleTodoDeleted(todo) {
      if (data.identifier == identifier) { return; }
      todos.remove(todos.get(data.data.id));
    }

    return {
      socket: socket,
      identifier: identifier
    };
  };

  app.liveUpdater = new LiveUpdater(app.todos);
})();
