// Import the socket library
import {Socket} from "phoenix"

// Create an instance of Socket
let socket = new Socket("/socket", {params: {token: window.userToken}})

// Connect to the server
socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("comments:1", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
