extends Node2D

@onready var state_machine = get_parent()
@onready var player = $"../.."
@onready var animation_player = $"../../AnimationPlayer"
@onready var movement = $"../../PlayerMovement"

var dash_duration := 0.2  # Dash lasts for 0.2 seconds
var dash_distance := 50.0  # Fixed dash distance (in pixels)

var dash_timer = 0.0

func enter():
	animation_player.play("dash")  # Play dash animation (optional)
	dash_timer = dash_duration
	
	# Get direction or default to facing direction
	var direction = movement.get_direction()
	if direction == Vector2.ZERO:
		direction = Vector2.RIGHT if $"../../PlayerTexture".flip_h == false else Vector2.LEFT
	
	# Calculate target dash position
	var dash_vector = direction.normalized() * dash_distance
	var target_position = player.position + dash_vector
	
	# Tween to the target position
	var tween = create_tween()
	tween.tween_property(player, "position", target_position, dash_duration)
	
func update(delta):
	dash_timer -= delta
	if dash_timer <= 0:
		state_machine.change_state(state_machine.get_node("IdleState"))

func exit():
	# Reset to normal speed after dash
	movement.velocity = Vector2.ZERO
