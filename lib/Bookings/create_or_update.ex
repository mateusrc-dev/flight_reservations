defmodule FlightReservations.Bookings.CreateOrUpdate do
  alias FlightReservations.Users.Agent, as: UserAgent
  alias FlightReservations.Bookings.Agent, as: BookingAgent
  alias FlightReservations.Bookings.Booking

  def call(%{local_origin: local_origin, local_destination: local_destination, user_id: user_id}) do
    with {:ok, _user} <- UserAgent.get(user_id),
         {:ok, %Booking{} = booking} <- Booking.build(local_origin, local_destination, user_id) do
      save_booking({:ok, booking})
    else
      error -> error
    end
  end

  defp save_booking({:ok, %Booking{} = booking}) do
    BookingAgent.save(booking)
  end

  defp save_booking({:error, _reason = error}) do
    error
  end
end
