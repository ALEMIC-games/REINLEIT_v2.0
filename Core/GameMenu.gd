extends CanvasLayer

func loading():
	Core.set_full_size([$Panel,$TextureRect])
	Core.centered_position($Continue, Vector2(($Continue.custom_minimum_size.x)/-2,-240))
	Core.centered_position($ReturnToMenu, Vector2(($ReturnToMenu.custom_minimum_size.x/-2),-120))
	Core.centered_position($Reference, Vector2(($Reference.custom_minimum_size.x/-2),0))
	Core.centered_position($"Exit from game", Vector2(($"Exit from game".custom_minimum_size.x/-2),120))

func _ready():
	visible = false

func _input(_event):
	if Input.is_action_just_pressed("Close"):
		if GameScene.game_is_running:
			if visible:
				visible = false
				get_tree().paused = false
			else: 
				visible = true
				get_tree().paused = true

func _on_continue_pressed():
	visible = false
	get_tree().paused = false

func _on_reference_pressed():
	pass # Replace with function body.

func _on_exit_from_game_pressed():
	get_tree().quit()

func _on_return_to_menu_pressed():
	Transition.next_scene("return_to_menu")
