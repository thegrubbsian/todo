defmodule User do
  use Ecto.Model

  schema "users" do
    field :socket_token
    field :name
  end

  def crete(name) do
    user = Repo.create(%User{ name: name, socket_token: generate_token })
  end

  defp generate_token do
    :crypto.strong_rand_bytes(20)
      |> :base64.encode_to_string
      |> to_string
  end

end
