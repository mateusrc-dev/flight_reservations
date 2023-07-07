defmodule FlightReservations.Users.CreateOrUpdateTest do
  use ExUnit.Case
  alias FlightReservations.Users.CreateOrUpdate
  alias FlightReservations.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, saves the user" do
      params = %{
        name: "Mateus",
        email: "mateus@email.com",
        cpf: "123456"
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:ok, 'User created or updated with success'}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Mateus",
        email: "mateus@email.com",
        cpf: 123_456
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, 'Invalid parameters.'}

      assert response == expected_response
    end
  end
end
