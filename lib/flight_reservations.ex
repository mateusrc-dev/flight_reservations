defmodule FlightReservations do
  alias FlightReservations.Users.Agent, as: UserAgent
  alias FlightReservations.Users.CreateOrUpdate

  def start_agents do
    UserAgent.start_link(%{})
  end

  defdelegate create_or_update_user(params), to: CreateOrUpdate, as: :call
end
