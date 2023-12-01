defmodule MyConsumer do
  use GenStage

  def init(:ok) do
    {:consumer, nil}
  end

  def handle_events(events, {_, _}, state) do
    events |> Enum.each(fn event ->
      if !(event.path |> String.starts_with?("/avatar/parameters/scarf_Angle")) do
        IO.inspect(event)
      end
    end)
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

VRChatOSC.send_message(
  osc,
  path: "/chatbox/input",
  args: ["Hello, world!", true]
)
Process.sleep(:infinity)
