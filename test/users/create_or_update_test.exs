defmodule Elixvery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Elixvery.Users.Agent, as: UserAgent
  alias Elixvery.Users.CreateOrUpdate, as: CreateOrUpdateUser

  describe "call/1" do
    setup do
      UserAgent.start_link(nil)

      user = %{
        name: "_",
        email: "_@email.com",
        address: "St Any Street",
        cpf: "00987654321",
        age: 18
      }

      {:ok, user: user}
    end

    test "saves the user in agent when all parameters are valid", %{user: user} do
      expected_response = {:ok, "User saved successfully!"}

      response = CreateOrUpdateUser.call(user)

      assert response == expected_response
    end
  end
end
