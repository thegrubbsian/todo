defmodule ItemsControllerTest do
  use ExUnit.Case
  import Ecto.Query
  use PlugHelper
  use Jazz

  setup do
    item = Repo.insert(%TodoItem{ title: "Get milk", completed: false, order_index: 0})
    on_exit fn -> Repo.delete(item) end
    { :ok, %{item: item} }
  end

  test "index returns all todos", context do
    conn = simulate_request(Todo.Router, :get, "todos")
    assert conn.status == 200
    assert conn.resp_body == JSON.encode!([context[:item]])
  end

end
