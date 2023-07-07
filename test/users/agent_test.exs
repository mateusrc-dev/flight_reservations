defmodule FlightReservations.Users.AgentTest do
  use ExUnit.Case
  alias FlightReservations.Users.User
  alias FlightReservations.Users.Agent, as: UserAgent

  import FlightReservations.Factory

  describe "save/1" do
    test "saves the user" do
      user = build(:user)

      UserAgent.start_link(%{})

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when the user is found, returns the user" do
      user = build(:user)
      UserAgent.save(user)

      response = UserAgent.get(user.id)

      assert {:ok, %User{}} = response
    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("000000000")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
