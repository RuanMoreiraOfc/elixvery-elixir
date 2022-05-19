defmodule Elixvery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Elixvery.Factory

  alias Elixvery.Orders.Agent, as: OrderAgent
  alias Elixvery.Orders.CreateOrUpdate, as: CreateOrUpdateOrder
  alias Elixvery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      user = build(:user)
      item1 = build(:item)
      item2 = build(:item, description: "Atum Pizza", quantity: 8)

      UserAgent.start_link(nil)
      UserAgent.save(user)
      OrderAgent.start_link(nil)

      {:ok, user_cpf: user.cpf, item1: item1, item2: item2}
    end

    test "saves the order in agent when all parameters are valid", %{
      user_cpf: userCpf,
      item1: item1,
      item2: item2
    } do
      expected_response = :ok

      {response, _uuid} =
        CreateOrUpdateOrder.call(%{
          user_cpf: userCpf,
          items: [item1, item2]
        })

      assert response == expected_response
    end

    test "throws error when cpf is invalid", %{
      item1: item1,
      item2: item2
    } do
      invalid_cpf = "00000000000"
      expected_response = {:error, "User not found!"}

      response =
        CreateOrUpdateOrder.call(%{
          user_cpf: invalid_cpf,
          items: [item1, item2]
        })

      assert response == expected_response
    end
  end
end
