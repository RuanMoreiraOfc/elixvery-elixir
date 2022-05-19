defmodule Elixvery.Orders.Report do
  alias Elixvery.Orders.Agent, as: OrderAgent
  alias Elixvery.Orders.{Item, Order}

  def create(filePath \\ "report.csv") do
    order_list = build_order_list()

    filePath
    |> File.write(order_list)
  end

  defp build_order_list do
    OrderAgent.get_all()
    |> Map.values()
    |> Enum.map(&order_string/1)
  end

  defp order_string(%Order{
         user_cpf: userCpf,
         items: items,
         total_price: totalPrice
       }) do
    items_as_string = Enum.map(items, &item_to_string/1)

    "#{userCpf},#{items_as_string}#{totalPrice}\n"
  end

  defp item_to_string(%Item{
         category: category,
         quantity: quantity,
         unit_price: unitPrice
       }) do
    "#{category},#{quantity},#{unitPrice},"
  end
end
