extends Node2D

@onready var hitbox = $HitboxComponent/CollisionShape2D
@onready var hitbox2 = $HitboxComponent/CollisionShape2D2
@onready var weapon_sparkles = $Sprite2D/WeaponSparkles

var swing_angle = 160  # Angle of the swing arc
var swing_duration = 0.35  # How long the swing lasts
var swing_back_time = 0.05  # Time to reach -60 degrees
var swing_forward_time = 0.2  # Time to reach 75 degrees
var reset_time = 0.35  # Reset at the end
var easing = 1.65

var last_mouse_position = Vector2.ZERO
@export var movement_threshold: float = 10.0  # Minimum movement to trigger particles


func _process(_delta):
	spawn_particles()


func spawn_particles() -> void:
	var current_mouse_position = get_global_mouse_position()
	var distance_moved = current_mouse_position.distance_to(last_mouse_position)

	# Emit particles only if movement exceeds the threshold
	if distance_moved > movement_threshold:
		weapon_sparkles.emitting = true
	else:
		weapon_sparkles.emitting = false

	# Update last position
	last_mouse_position = current_mouse_position


func enable_hitbox():
	hitbox.disabled = false
	hitbox2.disabled = false

func disable_hitbox():
	hitbox.disabled = true
	hitbox2.disabled = true

func swing_sword(mouse_position):
	var start_rotation = rotation_degrees
	var swing_direction = 1  # Default to right swing

	# Reverse if mouse is on the left
	if mouse_position.x < global_position.x:
		swing_direction = -1

	var tween = create_tween()
	tween.set_parallel(false)

	# Step 1: Swing back (reverse for left side)
	tween.tween_callback(disable_hitbox)
	tween.tween_property(
		self, 
		"rotation_degrees", 
		start_rotation + (-60 * swing_direction), 
		swing_back_time
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	# Step 2: Swing forward to 75 degrees (reverse for left side)
	tween.tween_callback(enable_hitbox)
	tween.tween_property(
		self, 
		"rotation_degrees", 
		start_rotation + (75 * swing_direction), 
		swing_forward_time - swing_back_time
	).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT).set_ease(easing)

	# Step 3: Reset to starting rotation
	tween.tween_callback(disable_hitbox)
	tween.tween_property(
		self, 
		"rotation_degrees", 
		start_rotation, 
		reset_time - swing_forward_time
	).set_trans(Tween.TRANS_LINEAR)
