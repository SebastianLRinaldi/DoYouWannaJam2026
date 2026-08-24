extends Node2D


@onready var music_player: AudioStreamPlayer2D = %MusicPlayer


func _ready() -> void:
	music_player.play()
	#music_player.bus = "amb"


func change_pitch(new_pitch:float):
	music_player.pitch_scale = new_pitch



func change_music(new_music: AudioStream):
	if music_player.stream == new_music:
		return

	var tween = create_tween()

	# Fade out current music
	tween.tween_property(music_player, "volume_db", -40, 0.2)

	await tween.finished

	# Change track
	music_player.stream = new_music
	music_player.play()
	# Fade in new music
	tween = create_tween()
	tween.tween_property(music_player, "volume_db", 0, 0.2)


func _on_music_player_finished() -> void:
	print("Finished Music")
	music_player.play()
