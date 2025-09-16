defmodule KingdoneWeb.OnboardingLive do
  use KingdoneWeb, :live_view

  import KingdoneWeb.AgentComponents

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Welcome to your Realm")}
  end

  def render(assigns) do
    ~H"""
    <div id="palace-chamber" class="min-h-screen relative bg-[#1a0f0f] bg-opacity-90 palace-bg">
      <.agent_dialog
        character="elric"
        paragraphs={[
          "Greetings, my liege. I am Elric the Steward, sworn to guide your daily quests.",
          "Shall I show you how to marshal your tasks and projects?"
        ]}
      />
    </div>
    """
  end

  def handle_event("start_onboarding", _params, socket) do
    {:noreply, push_navigate(socket, to: "/onboarding/tasks")}
  end

  def handle_event("skip_onboarding", _params, socket) do
    {:noreply, push_navigate(socket, to: "/dashboard")}
  end
end
