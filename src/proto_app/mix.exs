defmodule ProtoApp.MixProject do
  use Mix.Project

  # ----------------------------------------------------------------------------
  # Project spec
  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_options: elixirc_options(Mix.env()),
      erlc_options: erlc_options(Mix.env()),
      dialyzer: [
        flags: ["-Wunmatched_returns", :error_handling, :race_conditions, :underspecs]
      ],
      releases: [
        marketplace: marketplaceReleaseSpec(),
        bot: botReleaseSpec()
      ]
    ]
  end

  # ----------------------------------------------------------------------------
  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:dialyxir, "~> 1.0.0-rc.6", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end

  # ----------------------------------------------------------------------------
  # Release spec for the Marketplace build
  # ----------------------------------------------------------------------------
  defp marketplaceReleaseSpec() do
    [
      include_executables_for: [:unix],
      strip_beams: true,
      include_erts: true,
      applications: [
        runtime_tools: :permanent,
        utils: :permanent,
        storage: :permanent,
        marketplace: :permanent,
        bank: :permanent,
        gateway: :permanent
      ]
    ]
  end

  # ----------------------------------------------------------------------------
  # Release spec for the Bot build
  # ----------------------------------------------------------------------------
  defp botReleaseSpec() do
    [
      include_executables_for: [:unix],
      applications: [runtime_tools: :permanent]
    ]
  end

  defp elixirc_options(:debug) do
    [debug_info: true, all_warnings: true, warnings_as_errors: true]
  end

  defp elixirc_options(_) do
    [debug_info: false, all_warnings: true, warnings_as_errors: true]
  end

  defp erlc_options(:debug) do
    [:warnings_as_errors, :debug_info]
  end

  defp erlc_options(_) do
    [:warnings_as_errors]
  end
end
