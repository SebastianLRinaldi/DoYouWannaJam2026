class_name  FailScreen
extends Node2D


@export_file("*.tscn") var retry_level_path

func _ready() -> void:
	hide()

func _on_retry_level_pressed() -> void:
	MusicManager.play_sfx(0)
	LevelTransition.change_scene_to(retry_level_path)


func _on_main_menu_pressed() -> void:
	MusicManager.play_sfx(0)
	LevelTransition.change_scene_to("res://main_menu/main_menu.tscn")
