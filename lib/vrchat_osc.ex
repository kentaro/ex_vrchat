defmodule VRChatOSC do
  @moduledoc """
  VRChatOSC is a library for sending and receiving messages to/from VRChat that supports the [OpenSoundControl 1.0](https://opensoundcontrol.stanford.edu/spec-1_0.html) protocol.
  """

  @typedoc "Args used by send_message/2"
  @type args ::  [
    path: String.t(),
    args: [term()]
  ]

  @doc """
  Sends a message to the target VRChat instance.
  """
  @spec send_message(pid(), args()) :: :ok
  def send_message(pid, message) do
    GenServer.cast(pid, {:send_message, message})
  end
end
