extends Node


@onready var language := "en"
@onready var fullscreen := true

var display_sizes : Array = [Vector2(1920,1080),Vector2(1600,900),Vector2(1440,870),Vector2(1280,840)]
var display_index := 0
var screen_size := Vector2(1920,1080)
var window_mode := DisplayServer.WINDOW_MODE_FULLSCREEN

func loading():
	update_setting()
	
func update_setting() -> void:
	screen_size = display_sizes[display_index]
	ProjectSettings.set_setting("display/window/size/viewport_width", screen_size.x)
	ProjectSettings.set_setting("display/window/size/viewport_height", screen_size.y)
	DisplayServer.window_set_mode(window_mode)
	DisplayServer.window_set_size(screen_size)
