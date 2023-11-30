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
  args: ["Hello, world!", true]
)
Process.sleep(:infinity)
