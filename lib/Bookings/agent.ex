defmodule FlightReservations.Bookings.Agent do
  alias FlightReservations.Bookings.Booking

  use Agent

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{} = booking) do
    Agent.update(__MODULE__, fn state -> update_state(state, booking) end)

    {:ok, %Booking{} = booking}
  end

  def get_all() do
    Agent.get(__MODULE__, fn state -> state end)
  end

  def get(id) do
    Agent.get(__MODULE__, fn state -> get_booking(state, id) end)
  end

  defp get_booking(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Booking not found"}
      booking -> {:ok, booking}
    end
  end

  defp update_state(state, %Booking{id: id} = booking) do
    Map.put(state, id, booking)
  end
end
