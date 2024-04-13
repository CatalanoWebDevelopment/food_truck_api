defmodule FoodTruckApiWeb.TruckController do
  use FoodTruckApiWeb, :controller
  alias HTTPoison
  alias Schema.Truck

  @doc """
  Retrieves a list of food trucks.

  ## Examples

      iex> TruckController.index(%Plug.Conn{}, %{})
      {:ok, [%Truck{}]}

      iex> TruckController.index(%Plug.Conn{}, %{})
      {:error, "Not Found"}

      iex> TruckController.index(%Plug.Conn{}, %{})
      {:error, "Internal Server Error: reason"}

  ## Route

      GET /api/trucks
  """
  @spec index(Plug.Conn.t(), map) :: [Truck.t()] | {:error, String.t()}
  def index(conn, _params) do
    case http_client().get("https://data.sfgov.org/resource/rqzj-sfat.json") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        conn
        |> put_status(200)
        |> json(%{data: Truck.build_data_from_query(Jason.decode!(body))})

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

  defp http_client do
    Application.get_env(:food_truck_api, :http_client)
  end
end
