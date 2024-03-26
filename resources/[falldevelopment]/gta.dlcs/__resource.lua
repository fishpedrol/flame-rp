

resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"
files {
	'audioconfig/r35sound_game.dat151.rel',
	'audioconfig/r35sound_sounds.dat54.rel',
	'sfx/dlc_r35sound/r35sound.awc',
	'sfx/dlc_r35sound/r35sound_npc.awc',
	'audioconfig/lfasound_game.dat151.rel',
	'audioconfig/lfasound_sounds.dat54.rel',
	'sfx/dlc_lfasound/lfasound.awc',
	'sfx/dlc_lfasound/lfasound_npc.awc',
	'audioconfig/m5cracklemod_game.dat151.rel',
	'audioconfig/m5cracklemod_sounds.dat54.rel',
	'sfx/dlc_m5cracklemod/m5cracklemod.awc',
	'sfx/dlc_m5cracklemod/m5cracklemod_npc.awc'
}
data_file 'AUDIO_GAMEDATA' 'audioconfig/r35sound_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/r35sound_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_r35sound'
data_file 'AUDIO_GAMEDATA' 'audioconfig/lfasound_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/lfasound_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_lfasound'
data_file 'AUDIO_GAMEDATA' 'audioconfig/m5cracklemod_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/m5cracklemod_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_m5cracklemod'
client_script {
    'vehicle_names.lua'
}