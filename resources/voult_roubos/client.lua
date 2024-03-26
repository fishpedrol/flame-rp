local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vSERVER = Tunnel.getInterface("Roubos")

fishbolcat = {}
Tunnel.bindInterface("Roubos", fishbolcat)
---------------------------------------------------------------------------------------------------------
-- CONFIG
---------------------------------------------------------------------------------------------------------
local Config = {
    ['Loja China'] = { -- Nome do estabelecimento
        ['x'] = -709.38, ['y'] = -904.17, ['z'] = 19.22, ['h'] = 85.48, -- Posição 2549.26,384.78,108.63
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(110000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'LojaChina', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Loja Barragem'] = { -- Nome do estabelecimento
        ['x'] = 1159.49, ['y'] = -314.0, ['z'] = 69.21, ['h'] = 101.47, -- Posição 1159.58,-314.14,69.21
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(110000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'LojaBarragem', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Loja Keke'] = { -- Nome do estabelecimento
        ['x'] = -43.24, ['y'] = -1748.5, ['z'] = 29.43, ['h'] = 89.02, -- Posição -709.68,-904.07,19.22
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(110000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Loja Keke', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Loja Norte'] = { -- Nome do estabelecimento
        ['x'] = 546.27, ['y'] = 2662.84, ['z'] = 42.16, ['h'] = 89.02, -- Posição -709.68,-904.07,19.22
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(110000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Loja Norte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Bebidas Samir'] = { -- Nome do estabelecimento
        ['x'] = 1126.86, ['y'] = -980.08, ['z'] = 45.42, ['h'] = 168.66, -- Posição -2959.59,387.15,14.05
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(50000,140000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Bebidas Samir', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Bebidas Norte'] = { -- Nome do estabelecimento
        ['x'] = 1169.24, ['y'] = 2717.79, ['z'] = 37.16, ['h'] = 8.67, -- Posição 1126.87,-980.14,45.42
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(50000,140000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Bebidas Norte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Bebidas Life'] = { -- Nome do estabelecimento
        ['x'] = -1479.13, ['y'] = -375.43, ['z'] = 39.17, ['h'] = 266.23, -- Posição 1169.3,2717.75,37.16
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(50000,140000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Bebidas Life', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Ammunation Praca'] = { -- Nome do estabelecimento
        ['x'] = 17.46, ['y'] = -1108.42, ['z'] = 29.8, ['h'] = 225.96, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(40000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AmuPraca', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 0,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 1,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Ammunation Porto'] = { -- Nome do estabelecimento
        ['x'] = 814.02, ['y'] = -2154.83, ['z'] = 29.62, ['h'] = 228.74, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(40000,90000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AmuPorto', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 1,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 1,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Teatro'] = { -- Nome do estabelecimento
        ['x'] = -1117.16, ['y'] = -503.12, ['z'] = 35.81, ['h'] = 119.74, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(120000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Teatro', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 8,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Prefeitura'] = { -- Nome do estabelecimento
        ['x'] = 2468.95, ['y'] = -419.91, ['z'] = 93.4, ['h'] = 86.55, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(120000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Prefeitura', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Porto'] = { -- Nome do estabelecimento
        ['x'] = 247.69, ['y'] = -3315.71, ['z'] = 5.8, ['h'] = 2.56, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(50000,310000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Porto', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Iate'] = { -- Nome do estabelecimento
        ['x'] = -2124.79, ['y'] = -1005.02, ['z'] = 8.58, ['h'] = 2.56, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(50000,310000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Iate', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Celeiro'] = { -- Nome do estabelecimento
        ['x'] = 1459.92, ['y'] = 1133.96, ['z'] = 114.33, ['h'] = 128.29, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(140000,210000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Fazenda', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Observatório'] = { -- Nome do estabelecimento
        ['x'] = 717.6, ['y'] = 565.57, ['z'] = 129.23, ['h'] = 254.06, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(250000,450000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Observatorio', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Moto club do Norte'] = { -- Nome do estabelecimento
        ['x'] = 66.61, ['y'] = 3726.71, ['z'] = 39.72, ['h'] = 355.86, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(200000,400000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'McNorte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'norte'
    },
    ['Moto club do Sul'] = { -- Nome do estabelecimento
        ['x'] = 978.63, ['y'] = -91.92, ['z'] = 74.85, ['h'] = 355.86, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(200000,400000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'McSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Aeroporto Abandonado'] = { -- Nome do estabelecimento
        ['x'] = 2403.72, ['y'] = 3128.07, ['z'] = 48.16, ['h'] = 355.86, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(100000,150000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AeroAbandonado', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 5,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Industria'] = { -- Nome do estabelecimento
        ['x'] = 2748.32, ['y'] = 1453.84, ['z'] = 24.5, ['h'] = 355.86, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(100000,150000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Industria', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 8,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Vinhedo'] = { -- Nome do estabelecimento
        ['x'] = -1886.55, ['y'] = 2050.35, ['z'] = 140.99, ['h'] = 355.86, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(80000,100000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Vinhedo', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Galpão'] = { -- Nome do estabelecimento
        ['x'] =  589.5, ['y'] = -468.68, ['z'] = 24.75, ['h'] = 355.86, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(180000,230000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Galpao', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 8,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Joalheria'] = { -- Nome do estabelecimento
        ['x'] = -631.37, ['y'] = -230.1, ['z'] = 38.06, ['h'] = 212.57, -- Posição -631.37,-230.1,38.06
        ['TempoRoubo'] = 200,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(400000,600000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Joalheria', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 5000,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = 'pendrive', -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 12,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 14,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Açougue do Sul'] = { -- Nome do estabelecimento
        ['x'] = 968.74, ['y'] = -2160.42, ['z'] = 29.48, ['h'] = 79.52, -- Posição 968.74,-2160.42,29.48
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(200000,350000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AçougueSul', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 8,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Trevor'] = { -- Nome do estabelecimento
        ['x'] = 1700.93, ['y'] = 3293.71, ['z'] = 48.93, ['h'] = 298.85, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(150000,280000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'AeroTrevor', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 300,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Resort'] = { -- Nome do estabelecimento
        ['x'] = -2953.17, ['y'] = 49.19, ['z'] = 11.61, ['h'] = 155.99, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(150000,280000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Resort', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 300,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Zancudo'] = { -- Nome do estabelecimento
        ['x'] = -2357.13, ['y'] = 3251.32, ['z'] = 101.46, ['h'] = 149.3, -- Posição
        ['TempoRoubo'] = 200,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(500000,1500000),   -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Zancudo', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 5000,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 50,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 17,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Niobio'] = { -- Nome do estabelecimento
        ['x'] = 3536.93, ['y'] = 3668.57, ['z'] = 28.13, ['h'] = 353.41, -- Posição
        ['TempoRoubo'] = 200,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(3500000,4000000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Niobio', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 5000,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 15,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 17,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['DP de Paleto'] = { -- Nome do estabelecimento
        ['x'] = -450.81, ['y'] = 6011.2, ['z'] = 31.72, ['h'] = 135.86, -- Posição -450.81,6011.2,31.72
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(180000,310000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'DelegaciaNorte', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Yellow'] = { -- Nome do estabelecimento
        ['x'] = 1982.39, ['y'] = 3053.46, ['z'] = 47.22, ['h'] = 60.72, -- Posição 1982.39,3053.46,47.22
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(150000,180000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Yellow', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Comedy Club'] = { -- Nome do estabelecimento 
        ['x'] = -424.62, ['y'] = 284.1, ['z'] = 83.2, ['h'] = 82.21, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(111263,234857), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'ComedyClub', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul'
    },
    ['Pier'] = { -- Nome do estabelecimento 
        ['x'] = -1645.59, ['y'] = -1078.5, ['z'] = 13.16, ['h'] = 70.45, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(182936,280805), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Pier', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['DP Sandy Shores'] = { -- Nome do estabelecimento 
        ['x'] = 1849.94, ['y'] = 3686.25, ['z'] = 34.27, ['h'] = 140.99, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(139603,217888), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'DelegaciaSandy', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 1108,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Fleeca Bank Highway'] = { -- Nome do estabelecimento 
        ['x'] = -2956.37, ['y'] = 482.00, ['z'] = 15.69, ['h'] = 357.97, -- Posição
        ['TempoRoubo'] = 200,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(1200000,1350000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Fleeca', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 874,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = 'keycard',  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Fleeca Bank Center'] = { -- Nome do estabelecimento 
        ['x'] = 147.16, ['y'] = -1046.36, ['z'] = 29.36, ['h'] = 247.07, -- Posição
        ['TempoRoubo'] = 200,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(1200000,1350000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Fleeca', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 874,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = 'keycard',  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Fleeca Bank Top'] = { -- Nome do estabelecimento 
        ['x'] = -1210.38, ['y'] = -336.55, ['z'] = 37.79, ['h'] = 297.11, -- Posição
        ['TempoRoubo'] = 200,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(1200000,1350000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Fleeca', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 874,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = 'keycard',  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Fleeca Bank Paleto'] = { -- Nome do estabelecimento 
        ['x'] = -104.0, ['y'] = 6477.61, ['z'] = 31.63, ['h'] = 137.43, -- Posição
        ['TempoRoubo'] = 200,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(1200000,1350000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Fleeca', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 874,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = 'keycard',  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Banco Central'] = { -- Nome do estabelecimento 
        ['x'] = 264.48, ['y'] = 219.81, ['z'] = 101.69, ['h'] = 288.85, -- Posição
        ['TempoRoubo'] = 200,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(1900000,2500000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Central', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 5000,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = 'keycard',  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 12,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 13, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Rebel'] = { -- Nome do estabelecimento 
        ['x'] = 849.32, ['y'] = 2383.65, ['z'] = 54.16, ['h'] = 264.02, -- Posição
        ['TempoRoubo'] = 60,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(500000,1500000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Rebel', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 2500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Estabulo'] = { -- Nome do estabelecimento 
        ['x'] = 1219.85, ['y'] = 333.3, ['z'] = 82.0, ['h'] = 291.57, -- Posição
        ['TempoRoubo'] = 40, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(141852,222725), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Estabulo', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Posto Crips'] = { -- Nome do estabelecimento 
    	['x'] = 1200.38, ['y'] = -1277.13, ['z'] = 35.38, ['h'] = 169.99, -- Posição
    	['TempoRoubo'] = 45, -- Tempo que demorará pra terminar o roubo 
    	['Recompensa'] = math.random(170626,271194), -- Recompensa de dinheiro sujo no roubo
    	['TipoCooldown'] = 'Posto Crips', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
    	['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
    	['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
    	['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
    	['MaxPoliciais'] = 7, 
    	['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
    	['Prioridade'] = 'sul' 
    },
    ['Mini Fazenda '] = { -- Nome do estabelecimento 
        ['x'] = 791.53, ['y'] = 2176.45, ['z'] = 52.64, ['h'] = 146.71, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(163482,243143), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Mini Fazenda', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Auditorio'] = { -- Nome do estabelecimento 
        ['x'] = 185.03, ['y'] = 1214.12, ['z'] = 225.6, ['h'] = 24.83, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(114969,209352), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Auditorio', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Rua sem saida'] = { -- Nome do estabelecimento 
        ['x'] = 1373.04, ['y'] = -569.0, ['z'] = 74.18, ['h'] = 290.13, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(106177,264204), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Rua sem saida', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Mecanica Abandonada'] = { -- Nome do estabelecimento 
        ['x'] = -1142.26, ['y'] = -1992.97, ['z'] = 13.17, ['h'] = 140.35, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(187504,284977), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Mecanica Abandonada', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 5, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Mansão da Playboy'] = { -- Nome do estabelecimento 
        ['x'] = -1537.18, ['y'] = 130.9, ['z'] = 57.38, ['h'] = 303.39, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(158582,202581), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Mansão da Playboy', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Trailer Magic'] = { -- Nome do estabelecimento 
        ['x'] = 2336.14, ['y'] = 2566.63, ['z'] = 47.73, ['h'] = 64.79, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(145258,266262), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Trailer Magic', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 5, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Auto Parts'] = { -- Nome do estabelecimento 
        ['x'] = 820.37, ['y'] = -808.43, ['z'] = 26.4, ['h'] = 78.7, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(144431,230709), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Auto Parts', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 3,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 4, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    }, 
    ['Festa Junina'] = { -- Nome do estabelecimento 
        ['x'] = 376.1, ['y'] = -347.01, ['z'] = 46.67, ['h'] = 84.98, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(136230,245442), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Festa Junina', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 3,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 4, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Planet'] = { -- Nome do estabelecimento 
        ['x'] = -700.61, ['y'] = -1142.68, ['z'] = 10.82, ['h'] = 217.55, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(160810,281063), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Planet', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Campo De Golf'] = { -- Nome do estabelecimento 
        ['x'] = -1345.02, ['y'] = 47.12, ['z'] = 55.25, ['h'] = 83.94, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(139040,246209), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Campo De Golf', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Departamento De Cargas'] = { -- Nome do estabelecimento 
        ['x'] = 1240.19, ['y'] = -3322.24, ['z'] = 6.03, ['h'] = 85.61, -- Posição  
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(118990,255160), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Departamento De Cargas', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 8, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Cemitério'] = { -- Nome do estabelecimento 
        ['x'] = -1685.26, ['y'] = -291.73, ['z'] = 51.9, ['h'] = 311.72, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(168404,217932), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Cemitério', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 5, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Mini Porto'] = { -- Nome do estabelecimento 
        ['x'] = -416.65, ['y'] = -2763.19, ['z'] = 6.01, ['h'] = 13.87, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(186037,215982), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Mini Porto', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Durgant Storage'] = { -- Nome do estabelecimento 
        ['x'] = 474.64, ['y'] = -1952.18, ['z'] = 24.63, ['h'] = 300.09, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(169645,271346), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Durgant Storage', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Hipermercado'] = { -- Nome do estabelecimento 
        ['x'] = 1082.5, ['y'] = -787.45, ['z'] = 58.36, ['h'] = 18.52,
        ['TempoRoubo'] = 100,  -- 
        ['Recompensa'] = math.random(110000,180000),
        ['TipoCooldown'] = 'Hiper Mercado',
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 4,
        ['MaxPoliciais'] = 5,
        ['PermDosPm'] = 'policia.permissao', 
        ['Prioridade'] = 'sul'
    },
    ['Korean Plazza'] = { -- Nome do estabelecimento 
        ['x'] = -566.68, ['y'] = -1071.46, ['z'] = 22.33, ['h'] = 359.74, -- Posição
        ['TempoRoubo'] = 45, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(178564,287649), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Korean Plazza', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Fleeca Bank Samir'] = { -- Nome do estabelecimento 
        ['x'] = 311.28, ['y'] = -284.34, ['z'] = 54.17, ['h'] = 52.07, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(1200000,1350000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Fleeca', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = 'keycard',  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Fleeca Bank Rockford'] = { -- Nome do estabelecimento 
        ['x'] = -353.81, ['y'] = -55.18, ['z'] = 49.04, ['h'] = 57.41, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(1200000,1350000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Fleeca', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = 'keycard',  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Fleeca Bank Sandy Shores'] = { -- Nome do estabelecimento 
        ['x'] = 1175.95, ['y'] = 2712.81, ['z'] = 38.09, ['h'] = 257.11, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(1200000,1350000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Fleeca', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = 'keycard',  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['trunk'] = { -- Nome do estabelecimento 
        ['x'] = -324.34, ['y'] = -1356.11, ['z'] = 31.3, ['h'] = 262.79, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(159895,200063), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'trunk', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Containers'] = { -- Nome do estabelecimento 
        ['x'] = 1167.4, ['y'] = -2980.32, ['z'] = 5.91, ['h'] = 359.70, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(500000,600000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Containers', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Antena old'] = { -- Nome do estabelecimento 
        ['x'] = 780.73, ['y'] = 1296.68, ['z'] = 361.37, ['h'] = 93.56, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(138444,275235), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Antena old', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Quadra De Tenis'] = { -- Nome do estabelecimento 
        ['x'] = -1351.85, ['y'] = -128.65, ['z'] = 50.12, ['h'] = 170.75, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(129679,240693), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Quadra De Tenis', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Motelgreja'] = { -- Nome do estabelecimento 
        ['x'] = 566.53, ['y'] = -1750.37, ['z'] = 29.29, ['h'] = 162.19, -- Posição 2549.26,384.78,108.63
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(120000,170000),  -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Motelgreja', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil, -- Item necessário pra iniciar o roubo, nil = não precisa de item
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial
        ['Prioridade'] = 'sul'
    },
    ['Bombeiro'] = { -- Nome do estabelecimento 
        ['x'] = 210.05, ['y'] = -1656.84, ['z'] = 29.81, ['h'] = 42.3, -- Posição
        ['TempoRoubo'] = 45, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(108368,217572), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Bombeiro', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 5, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Armazem de Sandy'] = { -- Nome do estabelecimento 
        ['x'] = 2454.71, ['y'] = 4069.06, ['z'] = 38.07, ['h'] = 333.38, -- Posição
        ['TempoRoubo'] = 45, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(111332,212988), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Armazem de Sandy', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Plaza'] = { -- Nome do estabelecimento 
        ['x'] = -3169.74, ['y'] = 1033.76, ['z'] = 20.84, ['h'] = 250.84, -- Posição
        ['TempoRoubo'] = 45, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(183400,200969), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Plaza', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 6,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Fast Food'] = { -- Nome do estabelecimento 
        ['x'] = 1241.55, ['y'] = -367.21, ['z'] = 69.09, ['h'] = 351.88, -- Posição
        ['TempoRoubo'] = 70, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(161818,217589), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Fast Food', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 3,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 4, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Peixaria'] = { -- Nome do estabelecimento 
        ['x'] = -1039.12, ['y'] = -1353.37, ['z'] = 5.56, ['h'] = 201.09, -- Posição
        ['TempoRoubo'] = 45, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(116957,215515), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Peixaria ', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['QG'] = { -- Nome do estabelecimento 
        ['x'] = -600.97, ['y'] = -1618.81, ['z'] = 33.02, ['h'] = 350.94, -- Posição
        ['TempoRoubo'] = 90, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(104032,253957), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'QG', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 10,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 15, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Construcao'] = { -- Nome do estabelecimento 
        ['x'] = 140.85, ['y'] = -379.49, ['z'] = 43.26, ['h'] = 253.5, -- Posição
        ['TempoRoubo'] = 45, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(500000,1500000), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Construcao', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 9,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10,
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Up-n-Atom'] = { -- Nome do estabelecimento 
        ['x'] = 81.33, ['y'] = 275.11, ['z'] = 110.22, ['h'] = 34.16, -- Posição
        ['TempoRoubo'] = 45, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(125837,208717), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Up-n-Atom', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 3,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 4, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul'  
    },
    ['Pedreira'] = { -- Nome do estabelecimento 
        ['x'] = 287.85, ['y'] = 2843.6, ['z'] = 44.71, ['h'] = 292.56, -- Posição
        ['TempoRoubo'] = 45, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(114364,252866), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Pedreira', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 9, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul'
    },
    ['Caseys'] = { -- Nome do estabelecimento 
        ['x'] = 810.36, ['y'] = -749.95, ['z'] = 26.73, ['h'] = 82.9, -- Posição
        ['TempoRoubo'] = 45, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(155824,264811), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Caseys', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 3,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 4, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Coconut Coffe'] = { -- Nome do estabelecimento 
        ['x'] = -1110.83, ['y'] = -1454.48, ['z'] = 5.59, ['h'] = 117.51, -- Posição
        ['TempoRoubo'] = 45, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(143954,214680), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Coconut Coffe', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 5, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Spit Roasters'] = { -- Nome do estabelecimento 
    ['x'] = -231.79, ['y'] = 289.76, ['z'] = 92.06, ['h'] = 124.94, -- Posição
        ['TempoRoubo'] = 45, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(108239,285318), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Spit Roasters', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 3,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 4, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
         ['Prioridade'] = 'sul' 
    },
    ['Gas Company'] = { -- Nome do estabelecimento 
        ['x'] = 580.42, ['y'] = -2285.36, ['z'] = 6.4, ['h'] = 355.45, -- Posição
        ['TempoRoubo'] = 45, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(126996,276559), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Gas Company', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 8,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 10, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Village'] = { -- Nome do estabelecimento 
        ['x'] = 451.72, ['y'] = -1569.4, ['z'] = 29.29, ['h'] = 322.94, -- Posição
        ['TempoRoubo'] = 45, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(162790,258258), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Village', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 5,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 7, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Big House'] = { -- Nome do estabelecimento 
        ['x'] = -521.51, ['y'] = -2197.19, ['z'] = 6.4, ['h'] = 122.69, -- Posição
        ['TempoRoubo'] = 45, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(118188,259508), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'BigHouse', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 7,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 8, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Atomic'] = { -- Nome do estabelecimento 
        ['x'] = 484.38, ['y'] = -1876.45, ['z'] = 26.13, ['h'] = 113.57, -- Posição
        ['TempoRoubo'] = 45, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(150913,220377), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Atomic', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 3,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 5, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['HiMen'] = { -- Nome do estabelecimento 
        ['x'] = 485.64, ['y'] = -1529.18, ['z'] = 29.29, ['h'] = 227.24, -- Posição
        ['TempoRoubo'] = 45, -- Tempo que demorará pra terminar o roubo 
        ['Recompensa'] = math.random(133618,220547), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'HiMen', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 5, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Aeroporto'] = { -- Nome do estabelecimento 
        ['x'] = -1233.44, ['y'] = -2811.2, ['z'] = 13.96, ['h'] = 273.78, -- Posição
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(107635,280003), -- Recompensa de dinheiro sujo no roubo
        ['TipoCooldown'] = 'Aeroporto', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 25,  -- Mínimo de policiais em serviço pra iniciar o roubo
        ['MaxPoliciais'] = 25, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },  
    ['Lixao abandonado'] = { -- Nome do estabelecimento 
        ['x'] = 2040.93, ['y'] = 3186.44, ['z'] = 45.22, ['h'] = 191.97, -- Posição  
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(60250,90300), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Lixao abandonado', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Pensao'] = { -- Nome do estabelecimento 
        ['x'] = 773.59, ['y'] = -150.38, ['z'] = 75.63, ['h'] = 191.97, -- Posição  
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(60250,90300), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Pensao', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Giovannis'] = { -- Nome do estabelecimento 
        ['x'] = -1342.46, ['y'] = -871.83, ['z'] = 16.86, ['h'] = 191.97, -- Posição  
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(60250,90300), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Giovannis', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Panacho'] = { -- Nome do estabelecimento 
        ['x'] = -1411.16, ['y'] = -385.8, ['z'] = 36.65, ['h'] = 191.97, -- Posição  
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(60250,90300), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Panacho', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['SPG'] = { -- Nome do estabelecimento 
        ['x'] = 161.02, ['y'] = 172.77, ['z'] = 105.92, ['h'] = 191.97, -- Posição  
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(60250,90300), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'SPG', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Auto Exotic'] = { -- Nome do estabelecimento 
        ['x'] = 539.99, ['y'] = -196.74, ['z'] = 54.49, ['h'] = 191.97, -- Posição  
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(60250,90300), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Auto Exotic', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Taxista'] = { -- Nome do estabelecimento 
        ['x'] = 895.43, ['y'] = -179.49, ['z'] = 74.71, ['h'] = 191.97, -- Posição  
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(60250,90300), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Taxista', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Ronnies'] = { -- Nome do estabelecimento 
        ['x'] = 170.56, ['y'] = -1723.51, ['z'] = 29.4, ['h'] = 191.97, -- Posição  
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(60250,90300), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Ronnies', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Suez'] = { -- Nome do estabelecimento 
        ['x'] = 369.72, ['y'] = -2452.3, ['z'] = 6.31, ['h'] = 191.97, -- Posição  
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(60250,90300), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Suez', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Reestroom'] = { -- Nome do estabelecimento 
        ['x'] = 813.05, ['y'] = -280.6, ['z'] = 66.47, ['h'] = 191.97, -- Posição  
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(60250,90300), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Reestroom', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Apartamento'] = { -- Nome do estabelecimento 
        ['x'] = -98.73, ['y'] = 366.93, ['z'] = 113.28, ['h'] = 191.97, -- Posição  
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(60250,90300), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Apartamento', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Muffler'] = { -- Nome do estabelecimento 
        ['x'] = -81.63, ['y'] = -1326.02, ['z'] = 29.27, ['h'] = 191.97, -- Posição  
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(60250,90300), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Muffler', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Kaliclub'] = { -- Nome do estabelecimento 
        ['x'] = 1096.52, ['y'] = 74.61, ['z'] = 80.9, -- Posição  
        ['TempoRoubo'] = 45,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(60250,90300), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Kali Club', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 4,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 6, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Wigwam'] = { -- Nome do estabelecimento 
        ['x'] = -861.06, ['y'] = -1141.2, ['z'] = 7.0, -- Posição  
        ['TempoRoubo'] = 20,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(60250,90300), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Wigwam', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 3,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 4, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Vespucci'] = { -- Nome do estabelecimento 
        ['x'] = -1106.03, ['y'] = -1287.92, ['z'] = 5.43, -- Posição  
        ['TempoRoubo'] = 20,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(60250,90300), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Vespucci', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 3,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 4, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
    ['Vespucci'] = { -- Nome do estabelecimento 
        ['x'] = -1079.62, ['y'] = -2242.53, ['z'] = 13.23, -- Posição  
        ['TempoRoubo'] = 20,  -- Tempo que demorará pra terminar o roubo
        ['Recompensa'] = math.random(60250,90300), -- Recompensa de dinheiro sujo no roubo  
        ['TipoCooldown'] = 'Vespucci', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN 
        ['Cooldown'] = 500,  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  
        ['ItemReq'] = nil,  -- Item necessário pra iniciar o roubo, nil = não precisa de item 
        ['MinPoliciais'] = 10,  -- Mínimo de policiais em serviço pra iniciar o roubo  
        ['MaxPoliciais'] = 12, 
        ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial 
        ['Prioridade'] = 'sul' 
    },
}
---------------------------------------------------------------------------------------------------------
-- CÓDIGO
---------------------------------------------------------------------------------------------------------
local Roubando = false
local TempoRoubando = 0
local Recompensa = 0
local DelayPuxar = 0
local Estabelecimento = ''

Citizen.CreateThread(function() 
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        if not Roubando then
            for k , v in pairs(Config) do
                local dist = Vdist2(pedCoords, v.x, v.y, v.z)
                if dist < 10 then
                    timeDistance = 4
                    DrawMarker(20, v.x, v.y, v.z, 0, 0, 0, 180.0, 0, 0, 0.15, 0.15, 0.15, 1,130,221,150, 1, 0, 0, 1)
                    if dist < 1.5 then
                        DrawText3Ds(v.x, v.y, v.z, '~w~APERTE ~b~[E] ~w~PARA ROUBAR')
                        if IsControlJustPressed(0,38) then
                            if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then
                                if DelayPuxar <= 0 then
                                    if not vRP.getNearestPlayer(4) then
                                       -- TriggerEvent('Notify', 'aviso', 'AVISO!', 'Tentando assaltar, aguarde...')
                                        DelayPuxar = math.random(10,45)

                                        if vSERVER.CheckCooldown(v.TipoCooldown, v.Cooldown, v.ItemReq, v.MinPoliciais, v.PermDosPm, k, v.x, v.y, v.z,v.MaxPoliciais, v.Prioridade) then
                                            FreezeEntityPosition(ped, true)
                                            Roubando = true
                                            TempoRoubando = v.TempoRoubo
                                            Recompensa = v.Recompensa
                                            Estabelecimento = k
                                            SetEntityHeading(ped, v.h)
                                        end
                                    else
                                        TriggerEvent('Notify', 'negado', 'Não pode haver mais de uma pessoa próxima ao roubo.')
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            
            if Roubando and TempoRoubando <= 0 then
                vSERVER.sexodeanao(Estabelecimento, Recompensa)
                TempoRoubando = 0 
                Roubando = false
                Recompensa = 0
                Estabelecimento = ''
                FreezeEntityPosition(ped, false)
                ClearPedTasks(ped)
                TriggerEvent('Notify', 'sucesso' ,'O <b>assalto</b> foi <b>concluído</b>.')
            end

        end

        if TempoRoubando > 0 then
            timeDistance = 4
            drawTxt('~w~FALTAM ~b~' .. TempoRoubando .. ' ~w~SEGUNDO(S) PARA FINALIZAR', 4,0.5,0.93,0.45,255,255,255,80)
            drawTxt('~w~APERTE F7 PARA CANCELAR', 4,0.5,0.96,0.45,255,255,255,80)

            if IsControlJustPressed(0,168) or not IsEntityPlayingAnim(ped,"anim@heists@ornate_bank@grab_cash", "grab",3) then
            --if IsControlJustPressed(0,168) or not IsEntityPlayingAnim(ped,"oddjobs@shop_robbery@rob_till", "loop",3) then
                TempoRoubando = 0
                Roubando = false
                Recompensa = 0
                Estabelecimento = ''
                FreezeEntityPosition(ped, false)
                ClearPedTasks(ped)
                TriggerEvent('Notify', 'negado' , 'O <b>assalto</b> foi <b>cancelado</b>.')
            end

        end
        Citizen.Wait(timeDistance)
    end
end)

Citizen.CreateThread(function()
    local innerTable = {}
    for k,v in pairs(Config) do
        table.insert(innerTable,{ v["x"],v["y"],v["z"],2,"E","Assalto","Pressione para abrir" })
    end

    TriggerEvent("hoverfy:insertTable",innerTable)
end)

Citizen.CreateThread(function() 
    while true do
        Wait(1000)
        if Roubando then
            if TempoRoubando > 0 then
                TempoRoubando = TempoRoubando - 1
            end
        end

        if DelayPuxar > 0 then
            DelayPuxar = DelayPuxar - 1
        end
    end
end)

function fishbolcat.SetMochila()
    SetPedComponentVariation(GetPlayerPed(-1),5,21,0,2)
	SetCurrentPedWeapon(GetPlayerPed(-1),GetHashKey("WEAPON_UNARMED"),true)
end
---------------------------------------------------------------------------------------------------------
-- FUNCOES
---------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(6)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end
--[[ 
	/ROUBOS 
	]]

    local blips = {}
    local roubos = false
    RegisterCommand("roubos",function(source, args)
            roubos = not roubos
            if roubos then
                TriggerEvent("Notify", "sucesso", "Adicionado a marcação dos roubos.")
                for k, v in pairs(Config) do
                    blips[k] = AddBlipForCoord(v["x"], v["y"], v["z"])
                    SetBlipSprite(blips[k], 310)
                    SetBlipAsShortRange(blips[k], true)
                    SetBlipColour(blips[k], 4)
                    SetBlipScale(blips[k], 0.5)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("~t~<b>ROUBO:</b> ~w~" .. v["TipoCooldown"])
                    EndTextCommandSetBlipName(blips[k])
                end
            else
                TriggerEvent("Notify", "aviso", "Removido a marcação dos roubos.")
                for k, v in pairs(blips) do
                    if DoesBlipExist(v) then
                        RemoveBlip(v)
                    end
                end
            end
        end
    )