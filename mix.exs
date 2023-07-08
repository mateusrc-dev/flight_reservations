defmodule FlightReservations.MixProject do
  use Mix.Project

  def project do
    [
      app: :flight_reservations,
      version: "0.1.0",
      elixir: "~> 1.15.2",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:elixir_uuid, "~> 1.2"},
      {:ex_machina, "~> 2.7.0"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
