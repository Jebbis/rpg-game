extends GPUParticles2D



func _on_timer_timeout():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.3)  # Fade out over 1 second
	await tween.finished
	queue_free()
