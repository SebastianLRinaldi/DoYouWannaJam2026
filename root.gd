extends Node2D
@export var zones: Array[BrainZone]

@onready var fl_score: ScoreLabel = %FLScore
@onready var fl_score_2: ScoreLabel = %FLScore2
@onready var fl_score_3: ScoreLabel = %FLScore3
@onready var fl_score_4: ScoreLabel = %FLScore4
@onready var fl_score_5: ScoreLabel = %FLScore5
@onready var fl_score_6: ScoreLabel = %FLScore6


var total_points = 100
var points_removed

signal update_energy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	zones[0].calc_engery(randi_range(0,3))
	zones[1].calc_engery(randi_range(0,3))
	zones[2].calc_engery(randi_range(0,3))
	zones[3].calc_engery(randi_range(0,3))
	zones[4].calc_engery(randi_range(0,3))
	zones[5].calc_engery(randi_range(0,3))
	
	fl_score.update_score("B1", zones[0].energy)
	fl_score_2.update_score("B2", zones[1].energy)
	fl_score_3.update_score("B3", zones[2].energy)
	fl_score_4.update_score("B4", zones[3].energy)
	fl_score_5.update_score("B5", zones[4].energy)
	fl_score_6.update_score("B6", zones[5].energy)
	
	
	#for zone in zones:
		#zone.calc_engery(2)

		
