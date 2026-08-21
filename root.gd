extends Node2D
@export var zones: Array[BrainZone]

@onready var total_score: ScoreLabel = %TotalScore

@onready var fl_score: ScoreLabel = %FLScore
@onready var fl_score_2: ScoreLabel = %FLScore2
@onready var fl_score_3: ScoreLabel = %FLScore3
@onready var fl_score_4: ScoreLabel = %FLScore4
@onready var fl_score_5: ScoreLabel = %FLScore5
@onready var fl_score_6: ScoreLabel = %FLScore6

@onready var eletrode_container: Node2D = %EletrodeContainer

const ELECTRODE = preload("uid://bx35ptbx7ue23")

var electrode_count = 15

var total_points = 100
var points_removed


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var x = 0
	var y = 0
	var x_offset = 13
	var y_offset = 13
	for temp_idx in range(electrode_count):
		var ET = ELECTRODE.instantiate()
		eletrode_container.add_child(ET)
		ET.position = Vector2(26*x+x_offset, 26*y+y_offset)
		x += 1
		if x >= 4:
			y += 1
			x = 0



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	#zones[0].calc_engery(randi_range(0,3))
	#zones[1].calc_engery(randi_range(0,3))
	#zones[2].calc_engery(randi_range(0,3))
	#zones[3].calc_engery(randi_range(0,3))
	#zones[4].calc_engery(randi_range(0,3))
	#zones[5].calc_engery(randi_range(0,3))
	
	zones[0].calc_engery(3)
	zones[1].calc_engery(1)
	zones[2].calc_engery(0)
	zones[3].calc_engery(2)
	zones[4].calc_engery(4)
	zones[5].calc_engery(1)
	
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
