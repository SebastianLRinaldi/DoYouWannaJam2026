extends Node2D

@export_file("*.tscn") var scene_path: String
##
### Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().change_scene_to_file(scene_path)
	

#@export var scene: PackedScene
#func _ready() -> void:
	#Fade.transition_layer.visible = false
	#if scene:
		#get_tree().change_scene_to_packed(scene)

# TODO THIS NEEDS TO BE TURNED ON FOR FULL GAME
#func _ready() -> void:
	#Fade.transition_layer.visible = true
	#Fade.fade_to(0)
