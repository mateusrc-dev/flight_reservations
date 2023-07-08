defmodule FlightReservations.Bookings.Report do
  alias FlightReservations.Bookings.Agent, as: BookingAgent
  alias FlightReservations.Bookings.Booking

  def create(filename \\ "report.csv") do
    bookings_list = build_bookings_list()

    File.write(filename, bookings_list)
  end

  def report_by_date(from_date, to_date) do
    "report.csv"
    |> File.stream!()
    |> Enum.map(fn line -> parse_line(line) end)
    |> Enum.map(fn line -> gen_report(line, from_date, to_date) end)
    |> Enum.filter(fn elem -> elem !== nil end)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
  end

  defp gen_report(
         [id, complete_date, local_origin, local_destination, user_id],
         from_date,
         to_date
       ) do
    parse_date =
      complete_date
      |> String.trim()
      |> String.split(" ")

    date =
      List.first(parse_date)
      |> String.trim()
      |> String.split("-")

    [day, month, year] = date

    time =
      List.last(parse_date)
      |> String.trim()
      |> String.split(":")

    [hour, minute, seconds] = time

    parse_from_date_complete =
      from_date
      |> String.trim()
      |> String.split(" ")

    parse_from_date =
      List.first(parse_from_date_complete)
      |> String.trim()
      |> String.split("-")

    [from_date_day, from_date_month, from_date_year] = parse_from_date

    parse_from_date_time =
      List.last(parse_from_date_complete)
      |> String.trim()
      |> String.split(":")

    [from_date_hour, from_date_minute, from_date_seconds] = parse_from_date_time

    parse_to_date_complete =
      to_date
      |> String.trim()
      |> String.split(" ")

    parse_to_date =
      List.first(parse_to_date_complete)
      |> String.trim()
      |> String.split("-")

    [to_date_day, to_date_month, to_date_year] = parse_to_date

    parse_to_date_time =
      List.last(parse_to_date_complete)
      |> String.trim()
      |> String.split(":")

    [to_date_hour, to_date_minute, to_date_seconds] = parse_to_date_time

    {:ok, naive_date_complete} =
      NaiveDateTime.new(
        Date.new!(
          String.to_integer(day),
          String.to_integer(month),
          String.to_integer(year)
        ),
        Time.new!(
          String.to_integer(hour),
          String.to_integer(minute),
          String.to_integer(seconds),
          000
        )
      )

    {:ok, naive_from_date_complete} =
      NaiveDateTime.new(
        Date.new!(
          String.to_integer(from_date_day),
          String.to_integer(from_date_month),
          String.to_integer(from_date_year)
        ),
        Time.new!(
          String.to_integer(from_date_hour),
          String.to_integer(from_date_minute),
          String.to_integer(from_date_seconds),
          000
        )
      )

    {:ok, naive_to_date_complete} =
      NaiveDateTime.new(
        Date.new!(
          String.to_integer(to_date_day),
          String.to_integer(to_date_month),
          String.to_integer(to_date_year)
        ),
        Time.new!(
          String.to_integer(to_date_hour),
          String.to_integer(to_date_minute),
          String.to_integer(to_date_seconds),
          000
        )
      )

    is_after = NaiveDateTime.after?(naive_date_complete, naive_from_date_complete)
    is_before = NaiveDateTime.before?(naive_date_complete, naive_to_date_complete)

    case is_after and is_before == true do
      true ->
        booking_string(%Booking{
          id: id,
          complete_date: complete_date,
          local_origin: local_origin,
          local_destination: local_destination,
          user_id: user_id
        })

      false ->
        nil
    end
  end

  defp build_bookings_list() do
    BookingAgent.get_all()
    |> Map.values()
    |> Enum.map(fn booking -> booking_string(booking) end)
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
