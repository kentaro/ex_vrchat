# VRChatOSC

[![Hex.pm Version](https://img.shields.io/hexpm/v/vrchat_osc.svg?style=flat-square)](https://hex.pm/packages/vrchat_osc)

VRChatOSC is a library for sending and receiving messages to/from VRChat that supports the [OpenSoundControl 1.0](https://opensoundcontrol.stanford.edu/spec-1_0.html) protocol.

This library was forked from [ex_osc](https://github.com/wisq/ex_osc) and made some modifications to support VRChat OSC protocol.

## Installation

VRChatOSC requires Elixir v1.14.  To use it, add `:vrchat_osc` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:vrchat_osc, "~> 0.2.0"}
  ]
end
```

## Usage

Here's an example of using `VRChatOSC.OSC` to send a message and receives messages to/from VRChat.

```elixir
defmodule MyConsumer do
  use GenStage

  def init(:ok) do
    {:consumer, nil}
  end

  def handle_events(events, {_, _}, state) do
    events |> Enum.each(&IO.inspect/1)
    {:noreply, [], state}
  end
end

{:ok, osc} = VRChatOSC.OSC.start_link(
  vrchat: [
    ip: {127, 0, 0, 1},
    port: 9000
  ],
  client: [
    port: 9001
  ],
  consumer: [
    module: MyConsumer,
    args: :ok,
    opts: []
  ]
)

VRChatOSC.OSC.send_message(
  osc,
  path: "/chatbox/input",
  args: ["Hello, world!"]
)
Process.sleep(1000)
```

Output:

You can see the message sent to VRChat and the messages received from VRChat.

![The message sent to VRChat](examples/basic-result.png)

```elixir
%VRChatOSC.OSC.Message{
  path: "/avatar/parameters/scarf_Angle",
  args: [5.154856480658054e-4]
}
%VRChatOSC.OSC.Message{
  path: "/avatar/parameters/scarf_Angle",
  args: [3.2970565371215343e-4]
}
%VRChatOSC.OSC.Message{
  path: "/avatar/parameters/scarf_Angle",
  args: [6.501884781755507e-4]
}
...
```

## Documentation

Full documentation can be found at <https://hexdocs.pm/vrchat_osc>.

## Legal stuff

Copyright © 2023 Kentaro Kuribayashi

Copyright © 2023 Adrian Irving-Beer (the original author of ex_osc)

VRChatOSC is released under the [MIT license](https://github.com/kentaro/vrchat_osc/blob/main/LICENSE) and is provided with **no warranty**.
