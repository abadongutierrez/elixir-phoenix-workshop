defmodule BlogPhoenix.Post do
  defstruct [:id, :title, :body, :comments]

  def from_map(map) do
    %BlogPhoenix.Post{
      title: map["title"],
      body: map["body"]
    }
  end

  def update_from_map(post, map) do
    %BlogPhoenix.Post{post |
      title: map["title"],
      body: map["body"]
    }
  end
end
