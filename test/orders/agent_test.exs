defmodule Elixvery.Orders.AgentTest do
  use ExUnit.Case

  alias Elixvery.Orders.Agent, as: OrderAgent

  describe "start_link/1" do
    test "starts agent and ensures PID is alive" do
      expected_response = :ok

      {response, pid} = OrderAgent.start_link(nil)

      assert response == expected_response
      assert Process.alive?(pid) == true
    end
  end
end
