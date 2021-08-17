defmodule TimebankWeb.Trade.RequestView do
  use TimebankWeb, :view

  alias Timebank.Trade

  def timelord_name(%Trade.Request{timelord: timelord}) do
    timelord.user.name
  end

  
end
