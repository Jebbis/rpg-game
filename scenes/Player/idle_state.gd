extends Node2D

@onready var state_machine = $".."
@onready var player = $"../.."
@onready var animation_player = $"../../AnimationPlayer"

func enter():
	animation_player.play("idle")

func update(_delta):
	if player.get_node("PlayerMovement").get_direction() != Vector2.ZERO:
		state_machine.change_state(state_machine.get_node("RunState"))

func exit():
	pass
