extends CPUParticles2D


func _on_timer_timeout():
	set_process(false)
	set_physics_process(false)
	set_process_input(false)
	set_process_internal(false)
	set_process_unhandled_input(false)
	set_process_unhandled_key_input(false)



func _on_despawn_blood_timeout():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5)  # Fade out over 1 second
	await tween.finished
	queue_free()
