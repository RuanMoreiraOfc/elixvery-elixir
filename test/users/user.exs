defmodule Elixvery.Users.UserTest do
  alias Elixvery.Users.User
  use ExUnit.Case

  describe "build/5" do
    test "build the struct when all params are valid" do
      name = "User"
      email = "user@email.com"
      address = "St Any Street"
      cpf = "12345678900"
      age = 21

      expected_response = {
        :ok,
        %Elixvery.Users.User{
          address: "St Any Street",
          age: 21,
          cpf: "12345678900",
          email: "user@email.com",
          name: "User"
        }
      }

      response = User.build(name, email, address, cpf, age)

      assert response == expected_response
    end
  end
end