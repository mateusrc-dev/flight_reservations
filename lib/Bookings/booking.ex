defmodule FlightReservations.Bookings.Booking do
  @keys [:id, :complete_date, :local_origin, :local_destination, :user_id]

  @enforce_keys @keys

  defstruct @keys

  def build(local_origin, local_destination, user_id) when is_bitstring(user_id) do
    uuid = UUID.uuid4()
    naive_date = NaiveDateTime.local_now()

    {
      :ok,
      %__MODULE__{
        id: uuid,
        complete_date: naive_date,
        local_origin: local_origin,
        local_destination: local_destination,
        user_id: user_id
      }
    }
  end

  def build(_local_origin, _local_destination, _user_id) do
    {:error, 'Invalid parameters.'}
  end
end
