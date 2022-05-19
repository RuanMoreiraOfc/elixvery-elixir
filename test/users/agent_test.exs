defmodule Elixvery.Users.AgentTest do
  use ExUnit.Case

  alias Elixvery.Users.Agent, as: UserAgent

  describe "start_link/1" do
    test "starts agent and ensures PID is alive" do
      expected_response = :ok

      {response, pid} = UserAgent.start_link(nil)

      assert response == expected_response
      assert Process.alive?(pid) == true
    end
  end
end
