import Config

config :ex_doc, :elixir_version, 1.14
config :ex_doc, :output_dir, "priv/static/docs"

config :food_truck_api, FoodTruckApiWeb.Endpoint,
  docs: [
    source_paths: ["lib", "test"],
    exclude: ~r/_build|deps/
  ]

config :food_truck_api, FoodTruckApiWeb.Endpoint,
  url: [scheme: "https", host: System.get_env("APP_NAME") <> ".herokuapp.com", port: 80],
  http: [port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :food_truck_api, FoodTruckApiWeb.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :food_truck_api, FoodTruckApiWeb.Endpoint, load_from_system_env: true

config :food_truck_api, FoodTruckApiWeb.Endpoint, server: true

config :food_truck_api, FoodTruckApiWeb.Endpoint,
  root: ".",
  version: Mix.Project.config()[:version],
  name: "FoodTruckApi"

config :food_truck_api, FoodTruckApiWeb.Endpoint, compilers: [:gettext] ++ Mix.compilers()
