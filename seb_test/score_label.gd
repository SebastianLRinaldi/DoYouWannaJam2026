extends RichTextLabel

@onready var floating_score_label: FloatingScoreLabel = $FloatingScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text = "Score: " + str(GlobalManager.total_points)
	GlobalManager.update_score.connect(_on_update_score)
	

func _on_update_score():
	floating_score_label.add_floating_label(str(GlobalManager.points_removed))
	self.text = "Score: " + str(GlobalManager.total_points)
