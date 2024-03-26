$(document).ready(function(){
    window.addEventListener("message",function(event){ 
        if (!event.data) return null;
        var item = event.data
        // console.log(item.assassino,item.arma,item.alvo);
        const html = `
        <div class="item animate__animated animate__fadeInDown">
            <div class="name1 text">${item.assassino}</div>
            <div class="icon">
                <figure>
                    <img src="./imagens/${item.arma}.png" alt="Pistola">
                </figure>
            </div>
            <div class="name2 text">${item.alvo}</div>
        </div>
        `
        $("#list-items").append(html)
    
        setTimeout(() => {
            $('#list-items .item').first().remove();
        }, 5000)
	})
});