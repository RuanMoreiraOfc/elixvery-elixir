defmodule Elixvery.Users.UserTest do
  use ExUnit.Case

  alias Elixvery.Users.User

  describe "build/5" do
    test "build the struct when all params are valid" do
      name = "User"
      email = "user@email.com"
      address = "St Any Street"
      cpf = "12345678900"
      age = 21

      expected_response = {
        :ok,
        %User{
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

    test "build the struct when all params are valid and age is 18" do
      name = "User"
      email = "user@email.com"
      address = "St Any Street"
      cpf = "12345678900"
      age = 18

      expected_response = {
        :ok,
        %User{
          address: "St Any Street",
          age: 18,
          cpf: "12345678900",
          email: "user@email.com",
          name: "User"
        }
      }

      response = User.build(name, email, address, cpf, age)

      assert response == expected_response
    end

    test "fail to build the struct when cpf is not a string" do
      name = "User"
      email = "user@email.com"
      address = "St Any Street"
      cpf = 123_456_789_00
      age = 18

      expected_response = {
        :error,
        "Invalid parameters!"
      }

      response = User.build(name, email, address, cpf, age)

      assert response == expected_response
    end

    test "fail to build the struct when age is under 18" do
      name = "User"
      email = "user@email.com"
      address = "St Any Street"
      cpf = "12345678900"
      age = 17

      expected_response = {
        :error,
        "Invalid parameters!"
      }

      response = User.build(name, email, address, cpf, age)

      assert response == expected_response
    end
  end
end
