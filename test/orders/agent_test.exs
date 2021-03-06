defmodule Elixvery.Orders.AgentTest do
  use ExUnit.Case

  import Elixvery.Factory

  alias Elixvery.Orders.Agent, as: OrderAgent

  describe "start_link/1" do
    test "starts agent and ensures PID is alive" do
      expected_response = :ok

      {response, pid} = OrderAgent.start_link(nil)

      assert response == expected_response
      assert Process.alive?(pid) == true
    end
  end

  describe "save/1" do
    test "saves the order in agent" do
      order = build(:order)
      expected_response = :ok

      OrderAgent.start_link(nil)
      {response, _uuid} = OrderAgent.save(order)

      assert response == expected_response
    end
  end

  describe "get/1" do
    setup do
      OrderAgent.start_link(nil)

      :ok
    end

    test "get the order from agent when there is one" do
      order = build(:order)
      expected_response = {:ok, order}

      {:ok, uuid} = OrderAgent.save(order)
      response = OrderAgent.get(uuid)

      assert response == expected_response
    end

    test "fail to get the order from agent when there is no one" do
      uuid = UUID.uuid4()
      expected_response = {:error, "Order not found!"}

      response = OrderAgent.get(uuid)

      assert response == expected_response
    end
  end
end
