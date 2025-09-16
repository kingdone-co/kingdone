defmodule KingdoneWeb.OnboardingLive do
  use KingdoneWeb, :live_view

  import KingdoneWeb.AgentComponents

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Welcome to your Realm")}
  end

  def handle_params(params, _url, socket) do
    {:noreply, assign(socket, step: params["step"] || "intro")}
  end

  def render(assigns) do
    ~H"""
    <div id="palace-chamber" class="min-h-screen relative bg-[#1a0f0f] bg-opacity-90 palace-bg">
      <.agent_dialog
        character="elric"
        paragraphs={paragraphs(@step)}
      >
        <:button phx-click="continue">
          Continue
        </:button>
      </.agent_dialog>
    </div>
    """
  end

  defp paragraphs("intro") do
    [
      "Welcome to your palace, my liege. Though once proud, it now lies in disrepair. The walls are crumbling, the banners torn, and silence fills these halls.",
      "Yet take heart. With every quest you fulfill, this palace and the realm beyond shall rise again. Your progress will breathe glory back into these stones."
    ]
  end

  defp paragraphs("set_name") do
    [
      "Before I may serve, tell me — by what name shall I address my sovereign?"
    ]
  end

  def handle_event("continue", _params, socket) do
    {:noreply, push_patch(socket, to: ~p"/onboarding?#{[step: next_step(socket.assigns.step)]}")}
  end

  defp next_step("intro"), do: "set_name"
end
