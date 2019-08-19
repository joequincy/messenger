class UserLeftMessage {
  constructor(data){
    return this.element(data['name'])
  }

  element(name){
    let message = document.createElement('div')
    message.classList.add('userJoined')
    message.innerText = name + " has left the chat."
    return message
  }
}
