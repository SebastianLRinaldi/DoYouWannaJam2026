class_name Electrode
extends Area2D
@onready var floating_score_label: FloatingScoreLabel = %FloatingScoreLabel


const SPAWN_CURVE = preload("uid://co4qvjv0wuqx4")

@onready var mouse_area_2d: Area2D = %MouseArea2D
@onready var bandage_sprite: AnimatedSprite2D = %BandageSprite
@onready var usage_timer: Timer = %UsageTimer

var selected = false
var mouse_offset = Vector2(0, 0)

signal completed
signal bandage_infected

var bandage_use_count = 0

func _ready() -> void:
	GlobalManager.unstick_bandage.connect(_on_unstick_bandage)


func _process(delta):
	if selected:
		followMouse()


func _on_unstick_bandage():
	selected = false

func followMouse():
	position = get_global_mouse_position() + mouse_offset


func give_points(points:int):
	floating_score_label.add_floating_label(str(points))


func _on_mouse_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		mouse_offset = position - get_global_mouse_position()
		selected = true
		
	elif event.is_action_released("left_click"):
		selected = false
	
	get_viewport().set_input_as_handled()

func start_healing():
	usage_timer.start()


func stop_healing():
	usage_timer.stop()


func _on_usage_timer_timeout() -> void:
	bandage_use_count += 1
	bandage_sprite.frame = bandage_use_count
	completed.emit()
	if bandage_use_count >= 2:
		bandage_infected.emit()
