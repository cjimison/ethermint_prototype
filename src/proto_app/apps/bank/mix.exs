defmodule Bank.MixProject do
  use Mix.Project

  def project do
    [
      app: :bank,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Bank.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      # {:sibling_app_in_umbrella, in_umbrella: true}
      {:ethereumex, "~> 0.6.0", override: true},
      {:poison, "~> 4.0", override: true},
      {:exw3, "~> 0.4.4"},
      {:eth, "~> 0.4.0"},
      {:eth_contract, "~> 0.2.9"}
    ]
  end
end
