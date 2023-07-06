defmodule FlightReservations.Users.Agent do
  alias FlightReservations.Users.User

  use Agent

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user) do
    Agent.update(__MODULE__, fn state -> update_state(state, user) end)
  end

  def get_all() do
    Agent.get(__MODULE__, fn state -> state end)
  end

  def get(id) do
    Agent.get(__MODULE__, fn state -> get_user(state, id) end)
  end

  defp get_user(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  defp update_state(state, %User{id: id} = user) do
    Map.put(state, id, user)
  end
end
