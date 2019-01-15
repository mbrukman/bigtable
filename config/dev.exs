# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module
use Mix.Config

config :mix_test_watch,
  tasks: [
    "test",
    "coveralls.html"
  ],
  clear: true

config :bigtable,
  project: "datahub-222411",
  instance: "datahub",
  table: "ride",
  url: "localhost",
  port: 8086
