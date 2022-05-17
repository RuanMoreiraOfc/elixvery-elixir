defmodule Elixvery.Factory do
  use ExMachina

  alias Elixvery.Orders.{Item, Order}
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

  def order_factory do
    %Order{
      delivery_address: "St Any Street",
      items: [
        build(:item),
        build(:item,
          category: :japonese_food,
          description: "Temaki",
          quantity: 2,
          unit_price: Decimal.new("20.5")
        )
      ],
      total_price: Decimal.new("76.50"),
      user_cpf: "12345678900"
    }
  end
end
