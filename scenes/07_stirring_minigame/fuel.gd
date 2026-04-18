extends ProgressBar

func _on_value_changed(amt: float) -> void:
	if amt <= 50 and amt > 20:
		get("theme_override_styles/fill").bg_color = Color(0.87, 0.53, 0.252, 1.0)
	elif amt <= 20:
		get("theme_override_styles/fill").bg_color = Color(0.72, 0.194, 0.194, 1.0)
