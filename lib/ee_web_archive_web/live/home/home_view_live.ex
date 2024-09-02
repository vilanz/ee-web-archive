defmodule EEWebArchiveWeb.HomeViewLive do
  use EEWebArchiveWeb, :live_view

  def render(assigns) do
    ~H"""
    <.flash_group flash={@flash} />
    <div class="px-4">
      <div class="flex flex-col text-center gap-4 items-center">
        <h1 class="text-4xl font-bold">Welcome to the EE Web Archive!</h1>
        <button class="btn btn-primary">Get Started</button>
      </div>
    </div>
    """
  end
end
