extends CanvasLayer

@export var test := false

func loading() -> void:
	if test:
		$Intro.queue_free()
		_on_new_begining_pressed()
	Core.centered_position($"New Begining",Vector2(-($"New Begining".custom_minimum_size.x)/2,-240))
	Core.centered_position($Continue,Vector2(-($Continue.custom_minimum_size.x)/2,-120))
	Core.centered_position($Settings,Vector2(-($Settings.custom_minimum_size.x)/2,0))
	Core.centered_position($Exit,Vector2(-($Exit.custom_minimum_size.x)/2,120))
	Core.set_full_size([$Settings_window/Panel,$TextureRect])
	$CPUParticles2D.emission_rect_extents.x = Settings.screen_size.x
	$CPUParticles2D.emitting = true
	$CPUParticles2D2.emitting = true
	
func _on_new_begining_pressed():
	GameScene.new_game()

func _on_continue_pressed():
	GameScene.continue_game()

func _on_exit_pressed():
	get_tree().quit()

func _on_settings_pressed():
	$Settings_window.visible = true
