# EE Web Archive

A browsable and queryable archive for an old game from my childhood years :)

> [!WARNING]  
> This project is a WIP. Current focus is on an HTTP API used for EE spinoffs, and not on the UI/frontend even if an early UI alpha [technically exists](https://new.offlinee.com).

## Backlog

- Port the ArchivEE 2 changes, especially the new `zstd` compression in world data. ([link to changes](https://gitlab.com/LukeM212/ArchivEE/-/commit/787d950abf845b06aa7bdaa328ec2210ad43643d#58e90d4e7ceee36e74d913235fe4ba0a69b8c670))
- Improve performance for generating minimap images from binary world data.
- Various HTTP API improvements:
  - Allow fetching worlds by owner name, since that's the "foreign key" for external services
  - Add crew info to world data
  - Expose endpoint for fetching random assorted worlds 

## Running the project

- Run `sudo ./setup.sh` to set up the Everybody Edits data locally. **Needs Python 3 and pip.**
- Install [`asdf`](https://asdf-vm.com/) and set up Elixir + Erlang:
  1. Install [the prereq packages](https://github.com/asdf-vm/asdf-erlang?tab=readme-ov-file#before-asdf-install) for `asdf-erlang`.
  2. run `asdf plugin add erlang && asdf plugin add elixir`.
  3. Run `asdf install` to install the Elixir + Erlang versions specified in `.tool-versions`.
- Run `cd ./assets && npm i && cd ..`. *Need to set this up inside `mix setup` later :/*
- Run `mix setup` to install and setup dependencies.
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`.

Now you can visit [`localhost:4000`](http://localhost:4000) and browse around.




