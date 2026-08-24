class_name Cure
extends Area2D

@onready var mouse_area_2d: Area2D = %MouseArea2D
@onready var bandage_sprite: AnimatedSprite2D = %BandageSprite

var selected = false
var mouse_offset = Vector2(0, 0)


func _ready() -> void:
	GlobalManager.unstick_bandage.connect(_on_unstick_bandage)


func _process(delta):
	if selected:
		followMouse()


func _on_unstick_bandage():
	selected = false

func followMouse():
	position = get_global_mouse_position() + mouse_offset


func _on_mouse_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		mouse_offset = position - get_global_mouse_position()
		selected = true
		
	elif event.is_action_released("left_click"):
		selected = false
	
	get_viewport().set_input_as_handled()
