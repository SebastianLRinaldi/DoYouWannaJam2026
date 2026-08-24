extends Node2D


func _on_next_screen_pressed() -> void:
	LevelTransition.change_scene_to("res://main_menu/main_menu.tscn")

func _on_pre_screen_pressed() -> void:
	LevelTransition.change_scene_to("res://tutorial_2.tscn")
