defmodule Elixvery.Users.AgentTest do
  use ExUnit.Case

  alias Elixvery.Users.Agent, as: UserAgent

  import Elixvery.Factory

  describe "start_link/1" do
    test "starts agent and ensures PID is alive" do
      expected_response = :ok

      {response, pid} = UserAgent.start_link(nil)

      assert response == expected_response
      assert Process.alive?(pid) == true
    end
  end

  describe "save/1" do
    test "saves the user in agent" do
      user = build(:user)
      expected_response = {:ok, user.cpf}

      UserAgent.start_link(nil)
      response = UserAgent.save(user)

      assert response == expected_response
    end
  end

  describe "get/1" do
    test "get the user from agent when there is one" do
      cpf = "00011122233"
      user = build(:user, cpf: cpf)
      expected_response = {:ok, user}

      UserAgent.start_link(nil)
      UserAgent.save(user)
      response = UserAgent.get(cpf)

      assert response == expected_response
    end
  end
end
