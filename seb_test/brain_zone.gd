class_name BrainZone
extends Area2D

@onready var floating_score_label: FloatingScoreLabel = %FloatingScoreLabel

var energy = 100
var connected_nodes = []

#func nodes_give_energy() -> int:
	#if connected_nodes:
		#float_points(connected_nodes.size(), "+")
		#energy += 1
	#return connected_nodes.size()
#
#func task_takes_energy(points:int):
	#float_points(points, "-")

func calc_engery(engery_from_task:int):
	var energy_draw = connected_nodes.size() - engery_from_task
	if energy_draw > 0:
		float_points(energy_draw, "+")
		energy += energy_draw
	elif energy_draw < 0:
		float_points(energy_draw, "")
		energy -= abs(energy_draw)
	elif energy_draw == 0:
		float_points(energy_draw, "=")
	else:
		print("ERROR")


func float_points(points:int, sign:String):
	floating_score_label.add_floating_label(sign + str(points))
	floating_score_label.text = str(energy)

func _on_area_entered(area: Area2D) -> void:
	#print(self, "entered")
	connected_nodes.append(area)


func _on_area_exited(area: Area2D) -> void:
	#print(self, "exited")
	connected_nodes.erase(area)
