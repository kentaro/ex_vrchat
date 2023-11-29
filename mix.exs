defmodule VRChatOSC.MixProject do
  use Mix.Project

  @github_url "https://github.com/kentaro/vrchat_osc"

  def project do
    [
      app: :vrchat_osc,
      version: "0.2.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      docs: docs(),
      deps: deps(),
      source_url: @github_url
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    """
    VRChatOSC is a library for sending and receiving messages to/from VRChat that supports the OpenSoundControl 1.0 protocol.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "CHANGELOG.md", "LICENSE"],
      maintainers: ["Kentaro Kuribayashi"],
      licenses: ["MIT"],
      links: %{GitHub: @github_url}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: [
        "README.md",
        "CHANGELOG.md"
      ],
      groups_for_modules: [
        "Client API": ~r/^VRChatOSC\./,
        "OSC Protocol": ~r/^OSC\./
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:gen_stage, "~> 1.2.1"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:ex_git_test, "~> 0.1.2", only: [:dev, :test], runtime: false}
    ]
  end
end
