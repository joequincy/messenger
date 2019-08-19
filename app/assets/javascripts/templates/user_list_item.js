class UserListItem {
  constructor(data){
    return this.element(data['name'])
  }

  element(name){
    let user = document.createElement('div')
    user.setAttribute('data-name', name)
    user.classList.add('user')
    user.innerText = name
    return user
  }
}
