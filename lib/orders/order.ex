defmodule Elixvery.Orders.Order do
  alias Elixvery.Users.User
  alias Elixvery.Orders.Item

  @keys [:user_cpf, :delivery_address, :items, :total_price]
  @enforce_keys @keys

  defstruct @keys

  def build(%User{cpf: userCpf, address: deliveryAddress}, [%Item{} | _items] = items) do
    total_price =
      items
      |> calculate_total_price()

    struct = %__MODULE__{
      user_cpf: userCpf,
      delivery_address: deliveryAddress,
      items: items,
      total_price: total_price
    }

    {:ok, struct}
  end

  def build(_user, _items), do: {:error, "Invalid parameters!"}

  defp calculate_total_price(items) do
    items
    |> Enum.reduce(Decimal.new("0.00"), &calculate_subtotal_price/2)
  end

  defp calculate_subtotal_price(
         %Item{unit_price: unitPrice, quantity: quantity},
         acc
       ) do
    unitPrice
    |> Decimal.mult(quantity)
    |> Decimal.add(acc)
  end
end
