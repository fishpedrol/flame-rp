function upper(content) {
    let letter = content.split('')[0].toUpperCase()

    let div = content.split('')

    div.splice(0, 1)

    return letter + div.join('')
}

function notify(message, type) {
    
    let color = ''
    let img = ''

    if (type == 'sucesso' || type == 'financeiro' || type == 'vtuning') {
        color = '#48BF53'
        img = 'checked.svg'
    } else if (type == 'negado') {
        color = '#FD003A'
        img = 'cancel.svg'
    } else if (type == 'importante' || type == 'aviso' || type == 'search')  {
        color = '#FEA832'
        img = 'warning.svg'
    } 

    let container = document.querySelector('.notify-container')
    
    let notify = document.createElement('div')
    notify.classList.add('notify')
    notify.classList.add('fade')

    notify.innerHTML = `
        <img src="images/${img}" style = "filter: drop-shadow(0px 0px 15px ${color})" alt="">
        <div class = 'notifyText'>
            <span>${upper(type)}</span>
            <p>${message}</p>
        </div>
    `

    container.appendChild(notify)

    deleteElement(notify)
}

function deleteElement(element) {
    setTimeout(() => {
        element.classList.remove('fade')
        element.classList.add('hide')
        setTimeout(() => {
            element.remove()
        }, 590);
    }, 4900);
}

window.addEventListener("message", ({data}) => {
    notify(data.message, data.css)
})

