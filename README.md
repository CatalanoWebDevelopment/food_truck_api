# FoodTruckApi

Food Truck API is an API that connects with the City of San Francisco's public Mobile Food Facility Permits dataset.
It handles a number of different queries to get you the latest info on the hottest new food trucks.

## Getting Started

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Documentation

After adding additional documentation to an endpoint or module for ExDoc, run:

1. `mix docs`

To view documentation, run:

1. `mix start`
2. Navigate to <http://localhost:4000/docs/FoodTruckApi.html> or click the "Docs" link on the home page.

## Live API & Docs

<https://food-truck-api-63f05bcc353b.herokuapp.com/>

## Example

The following is a call to get all of the trucks with an approved permit that serve hot dogs as one of their food items:

<https://food-truck-api-63f05bcc353b.herokuapp.com/api/trucks/food/hot%20dogs>
