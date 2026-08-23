class_name EletrodeContainer
extends Node2D

@onready var spawn_bandaid_button: Button = %SpawnBandaidButton
const SPAWN_CURVE = preload("uid://co4qvjv0wuqx4")

const ELECTRODE = preload("uid://bx35ptbx7ue23")

var x = 0
var y = 0
var moving = false

func _on_spawn_bandaid_button_pressed() -> void:

	#var x_offset = 26
	#var y_offset = 26
	if not moving:
		print(x)
		moving = true
		var ET = ELECTRODE.instantiate()
		add_child(ET)
		#ET.position = Vector2(26*x+x_offset, 26*y+y_offset)

		var tween = create_tween()
		tween.set_parallel(true)
		#audio_stream_player_2d.stream = move_sfx.pick_random()
		#tween.tween_callback(audio_stream_player_2d.play)
		var start = position
		#var ran_x_range = randf_range(0, 130)
		var end = start + Vector2(x*26, -SPAWN_CURVE.sample(x))
		tween.tween_property(ET, "position", end, 0.5)
		#tween.set_trans(Tween.TRANS_QUAD)
		#tween.set_ease(Tween.EASE_OUT)
		
		tween.tween_property(ET,"scale",Vector2(0.5,1.5),0.05)
		tween.tween_property(ET,"scale",Vector2(1.5,0.5),0.05)
		tween.tween_property(ET,"scale",Vector2(1,1),0.05)
		#tween.tween_interval(0.35) # Wait for half a second
		await tween.finished
		x += 1
		if x >= 6:
			x = 0
		moving = false
