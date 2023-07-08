defmodule FlightReservationsTest do
  use ExUnit.Case
  alias FlightReservations.Users.Agent, as: UserAgent
  import FlightReservations.Factory

  describe "create_or_update_user/1" do
    test "create and save the user" do
      FlightReservations.start_agents()

      params = %{name: "Mateus", email: "mateus@bananas.com", cpf: "123456789"}

      response = FlightReservations.create_or_update_user(params)

      expected_response = {:ok, ~c"User created or updated with success"}

      assert response == expected_response
    end

    test "create and save the booking" do
      FlightReservations.start_agents()

      user = build(:user)
      UserAgent.save(user)

      params = %{local_origin: "Teresina", local_destination: "Fortaleza", user_id: user.id}

      response = FlightReservations.create_or_update_booking(params)

      expected_response = {:ok, ~c"Booking created or updated with success"}

      assert response == expected_response
    end
  end
end
