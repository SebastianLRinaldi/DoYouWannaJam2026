class_name FloatingScoreLabel
extends RichTextLabel

@export var fade_color: Color
var tween : Tween

func add_floating_label(text:String):
	# Create and setup the float_label
	var float_label = Label.new()
	float_label.text = text
	float_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	float_label.z_index = 10
	float_label.top_level = true
	float_label.global_position = self.global_position #+ Vector2(50,10)
	float_label.global_position.x -= float_label.size.x/2.0
	float_label.global_position.y -= float_label.size. y
	add_child(float_label)

	# speed up the previous animation (if any)
	if tween and tween.is_running():
		tween. set_speed_scale(2.0)
		
	tween = create_tween()
	tween.set_parallel(true) # all parallel by default now

	# Move the float_label up and on a random side
	var x = randf_range(-50, 50)
	var y = 0

	tween. tween_property(float_label, "position:x", x, 1.0).as_relative()

	tween. set_trans (Tween. TRANS_CUBIC) . set_ease(Tween. EASE_IN)
	tween. tween_property(float_label, "position:y", y, 1.0).as_relative()

	# Change the float_label color and fade it out
	tween. set_trans (Tween. TRANS_SINE) . set_ease (Tween. EASE_OUT)
	tween. tween_property(float_label, "modulate", fade_color, 0.5).set_delay(0.5)
	tween. tween_property(float_label, "self_modulate:a", 0.0, 0.2).set_delay(0.8)

	# chain() is the opposite of parallel()
	tween.chain().tween_callback(float_label.queue_free) # delete float_label
