class_name WoundZone
extends Area2D

@onready var floating_score_label: FloatingScoreLabel = %FloatingScoreLabel
@onready var wound_sprite: AnimatedSprite2D = %WoundSprite
@onready var blood_emiter: CPUParticles2D = %BloodEmiter
@onready var infection_cure_timer: Timer = %InfectionCureTimer

var energy = 100

var bandage_attached_to_wound:Electrode = null

var fully_healed = false
var infected_wound = false
var curing_wound = false

func _on_area_entered(area) -> void:
	if area is Electrode:
		if fully_healed: return
		if infected_wound: return
		if bandage_attached_to_wound: return
		bandage_attached_to_wound = area
		update_state("try_to_heal")
	elif area is Cure:
		if bandage_attached_to_wound: return
		if not infected_wound: return
		MusicManager.play_sfx(3)
		update_state("try_to_cure_wound")
	

func _on_area_exited(area) -> void:
	if area is Electrode:
		if bandage_attached_to_wound != area: return
		update_state("stop_healing")
		bandage_attached_to_wound = null
		MusicManager.play_sfx(2)
	elif area is Cure:
		pass

func update_state(state_name):
	match state_name:
		"try_to_heal":
			bandage_attached_to_wound.start_healing()
			bandage_attached_to_wound.completed.connect(_on_heal_success)
			bandage_attached_to_wound.bandage_infected.connect(_on_infected_wound)
			blood_emiter.emitting = false
		
		"stop_healing":
			bandage_attached_to_wound.completed.disconnect(_on_heal_success)
			bandage_attached_to_wound.bandage_infected.disconnect(_on_infected_wound)
			bandage_attached_to_wound.stop_healing()
			if fully_healed:
				blood_emiter.emitting = false 
			else:
				blood_emiter.emitting = true
		
		"infected_wound":
			infected_wound = true
			bandage_attached_to_wound.completed.disconnect(_on_heal_success)
			bandage_attached_to_wound.bandage_infected.disconnect(_on_infected_wound)
			bandage_attached_to_wound = null
			blood_emiter.emitting = true
			update_wound_frame(4)
			
		"try_to_cure_wound":
			curing_wound = true
			infection_cure_timer.one_shot = true
			infection_cure_timer.start()
			blood_emiter.emitting = false
			update_wound_frame(5)
		
		"cured_wound":
			curing_wound = false
			infected_wound = false
			blood_emiter.emitting = true
			update_wound_frame(0)
		
		
		_:
			print("Unknown state")

"""
0 - big
1 - med
2 - small
3 - scar (healed)
4 - infect
5 - curing
"""
func update_wound_frame(frame_idx: int):
	wound_sprite.frame = frame_idx
	#print("A-FRAME: ", wound_sprite.frame)

func _on_heal_success():
	wound_sprite.frame += 1
	if wound_sprite.frame == 3:
		fully_healed = true
		update_state("stop_healing")
	else:
		update_state("try_to_heal")
	#print("B-FRAME: ", wound_sprite.frame)
	

func _on_infected_wound():
	update_state("infected_wound")

func _on_infection_cure_timer_timeout() -> void:
	#print("TIME OUT")
	update_state("cured_wound")


func calc_current_loss():
	var blood_loss_rate = 0
	if bandage_attached_to_wound or curing_wound or fully_healed:
		blood_loss_rate = 0
	elif infected_wound:
		blood_loss_rate = 4
	elif wound_sprite.frame == 0:
		blood_loss_rate = 3
	elif wound_sprite.frame == 1:
		blood_loss_rate = 2
	elif wound_sprite.frame == 2:
		blood_loss_rate = 1
		
	if blood_loss_rate > 0:
		float_points(blood_loss_rate, "-")
	else:
		float_points(blood_loss_rate, "")
	#print("blood_loss_rate:", blood_loss_rate)
	
	energy -= blood_loss_rate
	
	
	#if bandage_attached_to_wound: return
	#if curing_wound: return
	
	
	
	
	
	#var energy_draw = (blood_loss_rate + infected_loss)
	#if energy_draw > 0:
		#float_points(energy_draw, "-")
		#energy -= abs(energy_draw)
	#elif energy_draw == 0:
		#float_points(energy_draw, "=")
	#else:
		#print("ERROR")


func float_points(points:int, sign:String):
	floating_score_label.add_floating_label(sign + str(points))
	#floating_score_label.text = str(energy)
#
#
#func _on_area_entered(area) -> void:
	#if area is Electrode:
		#if fully_healed: return
		#if infected_wound: return
		#if bandage_attached_to_wound: return
			#bandage_attached_to_wound = area
		#area.start_healing()
		#area.completed.connect(on_bandage_completed)
		#area.bandage_infected.connect(on_bandage_infected)
		#blood_emiter.emitting = false
	#elif area is Cure:
		#if bandage_attached_to_wound: return
		#if not infected_wound: return 
		#infection_cure_timer.start()
		#blood_emiter.emitting = false
		#curing_wound = true
		#wound_sprite.frame = 5
		
#
#
#
#func _on_area_exited(area) -> void:
	#if area is Electrode:
		#if bandage_attached_to_wound != area: return
		#bandage_attached_to_wound = null
		#area.completed.disconnect(on_bandage_completed)
		#area.bandage_infected.disconnect(on_bandage_infected)
		#area.stop_healing()
		#if not fully_healed:
			#blood_emiter.emitting = true
	#elif area is Cure:
		#pass
#
#func stop_healing_wound():
	#bandage_attached_to_wound.completed.disconnect(on_bandage_completed)
	#bandage_attached_to_wound.bandage_infected.disconnect(on_bandage_infected)
	#bandage_attached_to_wound.stop_healing()
#
#
#func on_bandage_completed():
	#heal_count += 1
	#loss_reduced += 1
	#wound_sprite.frame = heal_count
	#
	#if heal_count == 3:
		#fully_healed = true
#
#func on_bandage_infected():
	#infected_wound = true
	#fully_healed = false
	#wound_sprite.frame = 4
	#blood_emiter.emitting = true
	#stop_healing_wound()
#
#
#
#func _on_infection_cure_timer_timeout() -> void:
	#infected_wound = false
	#curing_wound = false
	#loss_reduced = 0
	#infected_loss = 0
	#heal_count = 0
	#wound_sprite.frame = heal_count
	#blood_emiter.emitting = true
