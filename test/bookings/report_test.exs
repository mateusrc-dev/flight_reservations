defmodule FlightReservations.Bookings.ReportTest do
  use ExUnit.Case

  import FlightReservations.Factory
  alias FlightReservations.Users.Agent, as: UserAgent
  alias FlightReservations.Bookings.Agent, as: BookingAgent
  alias FlightReservations.Bookings.CreateOrUpdate, as: BookingCreateOrUpdate
  alias FlightReservations.Bookings.Report

  describe "create/1" do
    test "creates the report file" do
      UserAgent.start_link(%{})
      BookingAgent.start_link(%{})
      user = build(:user)
      UserAgent.save(user)

      BookingCreateOrUpdate.call(%{
        local_origin: "Teresina",
        local_destination: "Fortaleza",
        user_id: user.id
      })

      BookingCreateOrUpdate.call(%{
        local_origin: "Teresina",
        local_destination: "Fortaleza",
        user_id: user.id
      })

      Report.create("report_test.csv")

      response = File.read("report_test.csv")

      assert {:ok, _text} = response
    end
  end

  describe "report_by_date/2" do
    test "creates the report by date file" do
      response = Report.report_by_date("2023-05-07 13:20:35", "2023-07-07 13:20:35")

      expected_response = {:ok, "Report generated successfully"}

      assert response == expected_response
    end
  end
end
