extends Area2D
class_name HurtboxComponent

@export var health_component: Node2D
@export var damageNumbers_component: Node2D
@export var hit_flash_anim_player: Node

func _ready():
	area_entered.connect(on_area_entered)
	
	
func on_area_entered(other_area: Area2D):
	print(other_area)
	if not other_area is HitboxComponent:
		return
	
	if health_component == null:
		return
	
	var hitbox_component = other_area as HitboxComponent
	var damage = hitbox_component.damage
	var is_critical = hitbox_component.critical_chance > randf()
	if is_critical: damage *=2
	
	if damageNumbers_component: damageNumbers_component.display_damage_text(damage, is_critical)
	if hit_flash_anim_player: hit_flash_anim_player.play("hit_flash")
	
	health_component.damage(damage)
