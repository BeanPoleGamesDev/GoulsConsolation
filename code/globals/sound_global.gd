extends Node


@onready var rock_break: AudioStreamPlayer = $rock_break
@onready var helicopter: AudioStreamPlayer = $helicopter
@onready var siren: AudioStreamPlayer = $siren
@onready var explosion: AudioStreamPlayer = $explosion
@onready var music_player: AudioStreamPlayer = $music_player

var single_play = true

#func _ready() -> void:
	#if single_play:
		#music_player.play()
		#single_play = false

func play_explosion():
	explosion.play()

func play_helicopter():
	helicopter.play()

func play_siren():
	#siren.play()
	pass

func play_rock_break():
	rock_break.play()
