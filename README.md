# EE Web Archive

> [!WARNING]  
> This project is still a WIP. An alpha release is available at https://test.offlinee.com/, but hic sunt dracones.

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



