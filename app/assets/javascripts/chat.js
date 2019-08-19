document.addEventListener('DOMContentLoaded', ()=>{
  (function() {
    this.App || (this.App = {});

    App.elms = {}
    App.elms.setup = document.querySelector('.setup')
    App.elms.nameInput = document.querySelector('#userNameInput')
    App.elms.nameSubmit = document.querySelector('#userNameSubmit')

    App.elms.roomChooser = document.querySelector('.roomList')
    App.elms.roomList = document.querySelector('#roomList')
    App.elms.roomInput = document.querySelector('#roomInput')
    App.elms.chooseRoom = document.querySelector('#chooseRoom')

    App.elms.userList = document.querySelector('.userList')
    App.elms.chatWindow = document.querySelector('.chatWindow')
    App.elms.messageWindow = document.querySelector('.messageWindow')

    App.elms.chatInput = document.querySelector('#chatInput')
    App.elms.chatSubmit = document.querySelector('#chatSubmit')
  }).call(this);
})
