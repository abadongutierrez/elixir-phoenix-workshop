defmodule BlogPhoenix.PostController do
  use BlogPhoenix.Web, :controller

  alias BlogPhoenix.Post
  alias BlogPhoenix.Comment

  plug :scrub_params, "post" when action in [:create, :update]
  plug :scrub_params, "comment" when action in [:add_comment]

  def index(conn, _params) do
    posts = Repo.all_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"post" => post_params}) do
    post = Post.from_map(post_params)

    case Repo.insert_post(post) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :index))
      {:error, errors} ->
        render(conn, "new.html", errors: errors)
    end
  end

  def show(conn, %{"id" => id}) do
    text conn, "FIX ME!"
  end

  def edit(conn, %{"id" => id}) do
    text conn, "FIX ME!"
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    text conn, "FIX ME!"
  end

  def delete(conn, %{"id" => id}) do
    text conn, "FIX ME!"
  end

  def add_comment(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    comment = Comment.from_map(comment_params)
    post = Repo.get_post_by_id(elem(Integer.parse(post_id), 0))

    case Repo.insert_comment_in_post(post, comment) do
      {:ok, new_post} ->
        conn
        |> put_flash(:info, "Comment added.")
        |> redirect(to: post_path(conn, :show, new_post))
      {:error, errors} ->
        render(conn, "show.html", post: post, errors: errors)
    end
  end
end
