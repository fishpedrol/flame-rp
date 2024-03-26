let items = [


    {name: 'FIVE-SEVEN', price: '$ 75k | 5x PEÇA ARMA', action_name: 'utilidades-comprar-five', image: 'images/five.png'},
    {name: 'SMG MK2', price: '$90k | 1x PEÇA SUB', action_name: 'utilidades-comprar-mp5', image: 'images/mp5.png'},
    {name: 'AK-47', price: '$175k | 1x PEÇA AK', action_name: 'utilidades-comprar-ak', image: 'images/ak.png'},
    {name: 'G36C', price: '$210k | 1x PEÇA G3', image: 'images/g36.png', action_name: 'utilidades-comprar-g3'},
]

let active_item_action = 'utilidades-comprar-five'

function render() {
    let container = document.querySelector('.items-container')

    container.innerHTML = ''

    for (let i in items ) {
        if (items[i].name == 'FIVE-SEVEN') {
            container.innerHTML += `
            <div class = 'itemUnit activeItem appear' data-action_name = '${items[i].action_name}' id = '${i}' onclick = 'selectItem(event)'>
                <p class = 'tituloo'>${items[i].name}</p>
                <img src = '${items[i].image}'>
                <p class = 'itensnecessarios'>${items[i].price}</p>
            </div>
            `
        } else {
            container.innerHTML += `
            <div class = 'itemUnit appear' data-action_name = '${items[i].action_name}' id = '${i}' onclick = 'selectItem(event)'>
                <p>${items[i].name}</p>
                <img src = '${items[i].image}'>
                <p  class = 'itensnecessarios'>${items[i].price}</p>
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

    console.log(active_item_action)
}

function buy() {
    let options = {
        method: 'POST',
        body: JSON.stringify({data: active_item_action}) 
    }

    console.log(active_item_action)
    
    fetch('http://craftGuns/ButtonClick', options) 
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
    
        fetch("http://craftGuns/CloseNui", options) // url que é feita a requisição apenas para tirar o foco da nui
    
        hide()
    }
})


window.addEventListener("message", (event) => {
    if (event.data.showMenu) {
        show()
    }
}) 