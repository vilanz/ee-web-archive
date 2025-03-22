defmodule EEWebArchiveWeb.WorldController do
  use EEWebArchiveWeb, :controller

  alias EEWebArchive.ArchivEE.Worlds

  def download_world(conn, %{"world_id" => world_id}) do
    world =
      Worlds.get_by_id(world_id)

    if world == nil do
      conn
      |> send_resp(404, "World not found")
    else
      filename = "#{world.name} - #{world.owner_player.name}.eelvl"
      map_data = Worlds.get_map_data(world_id)

      conn
      |> put_resp_header("content-disposition", "attachment; filename=\"#{filename}\"")
      |> send_resp(200, map_data)
    end
  end

  def get_world_info(conn, %{"world_id" => world_id}) do
    world =
      Worlds.get_by_id(world_id)
      |> Worlds.add_owner_to_json()
      |> Worlds.add_crew_to_json()

    if world == nil do
      conn
      |> send_resp(404, "World not found")
    else
      conn
      |> json(world)
    end
  end

  def get_random_worlds(conn, _) do
    fetch_query_params(conn)

    {minimum_plays_param, ""} = Integer.parse(Map.get(conn.params, "min_plays", "10000"))
    minimum_plays = max(0, minimum_plays_param)

    {limit_param, ""} = Integer.parse(Map.get(conn.params, "limit", "10"))
    limit = max(1, min(30, limit_param))

    worlds =
      Worlds.list_frequently_played_at_random(minimum_plays, limit)
      |> Enum.map(&Worlds.add_owner_to_json/1)
      |> Enum.map(&Worlds.add_crew_to_json/1)

    conn
    |> json(worlds)
  end

  def get_worlds_by_owner(conn, %{"owner_name" => owner_name}) do
    worlds =
      Worlds.get_by_owner_name(owner_name)
      |> Enum.map(&Worlds.add_crew_to_json/1)

    if length(worlds) == 0 do
      conn
      |> send_resp(404, "World not found")
    else
      conn
      |> json(worlds)
    end
  end
end
