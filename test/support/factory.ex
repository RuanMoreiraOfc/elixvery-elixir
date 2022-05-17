defmodule Elixvery.Factory do
  use ExMachina

  alias Elixvery.Orders.Item
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

  def item_factory do
    %Item{
      description: "Pepperoni Pizza",
      category: :pizza,
      unit_price: Decimal.new("35.5"),
      quantity: 1
    }
  end
end
