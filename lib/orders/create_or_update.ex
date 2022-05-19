defmodule Elixvery.Orders.CreateOrUpdate do
  alias Elixvery.{Orders, Users}
  alias Orders.Agent, as: OrderAgent
  alias Orders.{Item, Order}
  alias Users.Agent, as: UserAgent

  def call(%{user_cpf: userCpf, items: items}) do
    with {:ok, user} <- UserAgent.get(userCpf),
         {:ok, treated_items} <- build_items(items),
         {:ok, order} <- Order.build(user, treated_items) do
      OrderAgent.save(order)
    else
      error -> error
    end
  end

  defp build_items(items) do
    items
    |> Enum.map(&build_item/1)
    |> handle_build
  end

  defp build_item(%{
         description: description,
         category: category,
         unit_price: unitPrice,
         quantity: quantity
       }) do
    case Item.build(description, category, unitPrice, quantity) do
      {:ok, item} -> item
      {:error, _reason} = error -> error
    end
  end

  defp handle_build(items) do
    is_all_valid = Enum.all?(items, &is_struct/1)

    if is_all_valid do
      {:ok, items}
    else
      {:error, "Not all items are valid!"}
    end
  end
end
