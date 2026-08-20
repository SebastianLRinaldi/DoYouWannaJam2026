extends Node2D
@onready var floating_score_label: FloatingScoreLabel = %FloatingScoreLabel


var selected = false
var mouse_offset = Vector2(0, 0)


func _process(delta):
	if selected:
		followMouse()


func followMouse():
	position = get_global_mouse_position() + mouse_offset


func give_points(points:int):
	floating_score_label.add_floating_label(str(points))



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			mouse_offset = position - get_global_mouse_position()
			selected = true
		else:
			selected = false
