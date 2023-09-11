extends CanvasLayer

@onready var v_box_container := $Panel/ScrollContainer/VBoxContainer
@onready var panel := $Panel
@onready var text_edit := $Panel/TextEdit

func _ready() -> void:
	visible = false
	
func loading() -> void:
	pass

func add_message(text : String, who : String) -> void:
	var message = Label.new()
	message.size.x = panel.size.x
	message.text = who + ": " + text
	if who=="system":
		message.modulate = Color(0.6,0.6,0.6)
	elif who=="player":
		message.modulate = Color(0.73,0.96,0.83)
	v_box_container.add_child(message)

func _on_button_pressed() -> void:
	add_message(text_edit.text, "player")
	text_edit.text = ''

func _input(_event) -> void:
	if Input.is_action_just_pressed("Enter"):
		if text_edit.text!="":
			_on_button_pressed()
