defmodule FlightReservations.Factory do
  use ExMachina
  alias FlightReservations.Users.User
  alias FlightReservations.Bookings.Booking

  def user_factory do
    uuid = UUID.uuid4()

    %User{
      id: uuid,
      name: "Mateus",
      email: "mateus@bananas.com",
      cpf: "123456789"
    }
  end

  def booking_factory do
    id = UUID.uuid4()
    user_id = UUID.uuid4()
    naive_date = NaiveDateTime.local_now()

    %Booking{
      id: id,
      complete_date: naive_date,
      local_origin: "Teresina",
      local_destination: "Fortaleza",
      user_id: user_id
    }
  end
end
