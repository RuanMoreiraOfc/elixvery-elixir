defmodule Elixvery.Orders.OrderTest do
  use ExUnit.Case

  alias Elixvery.Orders.Order

  import Elixvery.Factory

  @user build(:user)
  @items [
    build(:item),
    build(
      :item,
      description: "Temaki",
      category: :japonese_food,
      quantity: 2,
      unit_price: Decimal.new("20.5")
    )
  ]

  describe "build/2" do
    test "build the struct when all params are valid" do
      expected_response = {:ok, build(:order)}

      response = Order.build(@user, @items)

      assert response == expected_response
    end
  end
end
