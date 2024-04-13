defmodule FoodTruckApiWeb.TruckController do
  use FoodTruckApiWeb, :controller
  alias HTTPoison

  @doc """
  Retrieves a list of food trucks.

  ## Examples

      iex> FoodTruckApiWeb.TruckController.index(conn, %{})
      {:ok, %HTTPoison.Response{status_code: 200, body: body}}

  """
  def index(conn, _params) do
    case HTTPoison.get("https://data.sfgov.org/resource/rqzj-sfat.json") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        conn
        |> put_status(200)
        |> json(%{data: body})

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        conn
        |> put_status(404)
        |> json(%{error: "Not Found"})

      {:error, %HTTPoison.Error{reason: reason}} ->
        conn
        |> put_status(500)
        |> json(%{error: "Internal Server Error: #{reason}"})
    end
  end
end
