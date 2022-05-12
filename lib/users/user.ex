defmodule Elixvery.Users.User do
  @keys [:name, :email, :cpf, :age]
  @enforce_keys @keys

  defstruct @keys

  def build(name, email, cpf, age) when is_bitstring(cpf) and age >= 18 do
    struct = %__MODULE__{
      name: name,
      email: email,
      cpf: cpf,
      age: age
    }

    {:ok, struct}
  end

  def build(_name, _email, _cpf, _age), do: {:error, "Invalid parameters!"}
end
