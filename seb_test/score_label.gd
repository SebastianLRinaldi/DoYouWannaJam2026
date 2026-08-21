class_name ScoreLabel
extends RichTextLabel

@onready var floating_score_label: FloatingScoreLabel = $FloatingScoreLabel

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#self.text = "Score: " + str(GlobalManager.total_points)
	#GlobalManager.update_score.connect(_on_update_score)
	#
#
func update_score(score_name:String, new_score:int):
	self.text =  score_name + ": " + str(new_score)
