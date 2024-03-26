local cfg = {}

cfg.groups = {
	["ceo"] = {
		_config = {
			title = "CEO",
			gtype = "jobdois" 
		},
		"staff.permissao",
		"ceoon.permissao",
		"adm.permissao",
		"suporte.permissao",
		"mod.permissao",
		"imunidade.permissao",
		"cm.permissao",
		"ceo.permissao",
		"influencer.permissao",
		"player.blips",
		"player.noclip",
		"player.teleport",
		"player.secret",
		"imunidade.permissao",
		"prop.permissao",
		"wall.permissao"
	},
	["cmn"] = {
		_config = {
			title = "Community Manager",
			gtype = "jobdois"
		},
		"ceo.permissao",
		"cm.permissao",
		"adm.permissao",
		"cmon.permissao",
		"staff.permissao",
		"suporte.permissao",
		"mod.permissao",
		"influencer.permissao",
		"ban.permissao",
		"player.blips",
		"player.noclip",
		"player.teleport",
		"player.secret",
		"imunidade.permissao",
		"prop.permissao",
		"wall.permissao"
	},
	["adm"] = {
		_config = {
			title = "Administrador",
			gtype = "jobdois"
		},
		"adm.permissao",
		"staff.permissao",
		"suporte.permissao",
		"admon.permissao",
		"mod.permissao",
		"influencer.permissao",
		"ban.permissao",
		"player.blips",
		"player.noclip",
		"player.teleport",
		"player.secret",
		"imunidade.permissao",
		"prop.permissao",
		"wall.permissao"
	},
	["mod"] = {
		_config = {
			title = "Moderador",
			gtype = "jobdois"
		},
		"suporte.permissao",
		"mod.permissao",
		"modon.permissao",
		"staff.permissao",
		"influencer.permissao",
		"ban.permissao",
		"imunidade.permissao",
		"player.blips",
		"player.noclip",
		"player.teleport",
		"player.secret",
		"imunidade.permissao",
		"prop.permissao",
		"wall.permissao"
	},
	["sup"] = {
		_config = {
			title = "Support",
			gtype = "jobdois"
		},
		"suporte.permissao",
		"staff.permissao",
		"influencer.permissao",
		"ban.permissao",
		"supon.permissao",
		"imunidade.permissao",
		"player.blips",
		"player.noclip",
		"player.teleport",
		"player.secret",
		"imunidade.permissao",
		"prop.permissao",
		"wall.permissao"
	},
	["Streamer"] = {
		_config = {
			title = "Streamer",
			gtype = "jobdois"
		},
		"streamer.permissao",
		"player.noclip",
		"player.teleport"
	},
	["Aprovador"] = {
		_config = {
			title = "Approver",
			gtype = "jobdois"
		},
		"aprovador.permissao"
	},	
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAGS POLICIA
-----------------------------------------------------------------------------------------------------------------------------------------
	["policia"] = {
		_config = {
			title = "Policia",
			gtype = "job"
		},
		"policia.permissao",
		"policiasaque.permissao",
		"player.blips",
		"policiasv.permissao"
	},
	["policiaacao"] = {
		_config = {
			title = "Policia Ação",
			gtype = "job"
		},
		"policiaacao.permissao",
		"mochila.permissao",
		"policiasaque.permissao",
		"player.blips",
		"policiasv.permissao"
	},
	["paisanapolicia"] = {
		_config = {
			title = "Paisana Policia",
			gtype = "job"
		},
		"paisanapolicia.permissao",
		"policiasaque.permissao",
		"player.blips",
	},
	["Paramedico"] = {
		_config = {
			title = "Hospital",
			gtype = "job"
		},
		"paramedico.permissao",
		"polpar.permissao",
		"sem.permissao",
		"player.blips",
	}, 	
	["PaisanaParamedico"] = {
		_config = {
			title = "PaisanaParamedico",
			gtype = "job"
		},
		"paisanaparamedico.permissao",
		"sem.permissao",
		"player.blips",
	},
	["Mecanico"] = {
		_config = {
			title = "Mecanico",
			gtype = "job"
		},
		"mecanico.permissao",
		"sem.permissao",
	},
	["PaisanaMecanico"] = {
		_config = {
			title = "PaisanaMecanico",
			gtype = "job"
		},
		"paisanamecanico.permissao"
	},
	["Taxista"] = {
		"taxista.permissao",
		"sem.permissao"
	},
	["PaisanaTaxista"] = {
		"paisanataxista.permissao",
		"sem.permissao"
	},
	["policiagu"] = {
		_config = {
			title = "Investigative",
			gtype = "jobdois"
		},
		"policiagu.permissao",
	},
-----------------------------------------------------------------------------------------------------------------------------------------
-- VIPS
-----------------------------------------------------------------------------------------------------------------------------------------
	["FlameElite"] = {
		_config = {
			title = "Flame Elite",
			gtype = "vip"
		},
		"extreme.permissao",
		"mochila.permissao",
		"roupas.permissao",
		"attachs.permissao"
	},
	["Elite"] = {
		_config = {
			title = "Elite",
			gtype = "vip"
		},
		"ultimate.permissao",
		"mochila.permissao",
		"roupas.permissao",
		"attachs.permissao"
	},
	["Simples"] = {
		_config = {
			title = "Simples",
			gtype = "vip"
		},
		"master.permissao",
		"roupas.permissao",
		"attachs.permissao"
	},
	["Rental"] = {
		_config = {
			title = "Rental",
			gtype = "vip"
		},
		"rental.permissao",
		"attachs.permissao"
	},
	["Booster"] = {
		"booster.permissao",
		"sem.permissao",
		"attachs.permissao"
	},
-----------------------------------------------------------------------------------------------------------------------------------------
-- ORGANIZAÇÕES DE DROGAS
-----------------------------------------------------------------------------------------------------------------------------------------
	["Ballas"] = {
		_config = {
			title = "Ballas",
			gtype = "job"
		},
		"ballas.permissao",
		"droga.menu"
	},
	["Vagos"] = {
		_config = {
			title = "Vagos",
			gtype = "job"
		},
		"vagos.permissao",
		"droga.menu"
	},
	["groove"] = {
		_config = {
			title = "Families",
			gtype = "job"
		},
		"families.permissao",
		"droga.menu"
	},
	["NineThree"] = {
		_config = {
			title = "Nine Three",
			gtype = "job"
		},
		"ninethree.permissao",
		"drogas.permissao"
	},
-----------------------------------------------------------------------------------------------------------------------------------------
-- ORGANIZAÇÕES DE ARMAS
-----------------------------------------------------------------------------------------------------------------------------------------
	["Crips"] = {
		_config = {
			title = "Crips",
			gtype = "job"
		},
		"crips.permissao",
		"armas.permissao"
	},
	["Bloods"] = {
		_config = {
			title = "Bloods",
			gtype = "job"
		},
		"blood.permissao",
		"armas.permissao"
	},
-----------------------------------------------------------------------------------------------------------------------------------------
-- ORGANIZAÇÕES DE MUNIÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
	["Yardie"] = {
		_config = {
			title = "Yardie",
			gtype = "job"
		},
		"yardie.permissao",
		"municoes.permissao"
	},
	["Russkaya"] = {
		_config = {
			title = "Russkaya",
			gtype = "job"
		},
		"russkaya.permissao",
		"municoes.permissao"
	},
-----------------------------------------------------------------------------------------------------------------------------------------
-- ORGANIZAÇÕES DE LAVAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
	["Bahamas"] = {
		_config = {
			title = "Bahamas",
			gtype = "job"
		},
		"bahamas.permissao",
		"lavagem.permissao"
	},
	["LifeInvader"] = {
		_config = {
			title = "Life Invader",
			gtype = "job"
		},
		"lifeinvader.permissao",
		"lavagem.permissao"
	},
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESMANCHE
-----------------------------------------------------------------------------------------------------------------------------------------
	["Native"] = {
		_config = {
			title = "Native",
			gtype = "job"
		},
		"native.permissao",
		"ilegal.permissao"
	},
	["DriftKing"] = {
		_config = {
			title = "DriftKing",
			gtype = "job"
		},
		"driftking.permissao",
		"ilegal.permissao"
	},
	["Total"] = {
		_config = {
			title = "Total",
			gtype = "special"
		},
		"dev.permissao"
	},
}

cfg.users = {
	[-1] = { "ceo" },
	[1] = { "ceo" },
	[2] = { "ceo" },
	[3] = { "ceo" },
	[4] = { "ceo" },
	[5] = { "ceo" }
}

cfg.selectors = {}

return cfg