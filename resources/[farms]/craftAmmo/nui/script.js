let items = [

    {name: 'M. Five', price: '$60.000| 8x Polvora9MM', action_name: 'utilidades-comprar-five', image: 'images/m-fiveseven.png'},
  
    {name: 'M. SMG', price: '$80.000| 20x Polvora9MM', action_name: 'utilidades-comprar-smg', image: 'images/m-mp5.png'},

    {name: 'M. Ak47', price: '$115.000| 45x Polvora762', action_name: 'utilidades-comprar-ak', image: 'images/m-ak74.png'},
    {name: 'M. G36', price: '$115.000| 45x Polvora762', action_name: 'utilidades-comprar-g3', image: 'images/m-g36mk2.png'},
]

let active_item_action = 'utilidades-comprar-five'

function render() {
    let container = document.querySelector('.items-container')

    container.innerHTML = ''

    for (let i in items ) {
        if (items[i].name == 'M. Five') {
            container.innerHTML += `
            <div class = 'itemUnit activeItem appear' data-action_name = '${items[i].action_name}' id = '${i}' onclick = 'selectItem(event)'>
                <p>${items[i].name}</p>
                <img src = '${items[i].image}'>
                <p>${items[i].price}</p>
            </div>
            `
        } else {
            container.innerHTML += `
            <div class = 'itemUnit appear' data-action_name = '${items[i].action_name}' id = '${i}' onclick = 'selectItem(event)'>
                <p>${items[i].name}</p>
                <img src = '${items[i].image}'>
                <p>${items[i].price}</p>
            </div>
            `
        }

    }
}

render()

function selectItem(event) {
    let element = event.currentTarget

    let oldSelected = document.querySelector('.activeItem')
    oldSelected.classList.remove('activeItem')

    element.classList.add('activeItem')

    element.classList.add('.activeItem')

    let apresentation_container = document.querySelector('.itemApresentation-container')

    apresentation_container.innerHTML = `
        <h1 class = 'fade'>${items[element.id].name}</h1>
        <img  class = 'fade' src="${items[element.id].image}" alt="">
        <p  class = 'fade'></p>

        <div class = 'buyBttn fade' onclick = 'buy()'>
            FABRICAR
        </div>
    `

    active_item_action = items[element.id].action_name

}

function buy() {
    let options = {
        method: 'POST',
        body: JSON.stringify({data: active_item_action}) 
    }

    
    fetch('http://craftAmmo/ButtonClick', options) 
}

function show() {
    let container = document.querySelector('main')
    
    container.classList.add('fade')
    container.classList.remove('hide')
    container.style.display = 'block'

    render()
}

function hide() {
    let container = document.querySelector('main')

    container.classList.remove('fade')
    container.classList.add('hide')

    container.style.display = 'none'

}

document.querySelector('body').addEventListener('keydown', (event) => {
    if (event.keyCode == '27') {

        let options = {
            method: 'POST',
            body: JSON.stringify({}) 
        }
    
        fetch("http://craftAmmo/CloseNui", options) // url que é feita a requisição apenas para tirar o foco da nui
    
        hide()
    }
})


window.addEventListener("message", (event) => {
    if (event.data.showMenu) {
        show()
    }
}) 