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
    setup do
      UserAgent.start_link(nil)

      cpf = "00011122233"

      {:ok, cpf: cpf}
    end

    test "get the user from agent when there is one", %{cpf: cpf} do
      user = build(:user, cpf: cpf)
      expected_response = {:ok, user}

      UserAgent.save(user)
      response = UserAgent.get(cpf)

      assert response == expected_response
    end

    test "fail to get the user from agent when there is no one", %{cpf: cpf} do
      expected_response = {:error, "User not found!"}

      response = UserAgent.get(cpf)

      assert response == expected_response
    end
  end
end
