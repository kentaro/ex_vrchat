defmodule VRChatOSC.OSC.Types.True do
  @moduledoc """
  Encoding and decoding of the OSC true type.
  """

  @typedoc "An OSC true, represented by an Elixir's `true` value"
  @type t :: true

  @doc """
  Returns `?F`, the type tag for the OSC true type
  
      iex> <<VRChatOSC.OSC.Types.True.type_tag()>>
      "T"
  """
  def type_tag, do: ?T

  @doc """
  Encodes an Elixir integer to an OSC true type.
  
  Returns a 32-bit big-endian-encoded null value.
  
  ## Examples
  
      iex> VRChatOSC.OSC.Types.True.encode(true)
      <<84>>
  """
  def encode(true_val) when is_boolean(true_val) and true_val == true do
    <<84>>
  end

  @doc """
  Decodes an OSC true to an Elixir true value.
  
  ## Examples
  
      iex> "" |> VRChatOSC.OSC.Types.True.decode()
      {true, ""}
  """
  def decode("") do
    {true, ""}
  end
end
