function setInfo(data) {
        $("main").html(`
            <header>
            <h1>SUAS INFORMAÇÕES</h1>
        </header>
        <section>
            <div id="info">
                <p id="label"><img src="./assets/nome.svg"> nome</p>
                <p id="value">${data.name}</p>
            </div>
            <div id="info">
                <p id="label"><img src="./assets/idade.svg"> idade</p>
                <p id="value">${data.age} anos</p>
            </div>
            <div id="info">
                <p id="label"><img src="./assets/passaporte.svg"> passaporte</p>
                <p id="value">${data.id}</p>
            </div>
            <div id="info">
                <p id="label"><img src="./assets/identidade.svg"> identidade</p>
                <p id="value">${data.identity}</p>
            </div>
            <div id="info">
                <p id="label"><img src="./assets/telefone.svg"> telefone</p>
                <p id="value">${data.phone}</p>
            </div>
        </section>
        ${ data.job || data.job2 || data.vip || data.staff ? `<section style="margin-top: 13px">
            ${ data.job ? `<div id="info">
                <p id="label"><img src="./assets/emprego.svg"> emprego</p>
                <p id="value">${data.job}</p>
            </div>` : ""}
            ${ data.job2 ? `<div id="info">
                <p id="label"><img src="./assets/emprego.svg"> emprego²</p>
                <p id="value">${data.job2}</p>
            </div>` : ""}
            ${ data.staff ? `<div id="info">
                <p id="label"><img src="./assets/staff.svg"> administração</p>
                <p id="value">${data.staff}</p>
            </div>` : ""}
            ${ data.vip ? `<div id="info">
                <p id="label"><img src="./assets/assinatura.svg"> assinatura</p>
                <p id="value">${data.vip}</p>
            </div>` : ""}
        </section>` : ""}
        <section style="margin-top: 13px">
            <div id="info">
                <p id="label"><img src="./assets/carteira.svg"> carteira</p>
                <p id="value">R$ ${data.wallet}</p>
            </div>
            <div id="info">
                <p id="label"><img src="./assets/banco.svg"> banco</p>
                <p id="value">R$ ${data.bank}</p>
            </div>
        </section>
        `)
}
window.addEventListener("message", function({data}) {
    setInfo(data)
    if (data.action === "show") $("main").css("display",  "flex")
    if (data.action === "hide") $("main").css("display",  "none")
})