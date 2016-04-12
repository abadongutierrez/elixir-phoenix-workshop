defmodule BlogPhoenix.Comment do
  defstruct [:id, :name, :content]

  def from_map(map) do
    %BlogPhoenix.Comment{
      name: map["name"],
      content: map["content"]
    }
  end
end
