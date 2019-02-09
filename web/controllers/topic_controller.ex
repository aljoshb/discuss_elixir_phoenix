defmodule Discuss.TopicController do
  use Discuss.Web, :controller
  
  alias Discuss.Topic

  plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
  plug :check_topic_owner when action in [:update, :edit, :delete] # Using a plug function this time, since it's specific to this controller. Function is defined in this file.

  @doc """
    Display a list of topics
  """
  def index(conn, _params) do
    IO.inspect(conn.assigns)
    topics = Repo.all(Topic) # get all the topics in the database - remember we are using alias here so no need to write Discuss.Repo.all(Discuss.Topic)

    render conn, "index.html", topics: topics
  end

  @doc """
    Display the form to create a new topic
  """
  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render conn, "new.html", changeset: changeset
  end

  @doc """
    Submit the form to create a new topic
  """
  def create(conn, %{"topic" => topic}) do
    # Create the changeset - it contains the data we want to insert
    changeset = conn.assigns.user
      |> build_assoc(:topics) # Associate the user that created this topic with this topic in the topics database
      |> Topic.changeset(topic)

    # Insert the data in the changeset into the database
    case Repo.insert(changeset) do
      {:ok, _} -> 
        conn
        |> put_flash(:info, "Topic Created") # Create a message telling the user topic was created
        |> redirect(to: topic_path(conn, :index)) # Redirect to the index route
      {:error, changeset} -> 
        render conn, "new.html", changeset: changeset # If the insertion fails, show the user the form again
    end
  end

  @doc """
    Edit a topic
  """
  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id) # Get the topic we want to edit from the database
    changeset = Topic.changeset(topic) # Create a changeset out of the topic that was gotten from the database

    render conn, "edit.html", changeset: changeset, topic: topic
  end

  @doc """
    Update a topic
  """
  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, topic: old_topic
    end
  end

  @doc """
    Delete a topic
  """
  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete! # For instance, if a user tries to delete a record that doesn't exist, explode
    
    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))
  end

  @doc """
    Function plug to ensure that a user can only update what it created.
    This plug is neccesary, just in case a user still finds a way to get to this route.
  """
  def check_topic_owner(conn, _params) do # this specific params is not coming from router, that is, this is not the request parameters, unlike in the action functions above
    %{params: %{"id" => topic_id}} = conn # We pull out the request param from the conn stuct

    if Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
    else
      conn
      |> put_flash(:error, "You cannot edit that")
      |> redirect(to: topic_path(conn, :index))
      |> halt() # Again, reject this request immediately, if this user didn't create this topic
    end
  end
end
