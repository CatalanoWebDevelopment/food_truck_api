defmodule FoodTruckApiWeb.TruckController do
  use FoodTruckApiWeb, :controller
  alias HTTPoison
  alias Schema.Truck

  @base_url "https://data.sfgov.org/resource/rqzj-sfat.json"
  @approved_url "https://data.sfgov.org/resource/rqzj-sfat.json?status=APPROVED"

  @doc """
  Retrieves a list of food trucks in the San Francisco area.

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
    {status, response} = HTTPoison.get(@base_url)
    handle_response(conn, {status, response}, &Truck.build_data_from_query/1)
  end

  @doc """
  Retrieves a list of food trucks with an approved permit in the San Francisco area.

  ## Examples

      iex> TruckController.list_approved_trucks(%Plug.Conn{}, %{})
      {:ok, [%Truck{}]}

      iex> TruckController.list_approved_trucks(%Plug.Conn{}, %{})
      {:error, "Not Found"}

      iex> TruckController.list_approved_trucks(%Plug.Conn{}, %{})
      {:error, "Internal Server Error: reason"}

  ## Route

      GET /api/trucks/approved
  """
  @spec list_approved_trucks(Plug.Conn.t(), map) :: [Truck.t()] | {:error, String.t()}
  def list_approved_trucks(conn, _params) do
    {status, response} = HTTPoison.get(@approved_url)
    handle_response(conn, {status, response}, &Truck.build_data_from_query/1)
  end

  @doc """
  Retrieves a list of taco trucks with an approved permit in the San Francisco area.

  ## Examples

      iex> TruckController.list_taco_trucks(%Plug.Conn{}, %{})
      {:ok, [%Truck{}]}

      iex> TruckController.list_taco_trucks(%Plug.Conn{}, %{})
      {:error, "Not Found"}

      iex> TruckController.list_taco_trucks(%Plug.Conn{}, %{})
      {:error, "Internal Server Error: reason"}

  ## Route

      GET /api/trucks/taco
  """
  @spec list_taco_trucks(Plug.Conn.t(), map) :: [Truck.t()] | {:error, String.t()}
  def list_taco_trucks(conn, _params) do
    {status, response} = HTTPoison.get(@approved_url)
    handle_response(conn, {status, response}, &Truck.list_taco_trucks/1)
  end

  defp handle_response(conn, {:ok, %HTTPoison.Response{status_code: 200, body: body}}, callback) do
    conn
    |> put_status(200)
    |> json(%{data: callback.(Jason.decode!(body))})
  end

  defp handle_response(conn, {:ok, %HTTPoison.Response{status_code: 404}}, _callback) do
    conn
    |> put_status(404)
    |> json(%{error: "Not Found"})
  end

  defp handle_response(conn, {:error, %HTTPoison.Error{reason: reason}}, _callback) do
    conn
    |> put_status(500)
    |> json(%{error: "Internal Server Error: #{reason}"})
  end
end
