extends Node2D
@export var zones: Array[BrainZone]

@onready var total_score: ScoreLabel = %TotalScore

@onready var spawn_bandaid_button: Button = %SpawnBandaidButton
const SPAWN_CURVE = preload("uid://co4qvjv0wuqx4")

@onready var fl_score: ScoreLabel = %FLScore
@onready var fl_score_2: ScoreLabel = %FLScore2
@onready var fl_score_3: ScoreLabel = %FLScore3
@onready var fl_score_4: ScoreLabel = %FLScore4
@onready var fl_score_5: ScoreLabel = %FLScore5
@onready var fl_score_6: ScoreLabel = %FLScore6

@onready var eletrode_container: Node2D = %EletrodeContainer

const ELECTRODE = preload("uid://bx35ptbx7ue23")

var electrode_count = 16

var total_points = 100
var points_removed


var config = {
	1: [0,0,0,0,0,0],
	2: [3,3,3,3,3,3],
	3: [1,2,3,4,5,6],
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func set_engery_by_level(level_key:int):
	var energy_amounts = config[level_key]
	for zone_idx in zones.size():
		zones[zone_idx].calc_engery(energy_amounts[zone_idx])


func _on_timer_timeout() -> void:
	set_engery_by_level(3)
	
	fl_score.update_score("B1", zones[0].energy)
	fl_score_2.update_score("B2", zones[1].energy)
	fl_score_3.update_score("B3", zones[2].energy)
	fl_score_4.update_score("B4", zones[3].energy)
	fl_score_5.update_score("B5", zones[4].energy)
	fl_score_6.update_score("B6", zones[5].energy)
	
	var total = 0 
	for zone in zones:
		total += zone.energy
	total_score.update_score("TS", total)

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
		eletrode_container.add_child(ET)
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
	
	
	
