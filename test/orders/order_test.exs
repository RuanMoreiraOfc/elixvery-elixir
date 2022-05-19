defmodule Elixvery.Orders.OrderTest do
  use ExUnit.Case

  import Elixvery.Factory

  alias Elixvery.Orders.Order

  @user build(:user)
  @items [
    build(:item),
    build(:item,
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

    test "fail to build the struct when list of items is empty" do
      items = []
      expected_response = {:error, "Invalid parameters!"}

      response = Order.build(@user, items)

      assert response == expected_response
    end
  end
end
