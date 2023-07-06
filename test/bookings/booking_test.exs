defmodule FlightReservations.Bookings.BookingTest do
  use ExUnit.Case
  alias FlightReservations.Bookings.Booking
  import FlightReservations.Factory

  describe "build/3" do
    test "when all params are valid, returns an booking" do
      user = build(:user)

      response = Booking.build("Teresina", "Fortaleza", user.id)

      assert {:ok,
              %Booking{
                id: _id,
                local_origin: _local_origin,
                local_destination: _local_destination,
                user_id: _user_id
              }} = response
    end

    test "when there are invalid params, returns an error" do
      response = Booking.build("Teresina", "Fortaleza", 123_456_789)

      expected_response = {:error, 'Invalid parameters.'}

      assert expected_response == response
    end
  end
end
