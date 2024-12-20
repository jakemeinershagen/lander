extends CanvasLayer

func toggle_pause():
	get_tree().paused = not get_tree().paused
	$PauseMenu.visible = not $PauseMenu.visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_released("pause"):
		toggle_pause()


func _on_resume_button_up() -> void:
	toggle_pause()


func _on_quit_button_up() -> void:
	get_tree().quit()


func _on_restart_button_up() -> void:
	toggle_pause()
	get_tree().reload_current_scene()


func _on_ship_landing_success() -> void:
	$ResultText/Label.text = "Success!"
	$PauseMenu/Resume.visible = false
	$ResultText.visible = true


func _on_ship_landing_fail() -> void:
	$ResultText/Label.text = "Crashed!"
	$PauseMenu/Resume.visible = false
	$ResultText.visible = true


func _on_settings_button_up() -> void:
	$SettingsMenu.visible = true


func _on_back_button_up() -> void:
	$SettingsMenu.visible = false
