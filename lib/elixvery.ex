defmodule Elixvery do
  alias Elixvery.Orders.Agent, as: OrderAgent
  alias Elixvery.Orders.CreateOrUpdate, as: CreateOrUpdateOrder
  alias Elixvery.Users.Agent, as: UserAgent
  alias Elixvery.Users.CreateOrUpdate, as: CreateOrUpdateUser

  def start_agents do
    UserAgent.start_link(nil)
    OrderAgent.start_link(nil)
  end

  defdelegate create_or_update_user(params), to: CreateOrUpdateUser, as: :call
  defdelegate create_or_update_order(params), to: CreateOrUpdateOrder, as: :call
end
