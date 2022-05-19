defmodule Elixvery.Orders.Agent do
  alias Elixvery.Orders.Order

  use Agent

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get(uuid) do
    Agent.get(__MODULE__, &get_order(&1, uuid))
  end

  def save(%Order{} = order) do
    uuid = UUID.uuid4()

    Agent.update(__MODULE__, &update_state(&1, order, uuid))

    {:ok, uuid}
  end

  defp get_order(state, uuid) do
    case Map.get(state, uuid) do
      nil -> {:error, "Order not found!"}
      order -> {:ok, order}
    end
  end

  defp update_state(oldState, %Order{} = order, uuid) do
    Map.put(oldState, uuid, order)
  end
end
