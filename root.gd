extends Node2D

@onready var wounds_container: Node2D = %WoundsContainer

@onready var total_score: ScoreLabel = %TotalScore

var wounds = []
var prev_blood_loss = INF
var total_points = 100
var points_removed
var max_blood = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wounds = wounds_container.get_children()
	set_max_blood()

func set_max_blood():
	var new_amount = 0
	for wound in wounds:
		new_amount += wound.energy
	max_blood = new_amount
	total_score.update_score("Blood Retained", max_blood)

func _on_timer_timeout() -> void:
	for zone_idx in wounds.size():
		wounds[zone_idx].calc_current_loss() # CHANGE THIS FOR EACH WOUND

	
	var blood_loss = 0 
	for wound in wounds:
		blood_loss += wound.energy
	
	var percent_remaining = (float(blood_loss)/max_blood) * 100
	
	if blood_loss == prev_blood_loss:
		total_score.update_score("Blood Retained", percent_remaining)
	else:
		total_score.update_score("Losing Blood ", percent_remaining)
		prev_blood_loss = blood_loss



func _on_area_2d_mouse_exited() -> void:
	GlobalManager.unstick_bandage.emit()
