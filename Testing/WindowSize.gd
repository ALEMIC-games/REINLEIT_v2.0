extends Panel

func _ready() -> void:
	$Panel.visible = false

func button_pressed(i : int) -> void:
	$Panel.visible = false
	Settings.display_index = i
	
func _on_ui_button_pressed() -> void:
	$Panel.visible = true
	
func _on_ui_button_2_pressed() -> void:
	button_pressed(1)

func _on_ui_button_3_pressed() -> void:
	button_pressed(2)

func _on_ui_button_4_pressed() -> void:
	button_pressed(3)

func _on_ui_button_5_pressed() -> void:
	button_pressed(0)
	
