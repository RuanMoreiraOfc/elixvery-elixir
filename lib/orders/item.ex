defmodule Elixvery.Orders.Item do
  @categories [:pizza, :hamburger, :meat, :lunch, :japonese_food, :dessert]
  @keys [:description, :category, :unit_price, :quantity]
  @enforce_keys @keys

  defstruct @keys

  def build(description, category, unitPrice, quantity)
      when category in @categories and quantity > 0 do
    unitPrice
    |> Decimal.cast()
    |> build_item(description, category, quantity)
  end

  def build(_description, _category, _unitPrice, _quantity) do
    {:error, "Invalid parameters!"}
  end

  defp build_item({:ok, unitPrice}, description, category, quantity) do
    struct = %__MODULE__{
      description: description,
      category: category,
      unit_price: unitPrice,
      quantity: quantity
    }

    {:ok, struct}
  end

  defp build_item(:error, _description, _category, _quantity) do
    {:error, "Invalid price!"}
  end
end
