# The request will go to the route and then to this plug and finally to the controller actions
defmodule Discuss.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Router.Helpers

  def init(_params) do 
  end

  def call(conn, _params) do
    if conn.assigns[:user] do # If a user is in the conn, it means they are logged in, so just return conn
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in.")
      |> redirect(to: Helpers.topic_path(conn, :index))
      |> halt() # By default, phoenix will try to send 
                # the conn returned by this plug to another 
                # plug or a controller, we don't want that, 
                # we want to force the user to sign it, 
                # so we `halt` the normal phoenix flow and 
                # tell it to return to the user 
    end
  end
end