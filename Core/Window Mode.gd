extends Panel

func _on_windowed_pressed():
	$Panel.visible = false
	Settings.window_mode = DisplayServer.WINDOW_MODE_WINDOWED

func _on_fullscreen_pressed():
	$Panel.visible = false
	Settings.window_mode = DisplayServer.WINDOW_MODE_FULLSCREEN

func _on_button_mode_pressed():
	$Panel.visible = true
