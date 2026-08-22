class_name Electrode
extends Area2D
@onready var floating_score_label: FloatingScoreLabel = %FloatingScoreLabel


const SPAWN_CURVE = preload("uid://co4qvjv0wuqx4")

@onready var mouse_area_2d: Area2D = %MouseArea2D

var selected = false
var mouse_offset = Vector2(0, 0)


func _ready() -> void:
	pass
	
	#var tween = create_tween()
	##tween.set_parallel(true)
	##audio_stream_player_2d.stream = move_sfx.pick_random()
	##tween.tween_callback(audio_stream_player_2d.play)
	#var start = position
	#var ran_x_range = randf_range(0, 130)
	#var end = start + Vector2(ran_x_range, -SPAWN_CURVE.sample(ran_x_range))
	#tween.tween_property(self, "position", end, 0.5)
	##tween.set_trans(Tween.TRANS_QUAD)
	##tween.set_ease(Tween.EASE_OUT)
	#
	#tween.tween_property(self,"scale",Vector2(0.5,1.5),0.05)
	#tween.tween_property(self,"scale",Vector2(1.5,0.5),0.05)
	#tween.tween_property(self,"scale",Vector2(1,1),0.05)
	##tween.tween_interval(0.35) # Wait for half a second
	#await tween.finished
	##moving = false


func _process(delta):
	if selected:
		followMouse()


func followMouse():
	position = get_global_mouse_position() + mouse_offset


func give_points(points:int):
	floating_score_label.add_floating_label(str(points))


func _on_mouse_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			mouse_offset = position - get_global_mouse_position()
			selected = true
		else:
			selected = false
