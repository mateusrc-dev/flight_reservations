defmodule FlightReservations.Users.UserTest do
  use ExUnit.Case

  alias FlightReservations.Users.User

  describe "build/1" do
    test "when all the params are valid, returns the user" do
      response = User.build("Mateus", "mateus@bananas.com", "123456")

      assert {:ok, %User{id: _id, name: _name, email: _email, cpf: _cpf}} = response
    end

    test "when there are invalid params, returns an error" do
      response = User.build("Mateus", "mateus@bananas.com", 123_456)

      expected_response = {:error, 'Invalid parameters.'}

      assert expected_response == response
    end
  end
end
