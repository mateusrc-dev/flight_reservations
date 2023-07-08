defmodule FlightReservations.Bookings.CreateOrUpdateTest do
  use ExUnit.Case
  alias FlightReservations.Bookings.CreateOrUpdate, as: CreateOrUpdate
  alias FlightReservations.Bookings.Agent, as: BookingAgent
  alias FlightReservations.Users.Agent, as: UserAgent
  import FlightReservations.Factory

  describe "call/1" do
    setup do
      BookingAgent.start_link(%{})
      UserAgent.start_link(%{})
      :ok
    end

    test "when all params are valid, saves the booking" do
      user = build(:user)
      UserAgent.save(user)
      params = %{local_origin: "Teresina", local_destination: "Fortaleza", user_id: user.id}

      response = CreateOrUpdate.call(params)

      expected_response = {:ok, ~c"Booking created or updated with success"}

      assert response == expected_response
    end

    test "when there are param is invalid, returns an error" do
      user = build(:user)
      UserAgent.save(user)
      params = %{local_origin: 1, local_destination: "Fortaleza", user_id: user.id}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, ~c"Invalid parameters."}

      assert response == expected_response
    end

    test "when there are user id invalid, returns an error" do
      params = %{local_origin: "Teresina", local_destination: "Fortaleza", user_id: "00000000"}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
