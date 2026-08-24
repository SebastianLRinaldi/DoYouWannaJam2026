extends Node2D


func _on_next_screen_pressed() -> void:
	MusicManager.play_sfx(0)
	LevelTransition.change_scene_to("res://tutorial_3.tscn")

func _on_pre_screen_pressed() -> void:
	MusicManager.play_sfx(0)
	LevelTransition.change_scene_to("res://tutorial_1.tscn")
