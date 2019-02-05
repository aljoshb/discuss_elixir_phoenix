defmodule Discuss.TopicController do
  use Discuss.Web, :controller
  
  alias Discuss.Topic

  @doc """
    Display a list of topics
  """
  def index(conn, _params) do
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
    changeset = Topic.changeset(%Topic{}, topic)
    
    # Insert the data in the changeset into the database
    case Repo.insert(changeset) do
      {:ok, post} -> 
        conn
        |> put_flash(:info, "Topic Created") # Create a message telling the user topic was created
        |> redirect(to: topic_path(conn, :index)) # Redirect to the index route
      {:error, changeset} -> 
        render conn, "new.html", changeset: changeset # If the insertion fails, show the user the form again
    end
  end

end
