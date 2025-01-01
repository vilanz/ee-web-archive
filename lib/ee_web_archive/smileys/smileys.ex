defmodule EEWebArchive.Smileys do
  alias EEWebArchive.Smileys.PlayerSmiley
  alias EEWebArchive.SmileyRepo

  def get_player_smiley_id(player_id) do
    player_smiley = SmileyRepo.get(PlayerSmiley, player_id)

    if player_smiley == nil do
      0
    else
      player_smiley.smiley_id
    end
  end

  def get_player_smiley_path(player_id) do
    smiley_id = get_player_smiley_id(player_id)
    "/images/smileys/#{smiley_id}.png"
  end
end
