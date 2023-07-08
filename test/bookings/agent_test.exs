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

    test "when the booking is not found, returns an error" do
      response = BookingAgent.get("000000000")

      expected_response = {:error, "Booking not found"}

      assert response == expected_response
    end
  end

  describe "get_all/0" do
    setup do
      BookingAgent.start_link(%{})

      :ok
    end

    test "returns all bookings" do
      booking1 = build(:booking)
      booking2 = build(:booking)
      booking3 = build(:booking)
      BookingAgent.save(booking1)
      BookingAgent.save(booking2)
      BookingAgent.save(booking3)

      response = BookingAgent.get_all()

      assert [%Booking{}, %Booking{}, %Booking{}] = Map.values(response)
    end
  end
end
