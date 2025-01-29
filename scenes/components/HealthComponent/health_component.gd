extends Node2D
class_name HealthComponent

@onready var healthbar = $Healthbar
@onready var damagebar = $Healthbar/Damagebar
@onready var timer = $Healthbar/Timer
@onready var blood = load("res://scenes/Blood/blood.tscn")
@onready var hurtbox_component = $"../HurtboxComponent"

@export var max_health := 10
var current_health

func _ready():
	current_health = max_health
	healthbar.max_value = current_health
	healthbar.value = current_health
	damagebar.max_value = current_health
	damagebar.value = current_health

func damage(damage_amount: float):
	var blood_instance = blood.instantiate()
	get_tree().current_scene.add_child(blood_instance)
	blood_instance.global_position = hurtbox_component.global_position
	
	current_health = max(current_health - damage_amount, 0)
	healthbar.value = current_health
	Callable(check_death).call_deferred()


func get_health_percent():
	if max_health <= 0:
		return
	return min(current_health / max_health, 1)


func check_death():
		if current_health == 0:
			var play_death_animation = get_parent().has_death_animation
			
			if play_death_animation:
				get_parent()._death_animation()
				#if get_parent().name == "Player":
					#get_tree().change_scene_to_file("res://scene/levels/Main/world.tscn")
			else:
				#if get_parent().name == "Player":
					#get_tree().change_scene_to_file("res://scene/levels/Main/world.tscn")
				owner.queue_free()
		else:
			timer.start()


func _on_timer_timeout():
	damagebar.value = current_health
