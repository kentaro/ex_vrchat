defmodule VRChatOSC.OSC do
  use GenServer

  alias VRChatOSC.OSC.{Client, Message}

  @impl true
  def init(args) do
    vrchat_args =
      args
      |> Keyword.get(:vrchat,
        ip: {127, 0, 0, 1},
        port: 9000
      )

    client_args =
      args
      |> Keyword.get(:client,
        port: 9001
      )

    consumer_args = args |> Keyword.get(:consumer)

    {:ok, client} =
      Client.start_link(
        ip: vrchat_args[:ip],
        port: vrchat_args[:port],
        listen: client_args[:port]
      )

    {:ok, consumer} =
      GenStage.start_link(
        consumer_args[:module],
        consumer_args[:args],
        consumer_args[:opts] || []
      )

    {:ok, _} = GenStage.sync_subscribe(consumer, to: client)

    {:ok,
     %{
       client: client,
       consumer: consumer
     }}
  end

  def start_link(args) do
    name = Keyword.get(args, :name, __MODULE__)
    GenServer.start_link(__MODULE__, args, name: name)
  end

  def send_message(osc, message) do
    GenServer.cast(osc, {:send_message, message})
  end

  @impl true
  def handle_cast({:send_message, message}, state) do
    Client.send_message(
      state.client,
      %Message{
        path: message[:path],
        args: message[:args]
      }
    )

    {:noreply, state}
  end
end
