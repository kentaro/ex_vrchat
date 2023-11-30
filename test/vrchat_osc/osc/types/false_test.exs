defmodule VRChatOSC.OSC.Types.FalseTest do
  use ExUnit.Case, async: true
  alias VRChatOSC.OSC.Types.False, as: F
  doctest F

  test "Types.False.type_tag/1 is F" do
    assert F.type_tag() == ?F
  end

  test "Types.False.encode/1 encodes Elixir's `false` value to binary representation of `F`" do
    assert F.encode(false) == <<70>>
  end

  test "Types.False.decode/1 reads an empty value" do
    assert F.decode("") == {false, ""}
  end
end
