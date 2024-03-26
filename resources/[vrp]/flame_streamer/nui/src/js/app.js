const setShow = (value) => {
    if (!value) {
        return $("body").fadeOut();
    }

    $("body").fadeIn()
};

$('#close').click(function () {
    $("body").fadeOut();
    fetch(`https://${GetParentResourceName()}/closeNui`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            itemId: 'my-item'
        })
    }).then(resp => resp.json()).then(resp => console.log(resp));
    change = {};
});

function setCarro() {
    $("body").fadeOut();
    fetch(`https://${GetParentResourceName()}/setCarro`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            itemId: 'my-item'
        })
    }).then(resp => resp.json()).then(resp => console.log(resp));

}

function setMoto() {
    $("body").fadeOut();
    fetch(`https://${GetParentResourceName()}/setMoto`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            itemId: 'my-item'
        })
    }).then(resp => resp.json()).then(resp => console.log(resp));

}

function setGun() {
    $("body").fadeOut();
    fetch(`https://${GetParentResourceName()}/setGun`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            itemId: 'my-item'
        })
    }).then(resp => resp.json()).then(resp => console.log(resp));

}
document.onkeyup = function(data){
        if (data.which == 27){
        $("body").fadeOut();
        fetch(`https://${GetParentResourceName()}/closeNui`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
                itemId: 'my-item'
            })
        }).then(resp => resp.json()).then(resp => console.log(resp));
        }
    }

var events = {
    setShow
};

window.addEventListener("message", (event) => {
    const item = event.data || event.detail;
    if (events[item.type])
        events[item.type](item.detail);
})

window.emulate = (type, detail = {}) => {
    window.dispatchEvent(
        new CustomEvent("message", {
            detail: {
                type: type,
                detail: detail,
            },
        })
    )
};