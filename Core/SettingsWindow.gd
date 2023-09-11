extends Control

func _process(_delta):
	if Input.is_action_just_pressed("Close"):
		self.visible = false
		
func _on_button_return_pressed():
	self.visible = false
