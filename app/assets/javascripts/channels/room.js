App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {
    console.log('connected')
    // Called when the subscription is ready for use on the server
    const button = document.getElementById('button')
    button.disabled=false
    button.textContent="送信"
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
    console.log("disconnected")
    window.location.reload();
  },

  received: function(message) {
    console.log(message)
    const messages = document.getElementById('messages')
    messages.innerHTML += message
    // Called when there's incoming data on the websocket for this channel
  },

  speak: function(content,data_user,data_room) {
    return this.perform('speak', {message: content, user_id: data_user,room_id: data_room});
  }
});

document.addEventListener('DOMContentLoaded', function(){
  const input = document.getElementById('chat-input')
  const button = document.getElementById('button')
  button.disabled=true
  button.textContent="接続中"
  const data_user = input.getAttribute("data_user")
   const data_room = input.getAttribute("data_room")
  　button.addEventListener('click', function(){
    const content = input.value
    App.room.speak(content,data_user,data_room)
    input.value = ''
  })
})

