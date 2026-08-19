class_name TestBtn
extends CheckButton

@onready var floating_score_label: FloatingScoreLabel = %FloatingScoreLabel

func _on_toggled(toggled_on: bool) -> void:
	print("toggled: ", toggled_on)
	if toggled_on:
		GlobalManager.connect_node.emit(self)
	else:
		GlobalManager.disconnect_node.emit(self)

func take_points(points:int):
	floating_score_label.add_floating_label(str(points))
