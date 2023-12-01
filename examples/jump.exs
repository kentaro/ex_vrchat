defmodule MyConsumer do
  use GenStage

  def init(:ok) do
    {:consumer, nil}
  end

  def handle_events(events, {_, _}, state) do
    events
    |> Enum.each(fn event ->
      # IO.inspect(event)
      handle_event(event)
    end)

    {:noreply, [], state}
  end

  defp handle_event(%VRChatOSC.OSC.Message{path: "/avatar/parameters/Grounded", args: [true]}) do
    IO.puts("Grounded!")

    VRChatOSC.send_message(
      VRChatOSC.OSC,
      path: "/input/Jump",
      args: [1]
    )
  end

  defp handle_event(%VRChatOSC.OSC.Message{path: "/avatar/parameters/Grounded", args: [false]}) do
    IO.puts("Jumping!")
    VRChatOSC.send_message(VRChatOSC.OSC,
      path: "/input/Jump",
      args: [0]
    )
  end

  defp handle_event(_) do
    # noop
  end
end

{:ok, _osc} =
  VRChatOSC.OSC.start_link(
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

Process.sleep(:infinity)
