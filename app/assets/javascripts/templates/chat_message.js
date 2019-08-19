class ChatMessage {
  constructor(data){
    return this.element(data)
  }

  element(data){
    let message = document.createElement('div')
    message.classList.add('chatMessage')

    let user = document.createElement('span')
    user.classList.add('messageUser')
    user.innerText = data['user']

    let time = document.createElement('span')
    time.classList.add('timestamp')
    time.innerText = data['timestamp']

    message.appendChild(user)
    message.append(data['message'])
    message.appendChild(time)
    return message
  }
}
