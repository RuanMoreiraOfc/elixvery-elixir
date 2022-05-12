defmodule Elixvery.Factory do
  use ExMachina

  alias Elixvery.Users.User

  def user_factory do
    %User{
      name: "User",
      email: "user@email.com",
      address: "St Any Street",
      cpf: "12345678900",
      age: 21
    }
  end
end
