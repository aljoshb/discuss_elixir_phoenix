// Import the socket library
import {Socket} from "phoenix"

// Create an instance of Socket
let socket = new Socket("/socket", {params: {token: window.userToken}})

// Connect to the server
socket.connect()

const createSocket = (topidId) => {
  // Now that you are connected, you can join channels with a topic:
  let channel = socket.channel(`comments:${topidId}`, {})
  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })

    document.querySelector('button').addEventListener('click', () => {
      const content = document.querySelector('textarea').value;

      channel.push('comment:add', { content: content });
    });
}

window.createSocket = createSocket;
