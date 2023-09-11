extends Panel

func _ready():
	$Panel.visible = false
	
func button_pressed():
	$Panel.visible = false

func _on_ru_pressed():
	button_pressed()

func _on_en_pressed():
	button_pressed()

func _on_button_language_pressed():
	$Panel.visible = true
