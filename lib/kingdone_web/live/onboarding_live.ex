defmodule KingdoneWeb.OnboardingLive do
  use KingdoneWeb, :live_view

  import KingdoneWeb.AgentComponents

  alias Kingdone.Gamer

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(page_title: "Welcome to your Realm")
     |> assign(name: "")
     |> assign(profile: nil)
     |> assign(errors: [])}
  end

  def handle_params(params, _url, socket) do
    step = params["step"] || "welcome"

    {:noreply,
     socket
     |> assign(step: step)
     |> assign(profile: Gamer.get_profile())}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen relative palace-bg">
      <.agent_dialog
        character="elric"
        paragraphs={paragraphs(@step, @profile)}
      >
        <:input
          :if={@step == "set_name"}
          name="name"
          value={@name}
          placeholder="Enter your name"
          phx-change="update_name"
          errors={@errors}
        />
        <:button
          :if={@step == "set_title"}
          phx-click="save_title"
          phx-value-clicked="lady"
          modifier="secondary"
        >
          Lady
        </:button>
        <:button
          :if={@step == "set_title"}
          phx-click="save_title"
          phx-value-clicked="lord"
          modifier="secondary"
        >
          Lord
        </:button>
        <:button
          :if={@step == "set_title"}
          phx-click="save_title"
          phx-value-clicked="liege"
          modifier="secondary"
        >
          Liege
        </:button>
        <:button :if={@step != "set_title"} phx-click={button_click(@step)}>
          Continue
        </:button>
      </.agent_dialog>
    </div>
    """
  end

  defp paragraphs("welcome", _profile) do
    [
      "Welcome to your palace, my liege. Though once proud, it now lies in disrepair. The walls are crumbling, the banners torn, and silence fills these halls.",
      "Yet take heart. With every quest you fulfill, this palace and the realm beyond shall rise again. Your progress will breathe glory back into these stones."
    ]
  end

  defp paragraphs("set_name", _profile) do
    [
      "Before I may serve, tell me — by what name shall I address my sovereign?"
    ]
  end

  defp paragraphs("set_title", profile) do
    [
      raw(
        "Ah, splendid. <strong>#{profile.name}</strong> shall be carved into the banners of the kingdom. Tell me, sovereign, how shall we address you?"
      )
    ]
  end

  defp paragraphs("intro", profile) do
    [
      raw(
        "Very well, <strong>#{profile.title |> to_string() |> String.capitalize()} #{profile.name}</strong>. From this day forward, your word shall shape the fate of this realm."
      ),
      "I am Elric the Steward — your loyal Taskmaster. My charge is to oversee your daily quests, and ensure your crown is never unworn."
    ]
  end

  defp button_click("set_name"), do: "save_name"
  defp button_click(_), do: "continue"

  def handle_event("continue", _params, socket) do
    {:noreply, push_navigate(socket, to: next_step(socket.assigns.step))}
  end

  def handle_event("update_name", %{"name" => name}, socket) do
    {:noreply, assign(socket, name: name)}
  end

  def handle_event("save_name", _params, socket) do
    case Gamer.set_name(socket.assigns.name) do
      {:ok, profile} ->
        {:noreply,
         socket
         |> assign(:profile, profile)
         |> push_navigate(to: next_step(socket.assigns.step))}

      {:error, changeset} ->
        {:noreply, assign(socket, :errors, translate_errors(changeset.errors, :name))}
    end
  end

  def handle_event("save_title", %{"clicked" => title}, socket) do
    profile = Gamer.set_title!(socket.assigns.profile, String.to_existing_atom(title))

    {:noreply,
     socket
     |> assign(:profile, profile)
     |> push_navigate(to: next_step(socket.assigns.step))}
  end

  defp next_step("welcome"), do: ~p"/onboarding?step=set_name"
  defp next_step("set_name"), do: ~p"/onboarding?step=set_title"
  defp next_step("set_title"), do: ~p"/onboarding?step=intro"
  defp next_step("intro"), do: ~p"/palace?reclaiming=true"
end
