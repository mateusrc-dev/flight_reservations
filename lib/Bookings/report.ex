defmodule FlightReservations.Bookings.Report do
  alias FlightReservations.Bookings.Agent, as: BookingAgent
  alias FlightReservations.Bookings.Booking

  def create(filename \\ "report.csv") do
    bookings_list = build_bookings_list()

    File.write(filename, bookings_list)
  end

  defp build_bookings_list() do
    BookingAgent.get_all()
    |> Map.values()
    |> Enum.map(fn booking -> booking_string(booking) end)
    |> IO.inspect()
  end

  defp booking_string(%Booking{
         id: id,
         complete_date: complete_date,
         local_origin: local_origin,
         local_destination: local_destination,
         user_id: user_id
       }) do
    "#{id}, #{complete_date}, #{local_origin}, #{local_destination}, #{user_id}\n"
  end
end
