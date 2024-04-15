defmodule Schema.Truck do
  @moduledoc """
  This module is responsible for defining the Truck struct and its functions.

  ### Fields

  - `objectid` - The unique identifier for the food truck.
  - `applicant` - The name of the person or company that owns the food truck.
  - `facility_type` - The type of facility the food truck is.
  - `cnn` - The unique identifier for the food truck.
  - `location_description` - A description of the location of the food truck.
  - `address` - The address of the food truck.
  - `block_lot` - The block and lot number of the food truck.
  - `block` - The block number of the food truck.
  - `lot` - The lot number of the food truck.
  - `permit` - The permit number of the food truck.
  - `status` - The status of the food truck.
  - `food_items` - The food items the food truck serves.
  - `x` - The x coordinate of the food truck.
  - `y` - The y coordinate of the food truck.
  - `latitude` - The latitude of the food truck.
  - `longitude` - The longitude of the food truck.
  - `schedule` - The schedule of the food truck.
  - `days_hours` - The days and hours the food truck is open.
  - `received` - The date the food truck received its permit.
  - `prior_permit` - Whether the food truck had a prior permit.
  - `location` - The location of the food truck.
  - `approved` - The date the food truck was approved.
  - `expiration_date` - The expiration date of the food truck's permit.
  - `zip_code` - The zip code of the food truck.

  ### Example

      %FoodTruckApi.Models.Truck{
        objectid: 1,
        applicant: "John Doe",
        facility_type: "Push Cart",
        cnn: 123456,
        location_description: "MARKET ST: DRUMM ST intersection",
        address: "123 Market St",
        block_lot: 234017,
        block: 234,
        lot: 17,
        permit: "15MFF-0159",
        status: "REQUESTED",
        food_items: "Fried Chicken: Fried Fish: Greens: Mac & Cheese: Peach Cobbler: and String beans",
        x: 123.456,
        y: 456.789,
        latitude: 123.456,
        longitude: 456.789,
        schedule: "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=19MFF-00112&ExportPDF=1&Filename=19MFF-00112_schedule.pdf",
        days_hours: "Mo:6AM-8PM",
        received: 20151231,
        prior_permit: true,
        location: "(37.794331003246846, -122.39581105302317)",
        approved: "03/16/2017 12:00:00 AM",
        expiration_date: "07/15/2018 12:00:00 AM",
        zip_code: 94111
      }
  """

  @derive Jason.Encoder
  defstruct [
    :objectid,
    :applicant,
    :facility_type,
    :cnn,
    :location_description,
    :address,
    :block_lot,
    :block,
    :lot,
    :permit,
    :status,
    :food_items,
    :x,
    :y,
    :latitude,
    :longitude,
    :schedule,
    :days_hours,
    :received,
    :prior_permit,
    :location,
    :approved,
    :expiration_date,
    :zip_code
  ]

  @type t :: %__MODULE__{
          objectid: integer(),
          applicant: String.t(),
          facility_type: String.t(),
          cnn: integer(),
          location_description: String.t(),
          address: String.t(),
          block_lot: String.t(),
          block: integer(),
          lot: integer(),
          permit: String.t(),
          status: String.t(),
          food_items: String.t(),
          x: float(),
          y: float(),
          latitude: float(),
          longitude: float(),
          schedule: String.t(),
          days_hours: String.t(),
          received: String.t(),
          prior_permit: boolean(),
          location: %{
            human_address: String.t(),
            latitude: String.t(),
            longitude: String.t()
          },
          approved: String.t(),
          expiration_date: String.t(),
          zip_code: integer()
        }

  @doc """
  Converts a JSON object to a Truck struct.
  """
  @spec build_data_from_query(String.t()) :: [t()]
  def build_data_from_query(data) do
    data
    |> Enum.map(&from_json/1)
  end

  @doc """
  Returns a list of taco trucks.
  """
  @spec list_taco_trucks(String.t()) :: [t()]
  def list_taco_trucks(data) do
    data
    |> Enum.map(&from_json/1)
    |> Enum.filter(&(&1.food_items =~ "Taco"))
  end

  @doc """
  Returns a list of the desired food items.
  """
  @spec list_food_items(String.t(), String.t()) :: [t()]
  def list_food_items(data, food_item) do
    data
    |> Enum.map(&from_json/1)
    |> Enum.filter(&(&1.food_items =~ food_item))
  end

  defp from_json(json) do
    %Schema.Truck{
      objectid: json["objectid"],
      applicant: json["applicant"],
      facility_type: json["facilitytype"],
      cnn: json["cnn"],
      location_description: json["locationdescription"],
      address: json["address"],
      block_lot: json["blocklot"],
      block: json["block"],
      lot: json["lot"],
      permit: json["permit"],
      status: json["status"],
      food_items: json["fooditems"],
      x: json["x"],
      y: json["y"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      schedule: json["schedule"],
      days_hours: json["dayshours"],
      received: json["received"],
      prior_permit: !!json["priorpermit"],
      location: json["location"],
      approved: json["approved"],
      expiration_date: json["expirationdate"],
      zip_code: json["zipcode"]
    }
  end
end
