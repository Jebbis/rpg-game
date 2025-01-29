extends Node2D

@export var character_speed := 75.0
@onready var player := get_parent()

var direction := Vector2.ZERO
var velocity := Vector2.ZERO

func _physics_process(_delta):
	handle_movement()

func handle_movement():
	direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = direction * character_speed
	player.velocity = velocity
	player.move_and_slide()

func get_direction() -> Vector2:
	return direction

func get_velocity() -> Vector2:
	return velocity
