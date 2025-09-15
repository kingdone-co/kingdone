defmodule KingdoneWeb.OnboardingLive do
  use KingdoneWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Welcome to your Realm")}
  end

  def render(assigns) do
    ~H"""
    <div id="palace-chamber" class="min-h-screen relative bg-[#1a0f0f] bg-opacity-90 palace-bg">
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
              <div class="absolute -top-2 -right-2">
                <div class="w-8 h-8 bg-[#c4a484] rounded-full border-2 border-[#8B7355] flex items-center justify-center shadow-md">
                  <svg
                    class="w-4 h-4 text-[#2c1810]"
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 20 20"
                    fill="currentColor"
                  >
                    <path d="M9.504 1.132a1 1 0 01.992 0l1.75 1a1 1 0 11-.992 1.736L10 3.152l-1.254.716a1 1 0 11-.992-1.736l1.75-1zM5.618 2.04a1 1 0 01-.372 1.364L5.016 3.5 3.764 4.214a1 1 0 11-.992-1.736L4 1.872l1.618.168zM14.382 2.04a1 1 0 01-.372 1.364l-.23.096-1.252.714a1 1 0 11-.992-1.736L13 1.872l1.382.168z" />
                  </svg>
                </div>
              </div>
            </div>
          </div>

          <div class="flex-1 space-y-6">
            <div class="chat-message bg-[#f9f3e8] border-[3px] border-[#8B7355] rounded-lg p-4 shadow-md relative">
              <div class="absolute left-[-3px] top-[14px] -translate-x-full w-0 h-0 border-t-[12px] border-t-transparent border-r-[20px] border-r-[#8B7355] border-b-[12px] border-b-transparent">
              </div>
              <div class="absolute left-0 top-[14px] -translate-x-full w-0 h-0 border-t-[12px] border-t-transparent border-r-[20px] border-r-[#f9f3e8] border-b-[12px] border-b-transparent">
              </div>
              <p class="font-[MedievalSharp] text-[#2c1810] text-lg mb-4">
                Greetings, my liege. I am Elric the Steward, sworn to guide your daily quests.
              </p>
              <p class="font-[MedievalSharp] text-[#2c1810] text-lg">
                Shall I show you how to marshal your tasks and projects?
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

        <div class="mt-8 text-center font-[MedievalSharp] text-sm text-[#8B7355] italic border-t border-[#8B7355] pt-4">
          "One task at a time, my liege. The realm awaits."
        </div>
      </div>
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
