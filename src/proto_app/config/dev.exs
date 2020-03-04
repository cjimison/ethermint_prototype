use Mix.Config

config :gateway,
  node_port: 8180,
  portal_port: 8181,
  marketplace_port: 8182,
  html_base: "http",
  dns_name: "localhost"

config :ethereumex,
  url: "http://localhost:8545"
