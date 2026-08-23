extends Node2D

@onready var wounds_container: Node2D = %WoundsContainer

@onready var total_score: ScoreLabel = %TotalScore

@onready var fl_score: ScoreLabel = %FLScore
@onready var fl_score_2: ScoreLabel = %FLScore2
@onready var fl_score_3: ScoreLabel = %FLScore3
@onready var fl_score_4: ScoreLabel = %FLScore4
@onready var fl_score_5: ScoreLabel = %FLScore5
@onready var fl_score_6: ScoreLabel = %FLScore6

var wounds = []

var total_points = 100
var points_removed

var config = {
	1: [0,0,0,0,0,0],
	2: [3,3,3,3,3,3],
	3: [1,2,3,4,5,6],
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wounds = wounds_container.get_children()
	print(wounds)

func set_engery_by_level(level_key:int):
	var energy_amounts = config[level_key]
	for zone_idx in wounds.size():
		wounds[zone_idx].calc_engery(energy_amounts[zone_idx])

func _on_timer_timeout() -> void:
	set_engery_by_level(3)
	
	var wound_idx = 0
	for wound in wounds:
		var wound_name = "Wound" + str(wound_idx) + ": "
		fl_score.update_score(wound_name, wound.energy)
		wound_idx += 1
	
	var total = 0 
	for zone in wounds:
		total += zone.energy
	total_score.update_score("TS", total)
