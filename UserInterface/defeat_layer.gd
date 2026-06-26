extends CanvasLayer

func defeat() -> void:
	visible = true

func retry() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func quit() -> void:
	get_tree().quit()
	
