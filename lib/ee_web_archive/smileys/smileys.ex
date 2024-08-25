defmodule EEWebArchive.Smileys do
  alias EEWebArchive.Smileys.PlayerSmiley
  alias EEWebArchive.SmileyRepo

  def get_player_smiley_id(player_id) do
    player_smiley = SmileyRepo.get(PlayerSmiley, player_id)
    player_smiley.smiley_id
  end
end
