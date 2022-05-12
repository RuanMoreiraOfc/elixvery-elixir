defmodule Elixvery.Users.User do
  @keys [:name, :email, :address, :cpf, :age]
  @enforce_keys @keys

  defstruct @keys

  def build(name, email, address, cpf, age) when is_bitstring(cpf) and age >= 18 do
    struct = %__MODULE__{
      name: name,
      address: address,
      email: email,
      cpf: cpf,
      age: age
    }

    {:ok, struct}
  end

  def build(_name, _email, _address, _cpf, _age), do: {:error, "Invalid parameters!"}
end
