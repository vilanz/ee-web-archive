defmodule EEWebArchive.ArchivEE.WorldParser.Block do
  alias EEWebArchive.ArchivEE.WorldParser.BlockColor

  @type t :: %__MODULE__{
          id: integer(),
          layer: integer(),
          color: BlockColor.t(),
          positions: [{integer(), integer()}]
        }

  defstruct [:id, :layer, :color, :positions]
end
