defmodule TimebankWeb.Skills.TagView do
  use TimebankWeb, :view

  alias Timebank.Skills

  def timelord_name(%Skills.Tag{timelord: timelord}) do
    timelord.user.name
  end
end
