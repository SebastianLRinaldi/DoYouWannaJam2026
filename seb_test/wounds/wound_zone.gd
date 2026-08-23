class_name WoundZone
extends Area2D

@onready var floating_score_label: FloatingScoreLabel = %FloatingScoreLabel
@onready var wound_sprite: AnimatedSprite2D = %WoundSprite
@onready var blood_emiter: CPUParticles2D = %BloodEmiter

@export var blood_loss_rate = 2

var energy = 100
var heal_count = 0

var bandage_attached_to_wound:Electrode = null
var loss_reduced = 0

var fully_healed = false
var infected_wound = false

func _ready() -> void:
	blood_emiter.emitting = true

func calc_current_loss():
	if bandage_attached_to_wound: return
	var energy_draw = blood_loss_rate - loss_reduced
	if energy_draw > 0:
		float_points(energy_draw, "-")
		energy -= abs(energy_draw)
	elif energy_draw == 0:
		float_points(energy_draw, "=")
	else:
		print("ERROR")


func float_points(points:int, sign:String):
	floating_score_label.add_floating_label(sign + str(points))
	#floating_score_label.text = str(energy)


func _on_area_entered(area: Electrode) -> void:
	if fully_healed: return
	if bandage_attached_to_wound: return
	bandage_attached_to_wound = area
	area.start_healing()
	area.completed.connect(on_bandage_completed)
	area.bandage_infected.connect(on_bandage_infected)
	blood_emiter.emitting = false


func _on_area_exited(area: Electrode) -> void:
	if bandage_attached_to_wound != area: return
	bandage_attached_to_wound = null
	area.completed.disconnect(on_bandage_completed)
	area.bandage_infected.disconnect(on_bandage_infected)
	area.stop_healing()
	if not fully_healed:
		blood_emiter.emitting = true

func stop_healing_wound():
	bandage_attached_to_wound.completed.disconnect(on_bandage_completed)
	bandage_attached_to_wound.bandage_infected.disconnect(on_bandage_infected)
	bandage_attached_to_wound.stop_healing()


func on_bandage_completed():
	if infected_wound:
		infected_wound = false
		loss_reduced += 1
		heal_count = 0
	else:
		heal_count += 1
		loss_reduced += 1
	wound_sprite.frame = heal_count
	
	if heal_count == 2:
		fully_healed = true

func on_bandage_infected():
	infected_wound = true
	fully_healed = false
	wound_sprite.frame = 3
	loss_reduced = -1
	stop_healing_wound()
