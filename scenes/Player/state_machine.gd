extends Node2D

var current_state = null
var can_dash = true
var dash_cooldown = 0.5
var cooldown_timer = 0.0

func _ready():
	change_state($IdleState)

func change_state(new_state: Node2D):
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()

func _process(delta):
	if current_state:
		current_state.update(delta)
	
	handle_dash_cooldown(delta)
	
	# Check for dash input (Shift key)
	if Input.is_action_just_pressed("dash") and can_dash and current_state.name == "RunState" :
		change_state($DashState)
		can_dash = false

func handle_dash_cooldown(delta):
	if not can_dash:
		cooldown_timer += delta
		if cooldown_timer >= dash_cooldown:
			can_dash = true
			cooldown_timer = 0
