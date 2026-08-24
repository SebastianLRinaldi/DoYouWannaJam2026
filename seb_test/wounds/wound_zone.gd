class_name WoundZone
extends Area2D

@onready var floating_score_label: FloatingScoreLabel = %FloatingScoreLabel
@onready var wound_sprite: AnimatedSprite2D = %WoundSprite
@onready var blood_emiter: CPUParticles2D = %BloodEmiter
@onready var infection_cure_timer: Timer = %InfectionCureTimer

@export var blood_loss_rate = 3

var energy = 100
var heal_count = 0

var bandage_attached_to_wound:Electrode = null
var loss_reduced = 0
var infected_loss = 0

var fully_healed = false
var infected_wound = false
var curing_wound = false


var wound_config = {
	"infected": [0],
	"cure_applied":[0],
	0: [0], # big wound
	1: [1], # med wound 
	2: [2], # small wound 
	3: [3] # fully healed, cant get infected anymore
	
	
}
	
	
func _process(delta: float) -> void:
	print("=== HEAL DEBUG ===")
	print("heal_count: ", heal_count)
	print("loss_reduced: ", loss_reduced)
	print("infected_loss: ", infected_loss)
	print("fully_healed: ", fully_healed)
	print("infected_wound: ", infected_wound)
	print("==================")


func _ready() -> void:
	blood_emiter.emitting = true

func calc_current_loss():
	if bandage_attached_to_wound: return
	var energy_draw = (blood_loss_rate + infected_loss)
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


func _on_area_entered(area) -> void:
	if area is Electrode:
		if fully_healed: return
		if infected_wound: return
		if bandage_attached_to_wound: return
		bandage_attached_to_wound = area
		area.start_healing()
		area.completed.connect(on_bandage_completed)
		area.bandage_infected.connect(on_bandage_infected)
		blood_emiter.emitting = false
	elif area is Cure:
		if bandage_attached_to_wound: return
		if not infected_wound: return 
		infection_cure_timer.start()
		blood_emiter.emitting = false
		wound_sprite.frame = 5
		



func _on_area_exited(area) -> void:
	if area is Electrode:
		if bandage_attached_to_wound != area: return
		bandage_attached_to_wound = null
		area.completed.disconnect(on_bandage_completed)
		area.bandage_infected.disconnect(on_bandage_infected)
		area.stop_healing()
		if not fully_healed:
			blood_emiter.emitting = true
	elif area is Cure:
		pass

func stop_healing_wound():
	bandage_attached_to_wound.completed.disconnect(on_bandage_completed)
	bandage_attached_to_wound.bandage_infected.disconnect(on_bandage_infected)
	bandage_attached_to_wound.stop_healing()


func on_bandage_completed():
	heal_count += 1
	loss_reduced += 1
	wound_sprite.frame = heal_count
	
	if heal_count == 3:
		fully_healed = true

func on_bandage_infected():
	infected_wound = true
	fully_healed = false
	wound_sprite.frame = 4
	infected_loss = 1
	stop_healing_wound()



func _on_infection_cure_timer_timeout() -> void:
	infected_wound = false
	loss_reduced = 0
	infected_loss = 0
	heal_count = 0
	wound_sprite.frame = heal_count
	blood_emiter.emitting = true
