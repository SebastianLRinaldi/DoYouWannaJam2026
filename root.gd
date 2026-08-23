extends Node2D

@onready var wounds_container: Node2D = %WoundsContainer

@onready var total_score: ScoreLabel = %TotalScore


#@onready var fl_score: ScoreLabel = %FLScore
#@onready var fl_score_2: ScoreLabel = %FLScore2
#@onready var fl_score_3: ScoreLabel = %FLScore3
#@onready var fl_score_4: ScoreLabel = %FLScore4
#@onready var fl_score_5: ScoreLabel = %FLScore5
#@onready var fl_score_6: ScoreLabel = %FLScore6

var wounds = []
var prev_blood_loss = INF
var total_points = 100
var points_removed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wounds = wounds_container.get_children()

func _on_timer_timeout() -> void:
	for zone_idx in wounds.size():
		wounds[zone_idx].calc_current_loss() # CHANGE THIS FOR EACH WOUND
	
	#var wound_idx = 0
	#for wound in wounds:
		#var wound_name = "Wound" + str(wound_idx) + ": "
		##fl_score.update_score(wound_name, wound.energy)
		#wound_idx += 1
	
	
	
	var blood_loss = 0 
	for wound in wounds:
		blood_loss += wound.energy
	

	if blood_loss == prev_blood_loss:
		total_score.update_score("Blood Retained", blood_loss)
	else:
		total_score.update_score("Blood Left", blood_loss)
		prev_blood_loss = blood_loss
#func _on_un_stick_btn_pressed() -> void:
	#GlobalManager.unstick_bandage.emit()


func _on_area_2d_mouse_exited() -> void:
	print("EXITED")
	GlobalManager.unstick_bandage.emit()
