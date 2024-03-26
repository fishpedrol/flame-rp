function armamentos() {
    $(".kit-main").hide()
    $(".armamentos-main").show()
}

function kit() {
    $(".armamentos-main").hide()
    $(".kit-main").show()
}

$('input[type="text"]').on("keyup", (param) => {
    const input = $($(param.target)[0]).val().toLowerCase()
    const elemento = $('.quadrado')


    for (let i = 0; i < elemento.length; i++) {
        if (!elemento[i].innerHTML.toLowerCase().includes(input)) {
            $(elemento[i]).hide()
        } else {
            $(elemento[i]).show()
        }

    }
})

$("img").attr("draggable","false")
const active = (parameter) => {
    $('.armamentos').removeClass('active')
    $('#armamentos').removeClass('active')
    $(parameter).addClass("active")
}
function fechar() {
    $('body').fadeOut()
    fetch(`https://${GetParentResourceName()}/fechar2`, {
        method: "POST",
        headers: {
        "Content-Type": "application/json; charset=UTF-8",
        }
    })
} 


$("body").css("display", "none")

window.addEventListener('message', (event) => {
    const data  = event.data


    if (data.arsenal) {
        $("body").css("display", "flex")
    } else {
      $("body").css("display", "none")
    }


  
  })


function equipar(print) {
    console.log(print)
    fetch(`https://${GetParentResourceName()}/buy`, {
		method: "POST",
		headers: {
		"Content-Type": "application/json; charset=UTF-8",
		},
		body: JSON.stringify({name : print}),
	})
}

document.onkeyup = function(data) {
    if (data.which == 27) {
        $("body").css("display", "none")
        fetch(`https://${GetParentResourceName()}/fechar2`, {
            method: "POST",
            headers: {
            "Content-Type": "application/json; charset=UTF-8",
            }
        })
    }
  };