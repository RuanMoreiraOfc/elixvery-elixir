defmodule Elixvery.Orders.ItemTest do
  use ExUnit.Case

  alias Elixvery.Orders.Item

  import Elixvery.Factory

  @description "Pepperoni Pizza"
  @category :pizza
  @unit_price Decimal.new("35.5")
  @quantity 1

  describe "build/4" do
    test "build the struct when all params are valid" do
      expected_response = {:ok, build(:item)}

      response = Item.build(@description, @category, @unit_price, @quantity)

      assert response == expected_response
    end

    test "fail to build the struct when category is not valid" do
      category = :not_edible
      expected_response = {:error, "Invalid parameters!"}

      response = Item.build(@description, category, @unit_price, @quantity)

      assert response == expected_response
    end

    test "fail to build the struct when quantity is less than one" do
      quantity = 0
      expected_response = {:error, "Invalid parameters!"}

      response = Item.build(@description, @category, @unit_price, quantity)

      assert response == expected_response
    end
  end
end
