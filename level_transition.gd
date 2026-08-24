extends Node2D
@onready var animation_player: AnimationPlayer = %AnimationPlayer

var scene_to_load

func change_scene_to(scene_path: String) -> void:
	scene_to_load = scene_path
	animation_player.play("close")
	get_tree().paused = true
	print("closed")
	

func _load_new_scene() -> void:
	print("OPEN")
	animation_player.play("open")
	get_tree().call_deferred("change_scene_to_file", scene_to_load)
	var tween = create_tween()
	tween.tween_interval(1.0)
	await tween.finished
	get_tree().paused = false
	
