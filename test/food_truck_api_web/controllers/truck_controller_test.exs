defmodule FoodTruckApiWeb.TruckControllerTest do
  use ExUnit.Case, async: true
  use FoodTruckApiWeb.ConnCase
  import Mock

  alias FoodTruckApiWeb.TruckController
  alias HTTPoison

  @approved_body """
  [
    {
      "objectid": 1,
      "applicant": "John Doe",
      "facilitytype": "Truck",
      "cnn": 123456,
      "locationdescription": "MARKET ST: DRUMM ST intersection",
      "address": "123 Market St",
      "blocklot": "234017",
      "block": 234,
      "lot": 17,
      "permit": "15MFF-0159",
      "status": "APPROVED",
      "fooditems": "Tacos: Burritos: Quesadillas: Tortas",
      "x": 123.456,
      "y": 456.789,
      "latitude": 123.456,
      "longitude": 456.789,
      "schedule": "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=19MFF-00112&ExportPDF=1&Filename=19MFF-00112_schedule.pdf",
      "dayshours": "Mo:6AM-8PM",
      "received": "20151231",
      "priorpermit": true,
      "location": "(37.794331003246846, -122.39581105302317)",
      "approved": "03/16/2017 12:00:00 AM",
      "expirationdate": "07/15/2018 12:00:00 AM",
      "zipcode": 94111
    }
  ]
  """

  @approved_truck_struct %{
    "address" => "123 Market St",
    "applicant" => "John Doe",
    "block" => 234,
    "block_lot" => "234017",
    "cnn" => 123_456,
    "days_hours" => "Mo:6AM-8PM",
    "expiration_date" => "07/15/2018 12:00:00 AM",
    "facility_type" => "Truck",
    "food_items" => "Tacos: Burritos: Quesadillas: Tortas",
    "latitude" => 123.456,
    "location_description" => "MARKET ST: DRUMM ST intersection",
    "location" => "(37.794331003246846, -122.39581105302317)",
    "longitude" => 456.789,
    "lot" => 17,
    "objectid" => 1,
    "permit" => "15MFF-0159",
    "prior_permit" => true,
    "received" => "20151231",
    "schedule" =>
      "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=19MFF-00112&ExportPDF=1&Filename=19MFF-00112_schedule.pdf",
    "status" => "APPROVED",
    "x" => 123.456,
    "y" => 456.789,
    "approved" => "03/16/2017 12:00:00 AM",
    "zip_code" => 94111
  }

  describe("#index/2") do
    test "Returns a list of food trucks on successful response", %{conn: conn} do
      with_mock HTTPoison,
        get: fn _conn ->
          {:ok,
           %HTTPoison.Response{
             status_code: 200,
             body: @approved_body
           }}
        end do
        conn = TruckController.index(conn, %{})

        assert json_response(conn, 200) == %{
                 "data" => [@approved_truck_struct]
               }
      end
    end

    test "Returns an error message when the response status is 404", %{conn: conn} do
      with_mock HTTPoison,
        get: fn _conn -> {:ok, %HTTPoison.Response{status_code: 404}} end do
        conn = TruckController.index(conn, %{})

        assert json_response(conn, 404) == %{"error" => "Not Found"}
      end
    end

    test "Returns an error message when the response status is 500", %{conn: conn} do
      with_mock HTTPoison,
        get: fn _conn -> {:error, %HTTPoison.Error{reason: "Test Failure"}} end do
        conn = TruckController.index(conn, %{})

        assert json_response(conn, 500) == %{"error" => "Internal Server Error: Test Failure"}
      end
    end
  end

  describe "#list_approved_trucks/2" do
    test "Returns a list of approved food trucks on successful response", %{conn: conn} do
      with_mock HTTPoison,
        get: fn _conn ->
          {:ok,
           %HTTPoison.Response{
             status_code: 200,
             body: @approved_body
           }}
        end do
        conn = TruckController.list_approved_trucks(conn, %{})

        assert json_response(conn, 200) == %{
                 "data" => [@approved_truck_struct]
               }
      end
    end

    test "Returns an error message when the response status is 404", %{conn: conn} do
      with_mock HTTPoison,
        get: fn _conn -> {:ok, %HTTPoison.Response{status_code: 404}} end do
        conn = TruckController.list_approved_trucks(conn, %{})

        assert json_response(conn, 404) == %{"error" => "Not Found"}
      end
    end

    test "Returns an error message when the response status is 500", %{conn: conn} do
      with_mock HTTPoison,
        get: fn _conn -> {:error, %HTTPoison.Error{reason: "Test Failure"}} end do
        conn = TruckController.list_approved_trucks(conn, %{})

        assert json_response(conn, 500) == %{"error" => "Internal Server Error: Test Failure"}
      end
    end
  end

  describe "#list_taco_trucks" do
    test "Returns a list of taco trucks on successful response", %{conn: conn} do
      with_mock HTTPoison,
        get: fn _conn ->
          {:ok,
           %HTTPoison.Response{
             status_code: 200,
             body: @approved_body
           }}
        end do
        conn = TruckController.list_taco_trucks(conn, %{})

        assert json_response(conn, 200) == %{
                 "data" => [@approved_truck_struct]
               }
      end
    end

    test "Returns an error message when the response status is 404", %{conn: conn} do
      with_mock HTTPoison,
        get: fn _conn -> {:ok, %HTTPoison.Response{status_code: 404}} end do
        conn = TruckController.list_taco_trucks(conn, %{})

        assert json_response(conn, 404) == %{"error" => "Not Found"}
      end
    end

    test "Returns an error message when the response status is 500", %{conn: conn} do
      with_mock HTTPoison,
        get: fn _conn -> {:error, %HTTPoison.Error{reason: "Test Failure"}} end do
        conn = TruckController.list_taco_trucks(conn, %{})

        assert json_response(conn, 500) == %{"error" => "Internal Server Error: Test Failure"}
      end
    end
  end
end
