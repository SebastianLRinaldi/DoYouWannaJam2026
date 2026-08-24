extends Node2D

func _on_start_pressed() -> void:
	LevelTransition.change_scene_to("res://seb_test/level_1.tscn")

func _on_tutorial_pressed() -> void:
	LevelTransition.change_scene_to("res://tutorial_1.tscn")
