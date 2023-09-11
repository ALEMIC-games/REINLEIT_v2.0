extends Node

var UI : Array
func loading():
	UI = [UiPlayerActives,UiPlayerMap,SystemInteraction,Inventory, UiPlayerQuestions]

var screen_size : Vector2
func centered_position(node : Variant, add_point : Vector2) -> void:
	screen_size = Settings.screen_size
	node.position = Vector2(screen_size.x/2,screen_size.y/2) + add_point
	
func set_full_size(node_group : Array) -> void:
	for node in node_group:
		node.size = Settings.screen_size
		
func create_float_label(point : Vector2, text : String) -> void:
	var float_label := preload("res://Other/float_label.tscn").instantiate()
	GameScene.add_child(float_label)
	float_label.get_node("float_text").position = point
	float_label.get_node("float_text").text = text

func _process(_delta):
	if Input.is_action_just_pressed("Console"):
		if Console.visible:
			Console.visible = false
		else: Console.visible = true
