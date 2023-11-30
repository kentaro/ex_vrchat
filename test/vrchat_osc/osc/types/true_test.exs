defmodule VRChatOSC.OSC.Types.TrueTest do
  use ExUnit.Case, async: true
  alias VRChatOSC.OSC.Types.True, as: T
  doctest T

  test "Types.True.type_tag/1 is T" do
    assert T.type_tag() == ?T
  end

  test "Types.True.encode/1 encodes Elixir's `true` value to binary representation of `T`" do
    assert T.encode(true) == <<84>>
  end

  test "Types.True.decode/1 reads an empty value" do
    assert T.decode("") == {true, ""}
  end
end
