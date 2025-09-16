defmodule KingdoneWeb.OnboardingComponents do
  use Phoenix.Component

  attr :paragraphs, :list, required: true

  def steward_dialog(assigns) do
    ~H"""
    <div class="fixed bottom-8 left-1/2 -translate-x-1/2 w-[800px] max-w-[95vw] bg-[#f5e6d3] bg-opacity-95 rounded-xl border-4 border-[#8B7355] shadow-[0_0_15px_rgba(0,0,0,0.3),inset_0_0_10px_rgba(139,115,85,0.2)] p-6 backdrop-blur-sm">
      <div class="flex items-start gap-6">
        <div class="flex-none w-[120px]">
          <div class="relative">
            <div class="w-[120px] h-[120px] bg-[#2c1810] rounded-lg p-1 border-2 border-[#8B7355] shadow-lg">
              <img
                src="/images/elric-portrait.png"
                alt="Elric the Steward"
                class="w-full h-full object-cover rounded"
              />
            </div>

          </div>
        </div>

        <div class="flex-1 space-y-6">
          <div class="chat-message bg-[#f9f3e8] border-[3px] border-[#8B7355] rounded-lg p-4 shadow-md relative">
            <div class="absolute left-[-3px] top-[14px] -translate-x-full w-0 h-0 border-t-[12px] border-t-transparent border-r-[20px] border-r-[#8B7355] border-b-[12px] border-b-transparent">
            </div>
            <div class="absolute left-0 top-[14px] -translate-x-full w-0 h-0 border-t-[12px] border-t-transparent border-r-[20px] border-r-[#f9f3e8] border-b-[12px] border-b-transparent">
            </div>
            <p :for={{paragraph, index} <- Enum.with_index(@paragraphs)} class={["font-[MedievalSharp] text-[#2c1810] text-lg", index != length(@paragraphs) - 1 && "mb-4"]}>
              {paragraph}
            </p>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
            <div class="flex-1">
              <button
                phx-click="start_onboarding"
                class="medieval-button w-full bg-gradient-to-r from-[#8B7355] to-[#c4a484] text-[#f9f3e8] font-[MedievalSharp] text-lg py-3 px-6 rounded border-2 border-[#8B7355] shadow-md hover:from-[#c4a484] hover:to-[#8B7355] transition-all duration-300"
              >
                Yes, Steward. Lead the way.
              </button>
            </div>
            <div class="flex-1">
              <button
                phx-click="skip_onboarding"
                class="medieval-button w-full bg-gradient-to-r from-[#4a4a4a] to-[#686868] text-[#f9f3e8] font-[MedievalSharp] text-lg py-3 px-6 rounded border-2 border-[#4a4a4a] shadow-md hover:from-[#686868] hover:to-[#4a4a4a] transition-all duration-300"
              >
                Later, I must gather my strength.
              </button>
            </div>
          </div>
        </div>
      </div>

    </div>
    """
  end
end