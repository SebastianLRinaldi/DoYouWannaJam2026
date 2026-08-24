class_name EletrodeContainer
extends Node2D

@onready var spawn_bandaid_button: Button = %SpawnBandaidButton
@onready var marker_2d: Marker2D = $Marker2D


const SPAWN_CURVE = preload("uid://co4qvjv0wuqx4")

const ELECTRODE = preload("uid://bx35ptbx7ue23")


var moving = false

func random_donut_point() -> Vector2:
	var angle: float   = randf_range(0.0, TAU)     # Random angle 0..360 degrees.
	var vec:   Vector2 = Vector2.RIGHT             # (0.0, 1.0)
	var dist:  float   = randf_range(10, 60) # Random length.

	# Put 'em all together...
	return (vec * dist).rotated(angle)


func _on_spawn_bandaid_button_pressed() -> void:

	if not moving:
		moving = true
		var ET:Electrode = ELECTRODE.instantiate()
		self.add_child(ET)


		var tween = create_tween()
		tween.set_parallel(true)
		#audio_stream_player_2d.stream = move_sfx.pick_random()
		#tween.tween_callback(audio_stream_player_2d.play)
		var start = global_position
		var end = start + Vector2(0,-100) + random_donut_point()
		
		
		tween.tween_property(ET, "global_position", end, 0.02)
		#tween.set_trans(Tween.TRANS_QUAD)
		#tween.set_ease(Tween.EASE_OUT)
		
		tween.tween_property(ET,"scale",Vector2(0.5,1.5),0.05)
		tween.tween_property(ET,"scale",Vector2(1.5,0.5),0.05)
		tween.tween_property(ET,"scale",Vector2(1,1),0.05)
		#tween.tween_interval(0.35) # Wait for half a second
		await tween.finished

		moving = false
