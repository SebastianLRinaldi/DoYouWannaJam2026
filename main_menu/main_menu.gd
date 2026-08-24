extends Node2D

@export_file("*.tscn") var first_level_path

func _on_start_pressed() -> void:
	LevelTransition.change_scene_to(first_level_path)

func _on_tutorial_pressed() -> void:
	LevelTransition.change_scene_to("res://tutorial_1.tscn")
