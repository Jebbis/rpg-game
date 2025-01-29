extends Node2D

func display_damage_text(damage: int, is_critical: bool):
	DamageNumbers.display_number(damage,global_position,is_critical)
