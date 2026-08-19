extends Node2D

var total_points = 100
var points_removed

var connected_nodes = []

signal connect_node(node:TestBtn)
signal disconnect_node(node:TestBtn)
signal update_score


func _on_timer_timeout() -> void:
	points_removed = 0
	print("connected: ", connected_nodes)
	for node in connected_nodes:
		node.take_points(1)
		total_points -= 1
		points_removed += 1
	
	if points_removed > 0:
		update_score.emit()
	print("total_points: ", total_points)


func _on_connect_node(node: Variant) -> void:
	connected_nodes.append(node)

func _on_disconnect_node(node: Variant) -> void:
	connected_nodes.erase(node)
