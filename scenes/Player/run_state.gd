extends Node2D

@onready var state_machine = $".."
@onready var player = $"../.."
@onready var sprite = $"../../PlayerTexture"
@onready var animation_player = $"../../AnimationPlayer"

func enter():
	animation_player.play("run")

func update(_delta):
	var direction = player.get_node("PlayerMovement").get_direction()
	if direction == Vector2.ZERO:
		state_machine.change_state(state_machine.get_node("IdleState"))
	else:
		handle_sprite_direction(direction)

func exit():
	pass

func handle_sprite_direction(direction):
	if direction.x != 0:
		sprite.flip_h = direction.x < 0
	else:
		sprite.flip_h = false  # Reset flip for up/down movement
