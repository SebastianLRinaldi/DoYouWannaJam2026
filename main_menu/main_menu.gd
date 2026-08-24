extends Node2D

func _on_start_pressed() -> void:
	LevelTransition.change_scene_to("res://test_level_A.tscn")

func _on_tutorial_pressed() -> void:
	LevelTransition.change_scene_to("res://tutorial_1.tscn")
