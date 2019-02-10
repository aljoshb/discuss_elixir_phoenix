// Import the socket library
import {Socket} from "phoenix"

// Create an instance of Socket
let socket = new Socket("/socket", {params: {token: window.userToken}})

// Connect to the server
socket.connect()

const createSocket = (topicId) => {
  // Now that you are connected, you can join channels with a topic:
  let channel = socket.channel(`comments:${topicId}`, {})
  channel.join()
    .receive("ok", resp => { 
      renderComments(resp.comments)
    })
    .receive("error", resp => { 
      console.log("Unable to join", resp) 
    })

    document.querySelector('button').addEventListener('click', () => {
      const content = document.querySelector('textarea').value;

      channel.push('comment:add', { content: content });
    });

    channel.on(`comments:${topicId}:new`, renderComment);

}

// Render all comments
function renderComments(comments) {
  const renderedComments = comments.map(comment => {
    return commentTemplate(comment);
  });

  document.querySelector('.collection').innerHTML = renderedComments.join('');
}

// Render the new comment, when a user in the channel adds a new comment
function renderComment(event) {
  const renderedComment = commentTemplate(event.comment);

  document.querySelector('.collection').innerHTML += renderedComment;
}

// Render one comment. This produces an html for each comment
function commentTemplate(comment) {
  return `
    <li class="collection-item">
      ${comment.content}
    </li>
  `;
}

window.createSocket = createSocket;
