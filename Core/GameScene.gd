extends Node2D

var game_is_running := false

func _ready() -> void:
	visible = false
	
func loading() -> void:
	#var x : int = 0
	#var y : int = 0
	#for i in range(0,50):
	#	var ter = preload("res://Scenes/Map/Decor/Terrain_3.tscn").instantiate()
	#	self.add_child(ter)
	#	x+=256
	#	if x==256*6:
	#		y+=192
	#		x = 0
	#	ter.position.x = x
	#	ter.position.y = y
	var player = preload("res://Objects/Player.tscn").instantiate()
	player.position = Vector2(400,0)
	add_child(player)
		
func new_game() -> void:
	for child in $Terrain.get_children():
		child.queue_free()
	Transition.next_scene("new_game")

func continue_game() -> void:
	Transition.next_scene("continue")
