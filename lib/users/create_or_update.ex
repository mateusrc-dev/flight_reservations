defmodule FlightReservations.Users.CreateOrUpdate do
  alias FlightReservations.Users.User
  alias FlightReservations.Users.Agent, as: UserAgent

  def call(%{name: name, email: email, cpf: cpf}) do
    name
    |> User.build(email, cpf)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)
  end

  defp save_user({:error, _reason = error}) do
    error
  end
end
