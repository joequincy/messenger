// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.
//
//= require action_cable
//= require_self
//= require_tree ./templates
//= require_tree ./channels

(function() {
  this.App || (this.App = {});

  App.announceUser = (data) => {
    App.elms.messageWindow.appendChild(new UserArrivedMessage(data))
    App.elms.userList.appendChild(new UserListItem(data))
  }

  App.appendMessage = (data) => {
    App.elms.messageWindow.appendChild(new ChatMessage(data))
  }

  App.subscribe = (details) => {
    App.room = App.cable.subscriptions.create(details, {
      connected: () => {
        //connected
      },
      received: (raw) => {
        let message = JSON.parse(raw.message)
        switch(message['type']){
          case 'user-joined':
            App.announceUser(message['data'])
            break
          case 'user-left':
            App.announceExit(message['data'])
            break
          case 'message':
            App.appendMessage(message['data'])
            break
          default:
        }
      }
    })

    App.sendMessage = (text) => {
      App.room.perform("send_message", {text: text})
    }
  }

}).call(this);
