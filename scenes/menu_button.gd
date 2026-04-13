extends Button

func _on_pressed() -> void:
	ScenesManager.load_scene(ScenesConstants.SCENE_PATHS[ScenesConstants.KEY_SETTINGS_SCREEN])
