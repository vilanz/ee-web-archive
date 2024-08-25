defmodule EEWebArchive.Smileys do
  alias EEWebArchive.Smileys.PlayerSmiley
  alias EEWebArchive.SmileyRepo
  import Ecto.Query, only: [from: 2]

  def get_player_smiley_id(player_id) do
    player_smiley = SmileyRepo.get(PlayerSmiley, player_id)

    if player_smiley == nil do
      0
    else
      player_smiley.smiley_id
    end
  end

  def get_multiple_players_smiley_ids(player_ids) do
    query =
      from smiley in PlayerSmiley,
        where: smiley.player_id in ^player_ids,
        select: smiley.smiley_id

    SmileyRepo.all(query)
  end
end
