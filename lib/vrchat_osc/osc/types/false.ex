defmodule VRChatOSC.OSC.Types.False do
  @moduledoc """
  Encoding and decoding of the OSC false type.
  """

  @typedoc "An OSC false, represented by an Elixir's `false` value"
  @type t :: false

  @doc """
  Returns `?F`, the type tag for the OSC false type
  
      iex> <<VRChatOSC.OSC.Types.False.type_tag()>>
      "F"
  """
  def type_tag, do: ?F

  @doc """
  Encodes an Elixir integer to an OSC false type.
  
  Returns a 32-bit big-endian-encoded null value.
  
  ## Examples
  
      iex> VRChatOSC.OSC.Types.False.encode(false)
      <<70>>
  """
  def encode(false_val) when is_boolean(false_val) and false_val == false do
    <<70>>
  end

  @doc """
  Decodes an OSC false to an Elixir false value.
  
  ## Examples
  
      iex> "" |> VRChatOSC.OSC.Types.False.decode()
      {false, ""}
  """
  def decode("") do
    {false, ""}
  end
end
