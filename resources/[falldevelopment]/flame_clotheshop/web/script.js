let names = ['ACESSORIOS','MAÕS','CALÇA','BLUSA','CHAPEU','COLETE','JAQUETA','OCULOS','MOCHILA', 'SAPATOS', 'MÁSCARA', 'PULSEIRA', 'RELÓGIO'] 

let clothes = { 
    acessorios: {tag: '12', model: '2'},
    maos: {tag: '28', model: '19'},
    calca: {tag: '60', model: '9'},
    blusa: {tag: '77', model: '4'},
    chapeu: {tag: '8', model: '19'},
    colete: {tag: '57', model: '14'},
    jaqueta: {tag: '8', model: '3'},
    oculos: {tag: '8', model: '19'},
    mochila: {tag: '8', model: '19'},
    sapatos: {tag: '8', model: '19'},
    mascara: {tag: '5', model: '1'},
    pulseira: {tag: '8', model: '19'},
    relogio: {tag: '8', model: '19'}
}

let buy = false

let selectedCam = null;

window.addEventListener('message', (event) => {
    let container = document.querySelector('main')

    if (event.data.action == 'open') {
        container.style.display = 'flex'
        container.classList.add('fade')
        $(".blocks-container").html("")

        clothes = JSON.parse(event.data.initial)
        start(clothes)

        setTimeout(() => {
            container.classList.remove('fade')
        }, 590)
    } 

})

function close() {
    if (!buy) {
        reset()
    } 

    buy = false

    let container = document.querySelector('main')
    container.classList.add('hide')

    fetch('https://Flame_clotheshop/close', {method: 'POST', body: JSON.stringify({})}) // Url que deve fechar a NUI tirando seu foco
    
    let blocks = document.querySelector('.blocks-container')

    $(selectedCam).removeClass('header-select');
    // blocks.innerHTML = ''
    
    setTimeout(() => {
        container.style.display = 'none'
        container.classList.remove('hide')
    }, 590)
}


document.querySelector('body').addEventListener('keydown', (event) => {
    if (event.keyCode == '27') {
        close()
    }
})

function start(_clothes) {
    let container = document.querySelector('.blocks-container')
    for (let i in _clothes ) {
        container.innerHTML += `
        <div class = 'blockUnit appear'>
            <h1>${clothes[i].name}</h1>
            <div class = 'vertLine'></div>
            <div class = 'changeContainer' id = '${i}'>
                <div class = 'changeUnit'>
                    <p>MODELO</p>  
                    <div class = 'changeInput'>
                        <img onclick = 'decrease(event, "${i}")' src="assets/arrowL.svg" alt="">
                        <input class = 'model' onchange = 'setPreview("${i}","${clothes[i].name}")' type="number" value = '${clothes[i].item}' >
                        <img onclick = 'increase(event, "${i}")' src="assets/arrowR.svg" alt="">
                    </div>  
                </div>

                <div class = 'changeUnit'>
                    <p style='text-align: end;'>ETIQUETA</p>  
                    <div class = 'changeInput'>
                        <img  onclick = 'decrease(event, "${i}")' src="assets/arrowL.svg" alt="">
                        <input class = 'tag' onchange = 'setPreview("${i}","${clothes[i].name}")' type="number" value = '${clothes[i].texture}' >
                        <img  onclick = 'increase(event, "${i}")' src="assets/arrowR.svg" alt="">
                    </div>  
                </div>
            </div>
        </div> 
        
        `
    }
}

function setPreview(id,index) {
    let tag = document.querySelector(`#${id} .tag`).value
    let model = document.querySelector(`#${id} .model`).value

    console.log(tag, model)

    let data = {}
    data[id] = {tag, model, index}
    let options = {
        method: 'POST',
        body: JSON.stringify(data)
    }

    fetch('https://Flame_clotheshop/viewPreset', options)
}

function decrease(event, id) {
    let element = event.currentTarget

    let input = element.nextSibling.nextSibling

    if (Number(input.value) <= 0) {
        return 
    }

    input.value = Number(input.value) - 1

    setPreview(id)
}

function increase(event, id) {
    let element = event.currentTarget

    let input = element.previousSibling.previousSibling

    input.value = Number(input.value) + 1

    setPreview(id)
}

function makeBuyAction() { 
    let options = {
        method: 'POST',
        body: JSON.stringify({})
    }

    fetch('https://Flame_clotheshop/Buy', options) 

    buy = true

    close()
}

function reset() {
    let options = {
        method: 'POST',
        body: JSON.stringify({})
    }

    fetch('https://Flame_clotheshop/reset', options) 
}

$(document).on('click', '.header-camera', function(){
    let camValue = parseFloat($(this).data('value'));

    if (selectedCam == null) {
        $(this).addClass('header-select');

        $.post('https://Flame_clotheshop/setupCam', JSON.stringify({
			value: camValue
		}));

		selectedCam = this;
    } else {
        if (selectedCam == this) {
			$(selectedCam).removeClass('header-select');

			$.post('https://Flame_clotheshop/setupCam', JSON.stringify({
				value: 0
			}));

			selectedCam = null;
		} else {
			$(selectedCam).removeClass('header-select');
            
			$(this).addClass('header-select');

			$.post('https://skinshop/setupCam', JSON.stringify({
				value: camValue
			}));

			selectedCam = this;
		}
    }
});

$(document).on('keydown', function() {
	switch(event.keyCode) {
        case 68:
            $.post('https://Flame_clotheshop/rotateRight');
        break;

        case 65:
            $.post('https://Flame_clotheshop/rotateLeft');
        break;
    }
});