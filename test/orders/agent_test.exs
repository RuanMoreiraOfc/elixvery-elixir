defmodule Elixvery.Orders.AgentTest do
  use ExUnit.Case

  alias Elixvery.Orders.Agent, as: OrderAgent

  import Elixvery.Factory

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
end
