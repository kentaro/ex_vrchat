defmodule VRChatOSC.OSC.Message do
  @moduledoc """
  A structure representing an OSC message.
  
  The same structure is used in both directions, serving as both requests and
  replies.  It consists of a request path (encoded as an `OSC.Types.String`), a
  type tag string (same), and an encoded list of arguments that can be decoded
  using the type tag string as a reference.
  
  For querying device parameters, a typical pattern is that the client will
  send a message with a given `path` and empty `args`, and the server will
  respond via a message with the same `path` and the requested data as the
  `args` list.
  """

  @enforce_keys [:path]
  defstruct(
    path: nil,
    args: []
  )

  alias VRChatOSC.OSC.Types
  alias __MODULE__

  @typedoc "The `VRChatOSC.OSC.Message` structure."
  @type t :: %__MODULE__{
          path: path(),
          args: args()
        }

  @typedoc "Path string for an `VRChatOSC.OSC.Message` structure"
  @type path :: binary

  @typedoc "Arguments list for an `VRChatOSC.OSC.Message` structure"
  @type args :: Types.args()

  @doc """
  Create a message with a given path and (optional) arguments.
  
  This is the preferred means of creating `VRChatOSC.OSC.Message` structures — in
  addition to some basic checks on `path` and `args`, this will also call
  `VRChatOSC.OSC.Types.validate_args/1` to ensure that all the arguments can be mapped to
  OSC types.
  """
  @spec construct(path(), args()) :: t()
  def construct(path, args \\ []) when is_binary(path) and is_list(args) do
    Types.validate_args(args)
    %Message{path: path, args: args}
  end

  @doc """
  Convert an `VRChatOSC.OSC.Message` structure to encoded network format.
  
  The arguments will be encoded using `VRChatOSC.OSC.Types.encode_args/1`, and then the
  message `path`, type tag string, and encoded arguments will be concatenated
  to form the packet.
  
  Returns the encoded packet as a binary, ready to send via UDP.
  """
  @spec to_packet(t()) :: binary
  def to_packet(%Message{} = msg) do
    {tag_string, encoded_args} = Types.encode_args(msg.args)

    [
      msg.path |> Types.String.encode(),
      tag_string |> Types.String.encode(),
      encoded_args
    ]
    |> :erlang.iolist_to_binary()
  end

  @doc """
  Parse a raw binary into an `VRChatOSC.OSC.Message` structure.
  
  The path and type tag string are decoded using `VRChatOSC.OSC.Types.String.decode/1`,
  and then the arguments are decoded via `VRChatOSC.OSC.Types.decode_args/2` using the
  type tag string as a reference.
  
  Returns the resulting `VRChatOSC.OSC.Message` structure.  Raises if there is any
  unconsumed data after the message ends.
  """
  @spec parse(binary) :: t()
  def parse(str) do
    {path, rest} = Types.String.decode(str)
    {tag_string, encoded_args} = Types.String.decode(rest)
    {args, ""} = Types.decode_args(tag_string, encoded_args)

    %Message{path: path, args: args}
  end
end
