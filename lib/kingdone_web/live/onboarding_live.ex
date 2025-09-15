defmodule KingdoneWeb.OnboardingLive do
  use KingdoneWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Welcome to your Realm")}
  end

  import KingdoneWeb.OnboardingComponents

  def render(assigns) do
    ~H"""
    <div id="palace-chamber" class="min-h-screen relative bg-[#1a0f0f] bg-opacity-90 palace-bg">
      <.steward_dialog />
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
