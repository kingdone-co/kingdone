defmodule KingdoneWeb.AgentComponents do
  use Phoenix.Component
  use KingdoneWeb, :html

  @characters %{
    "elric" => "Elric the Steward"
  }

  attr :character, :string, required: true
  attr :paragraphs, :list, default: []

  slot :paragraph

  slot :input do
    attr :name, :string
    attr :value, :string
    attr :placeholder, :string
    attr :"phx-change", :string
    attr :errors, :list
  end

  slot :button do
    attr :"phx-click", :string
    attr :"phx-value-clicked", :string
    attr :modifier, :string, values: ["primary", "secondary"]
  end

  def agent_dialog(assigns) do
    assigns = Map.put(assigns, :character_name, @characters[assigns.character])

    ~H"""
    <div class="fixed bottom-8 left-1/2 -translate-x-1/2 w-[800px] max-w-[95vw] bg-[#f5e6d3] bg-opacity-95 rounded-xl border-4 border-[#8B7355] shadow-[0_0_15px_rgba(0,0,0,0.3),inset_0_0_10px_rgba(139,115,85,0.2)] p-6 backdrop-blur-sm">
      <div class="flex items-start gap-6">
        <div class="flex-none w-[120px]">
          <div class="space-y-2">
            <div class="w-[120px] h-[120px] bg-[#2c1810] rounded-lg p-1 border-2 border-[#8B7355] shadow-lg">
              <img
                src={~p"/images/characters/#{@character}/portrait.png"}
                alt={@character_name}
                class="w-full h-full object-cover rounded"
              />
            </div>
            <div class="text-center text-sm font-bold">
              {@character_name}
            </div>
          </div>
        </div>

        <div class="flex-1 space-y-6">
          <div class="chat-message bg-[#f9f3e8] border-[3px] border-[#8B7355] rounded-lg p-4 shadow-md relative">
            <div class="absolute left-[-3px] top-[14px] -translate-x-full w-0 h-0 border-t-[12px] border-t-transparent border-r-[20px] border-r-[#8B7355] border-b-[12px] border-b-transparent">
            </div>
            <div class="absolute left-0 top-[14px] -translate-x-full w-0 h-0 border-t-[12px] border-t-transparent border-r-[20px] border-r-[#f9f3e8] border-b-[12px] border-b-transparent">
            </div>
            <p :for={paragraph <- @paragraphs} class="text-[#2c1810] text-lg mb-4 last:mb-0">
              {paragraph}
            </p>

            <p :for={paragraph <- @paragraph} class="text-[#2c1810] text-lg mb-4 last:mb-0">
              {render_slot(paragraph)}
            </p>
          </div>

          <.form for={%{}}>
            <div :for={input <- @input}>
              <input
                type="text"
                name={input[:name] || "value"}
                value={input[:value]}
                placeholder={input[:placeholder] || "Enter your message..."}
                class="w-full bg-[#f9f3e8] border-[3px] border-[#8B7355] rounded-lg text-[#2c1810] text-lg p-4 focus:border-[#c4a484] focus:ring-1 focus:ring-[#c4a484] placeholder:text-[#8B7355]/70 shadow-md"
                autocomplete="off"
                phx-change={input[:"phx-change"]}
              />
              <.error :for={msg <- input.errors}>{msg}</.error>
            </div>
          </.form>

          <div class="flex flex-wrap gap-3">
            <div :for={{button, index} <- Enum.with_index(@button)} class="flex-1">
              <button
                phx-click={button[:"phx-click"]}
                phx-value-clicked={button[:"phx-value-clicked"]}
                class={[
                  "medieval-button w-full bg-gradient-to-r text-lg py-3 px-6",
                  "rounded border-2 shadow-md transition-all duration-300",
                  button_modifier_class(
                    button[:modifier] || ((index == 0 && "primary") || "secondary")
                  )
                ]}
              >
                {render_slot(button)}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  defp button_modifier_class("primary") do
    [
      "from-[#8B7355] to-[#c4a484] text-[#f9f3e8]",
      "border-[#8B7355] hover:from-[#c4a484] hover:to-[#8B7355]"
    ]
  end

  defp button_modifier_class("secondary") do
    [
      "from-[#4a4a4a] to-[#686868] text-[#f9f3e8]",
      "border-[#4a4a4a] hover:from-[#686868] hover:to-[#4a4a4a]"
    ]
  end
end
