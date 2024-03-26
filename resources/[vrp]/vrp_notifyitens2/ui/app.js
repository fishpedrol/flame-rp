$(document).ready(function(){
	window.addEventListener("message",function(event){
		var html = "";
		var name = event.data.name;
		var name2 = event.data.name2;
		var amount = event.data.amount;

		// if (NomeItem.indexOf('wbody')) { /* Munição? */

		// 	NomeItem = 'wammo'+NomeItem.slice(6);
		// } else if (NomeItem.indexOf('wammo')) { /* Corpo? */
		// 	NomeItem = 'wbody'+NomeItem.slice(6);
		// }

		if (event.data.mode == 'sucesso') {
			html = '<div class="fundo"><div class="fundofalso"><img src="nui://vrp_inventory/nui/images/'+name+'.png" alt=""></div><div class="fundoimg"></div><div class="texto"><span class="aviso" style="color: green;">ITEM RECEBIDO</span><br><span id="add">'+amount+'x '+name2+'</span>.</div></div><br><br><br><br>'
		}

		if (event.data.mode == 'negado') {			
			html = '<div class="fundo"><div class="fundofalso"><img src="nui://vrp_inventory/nui/images/'+name+'.png" alt=""></div><div class="fundoimg"></div><div class="texto"><span class="aviso" style="color: red;">ITEM REMOVIDO</span><br><span id="add">'+amount+'x '+name2+'</span>.</div></div><br><br><br><br>'

		}

		$(html).fadeIn(500).appendTo("#notifyitens").delay(5000).fadeOut(500);
	})
});