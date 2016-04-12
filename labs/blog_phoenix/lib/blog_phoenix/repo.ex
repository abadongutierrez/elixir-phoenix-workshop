defmodule BlogPhoenix.Repo do
  #use Ecto.Repo, otp_app: :blog_phoenix

  def start_link do
    Agent.start_link(fn ->
      [%BlogPhoenix.Post{
        id: 1, title: "Post no 1",
        body: "Bla bla bla bla",
        comments: [%BlogPhoenix.Comment{
          id: 1,
          name: "Someone",
          content: "I dont like it"
        }, %BlogPhoenix.Comment{
          id: 2,
          name: "Someone else",
          content: "I like it"
        }]
      },
      %BlogPhoenix.Post{
        id: 2,
        title: "Post no 2",
        body: "Bla bla bla bla",
        comments: []
      }]
     end, name: __MODULE__)
  end

  def all_posts() do
      Agent.get(__MODULE__, fn list -> Enum.sort(list, &(&1.id < &2.id)) end)
  end

  def get_post_by_id(id) do
    found = Enum.find all_posts(), fn map -> map.id == id end
    case found do
      nil -> nil
      _ -> found
    end
  end

  defp is_valid?(%BlogPhoenix.Post{} = model) do
    {:yes}
  end

  defp is_valid?(%BlogPhoenix.Comment{} = model) do
    {:yes}
  end

  def insert_post(post) do
    case is_valid?(post) do
      {:yes} ->
        newPost = %BlogPhoenix.Post{post | id: Enum.count(all_posts()) + 1, comments: []}
        Agent.update(__MODULE__, fn list ->
          [newPost | list] 
        end)
        {:ok, newPost}
      {:no, errors} -> {:error, errors}
    end
  end

  def insert_comment_in_post(post, comment) do
    case is_valid?(comment) do
      {:yes} ->
        newComment = %BlogPhoenix.Comment{comment | id: Enum.count(post.comments) + 1}
        newPost = %BlogPhoenix.Post{post | comments: [newComment | post.comments]}
        Agent.update(__MODULE__, fn list ->
          newList = Enum.filter(list, fn(x) -> x.id != newPost.id end)
          [newPost | newList] 
        end)
        {:ok, newPost}
      {:no, errors} -> {:error, errors}
    end
  end

  def update_post(post) do
    case is_valid?(post) do
      {:yes} ->
        Agent.update(__MODULE__, fn list ->
          newList = Enum.filter(list, fn(x) -> x.id != post.id end)
          [post | newList] 
        end)
        {:ok, post}
      {:no, errors} -> {:error, errors}
    end
  end

  def delete_post(post) do
    Agent.update(__MODULE__, fn list ->
      Enum.filter(list, fn(x) -> x.id != post.id end)
    end)
  end
end
