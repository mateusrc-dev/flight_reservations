defmodule FlightReservations.Bookings.AgentTest do
  use ExUnit.Case
  alias FlightReservations.Bookings.Booking
  alias FlightReservations.Bookings.Agent, as: BookingAgent
  import FlightReservations.Factory

  describe "save/1" do
    test "saves the booking" do
      booking = build(:booking)

      BookingAgent.start_link(%{})

      assert {:ok, %Booking{}} = BookingAgent.save(booking)
    end
  end

  describe "get/1" do
    setup do
      BookingAgent.start_link(%{})

      :ok
    end

    test "when the booking is found, returns the booking" do
      booking = build(:booking)
      {:ok, %Booking{id: id}} = BookingAgent.save(booking)

      response = BookingAgent.get(id)

      expected_response = {:ok, %Booking{} = booking}

      assert response == expected_response
    end
  end
end
