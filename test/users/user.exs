defmodule Elixvery.Users.UserTest do
  use ExUnit.Case

  alias Elixvery.Users.User

  import Elixvery.Factory

  @name "User"
  @email "user@email.com"
  @address "St Any Street"
  @cpf "12345678900"
  @age 21

  describe "build/5" do
    test "build the struct when all params are valid" do
      expected_response = {:ok, build(:user)}

      response = User.build(@name, @email, @address, @cpf, @age)

      assert response == expected_response
    end

    test "build the struct when all params are valid and age is 18" do
      age = 18
      expected_response = {:ok, build(:user, age: age)}

      response = User.build(@name, @email, @address, @cpf, age)

      assert response == expected_response
    end

    test "fail to build the struct when cpf is not a string" do
      cpf = 123_456_789_00
      expected_response = {:error, "Invalid parameters!"}

      response = User.build(@name, @email, @address, cpf, @age)

      assert response == expected_response
    end

    test "fail to build the struct when age is under 18" do
      age = 17
      expected_response = {:error, "Invalid parameters!"}

      response = User.build(@name, @email, @address, @cpf, age)

      assert response == expected_response
    end
  end
end
