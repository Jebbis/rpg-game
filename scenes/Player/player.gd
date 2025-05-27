extends CharacterBody2D

class_name Player

@export var character_speed := 75.0
@export var inventory: Inventory

@onready var movement := $PlayerMovement
@onready var animation_player := $AnimationPlayer
@onready var weapon = $Weapon

var can_move := true

func _process(_delta):
	
	##Make own function for this - handle_weapon_position
	var mouse_position = get_global_mouse_position()
	var angle_to_mouse = global_position.angle_to_point(mouse_position)
	weapon.rotation = angle_to_mouse
	
	if Input.is_action_just_pressed("attack"):
		weapon.swing_sword(mouse_position)
