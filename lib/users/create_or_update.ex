defmodule Elixvery.Users.CreateOrUpdate do
  alias Elixvery.Users
  alias Users.Agent, as: UserAgent
  alias Users.User

  def call(%{name: name, address: address, email: email, cpf: cpf, age: age}) do
    User.build(name, email, address, cpf, age)
    |> save_user
  end

  defp save_user({:ok, %User{} = user}), do: UserAgent.save(user)
  defp save_user({:error, _reason} = error), do: error
end
