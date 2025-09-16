defmodule KingdoneWeb.PalaceLive do
  use KingdoneWeb, :live_view

  import KingdoneWeb.AgentComponents

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Tasks Palace")}
  end

  def handle_params(params, _url, socket) do
    reclaiming? = params["reclaiming"] == "true"
    {:noreply, assign(socket, reclaiming?: reclaiming?)}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen relative palace-bg">
      <.agent_dialog character="elric">
        <:paragraph>
          Your first grand quest is clear: <strong>Reclaim the Castle!</strong>
          Every hall, every tower, every sanctuary awaits your hand.
        </:paragraph>
        <:paragraph>
          Each task you complete is a brick laid, a banner raised, a light restored.
          One by one, the ruins shall become your stronghold.
        </:paragraph>
        <:button phx-click="go_to_tasks">
          Continue
        </:button>
      </.agent_dialog>
    </div>
    """
  end
end
