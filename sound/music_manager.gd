extends Node2D

@export var sfx: Array[AudioStream]

@onready var music_player: AudioStreamPlayer2D = %MusicPlayer
@onready var sfx_player: AudioStreamPlayer2D = %SFXPlayer

func _ready() -> void:
	start_music()

func start_music():
	var tween = create_tween()

	# Fade out current music
	tween.tween_property(music_player, "volume_db", -40, 0.2)

	await tween.finished

	# Change track
	music_player.play()
	# Fade in new music
	tween = create_tween()
	tween.tween_property(music_player, "volume_db", 0, 0.2)


func _on_music_player_finished() -> void:
	print("Finished Music")
	start_music()

func play_sfx(sfx_idx:int):
	sfx_player.stream = sfx[sfx_idx]
	sfx_player.play()
	
