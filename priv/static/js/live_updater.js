var app = app || {};

(function() {
  "use strict";

  var LiveUpdater = function() {

    var socket = new Phoenix.Socket("ws://" + location.host +  "/ws");
    var todos;

    function initialize(collection, userId) {
      todos = collection;
      socket.join("todos", "public", { user_id: userId }, setupSocketEvents);
    }

    function setupSocketEvents(channel) {
      channel.on("todo:created", handleTodoCreated);
      channel.on("todo:updated", handleTodoUpdated);
      channel.on("todo:deleted", handleTodoDeleted);
    }

    function handleTodoCreated(todo) {
      todos.add(todo);
    }

    function handleTodoUpdated(todo) {
      var existing = todos.get(todo.id);
      existing.set(todo);
    }

    function handleTodoDeleted(todo) {
      todos.remove(todos.get(todo.id));
    }

    return {
      socket: socket,
      initialize: initialize
    };
  };

  app.liveUpdater = new LiveUpdater();
})();
