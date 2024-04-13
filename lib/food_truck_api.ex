defmodule FoodTruckApi do
  @moduledoc """
  Food Truck API is an API that connects with the City of San Francisco's public Mobile Food Facility Permits dataset.
  It handles a number of different queries to get you the latest info on the hottest new food trucks.

  ## Available routes:

  ```
  #{for %{verb: verb, path: path} <- Phoenix.Router.routes(FoodTruckApiWeb.Router) do
    [String.upcase(to_string(verb)), " ", path, "\n"]
  end}
  ```
  """
end
