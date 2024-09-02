defmodule EEWebArchiveWeb.HomeViewLive do
  use EEWebArchiveWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="px-4 text-center">
      <h4>Welcome to the EE Web Archive!</h4>
    </div>
    """
  end
end
