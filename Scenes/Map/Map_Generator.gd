extends Node

var map
@export var map_x : int = 7900
@export var map_y : int = 3900

func loading():
	pass

func _ready():
	pass

func generate_map_start():
	map = GameScene
	#Terrain_layer #1
	var terrain_layer : Node2D = map.get_node("Terrain")
	var x : int = 0
	var y : int = 0
	var terrain_layer_1_is_genereting := true
	var terrain_color : PackedColorArray = [Color(1,1,1),Color(0.67,1,0.86),Color(0.85,0.96,0.72),Color(0.98,0.91,0.73),Color(0.85,1,0.43)]
	var terrain_grass_array : Array = []
	var terrain_tree_array_used : Array = []
	#заполняем карту лугами
	while terrain_layer_1_is_genereting:
		x+=randi_range(80,200)
		if x>map_x:
			x=0
			y+=randi_range(100,140)
		if y>=map_y:
			terrain_layer_1_is_genereting = false
			break
		var terrain = preload("res://Scenes/Map/Decor/Terrain.tscn").instantiate()
		terrain_grass_array.append(terrain)
		terrain_tree_array_used.append(false)
		terrain.position = Vector2(x,y+randi_range(-30,30))
		terrain.rotation_degrees = randf_range(-10,10)
		terrain.self_modulate = terrain_color[randi_range(0,4)]
		if randf_range(0,1)==1:
			terrain.flip_v = true
		terrain_layer.add_child(terrain)
	#травка по лугам	
	var scale : float	
	var flower_sprite := [
		load("res://Resources/Gress.png"),
		load("res://Resources/Gress_2.png"),
		load("res://Resources/Gress_3.png"),
		load("res://Resources/Gress_4.png")]
	for i in terrain_grass_array:
		var flower = preload("res://Scenes/Map/Decor/flower.tscn").instantiate()
		flower.position = Vector2(i.position.x+randi_range(-100,100),i.position.y+randi_range(-100,100))
		flower.self_modulate = terrain_color[randi_range(0,4)]
		flower.texture = flower_sprite[randi_range(0,3)]
		scale = randf_range(0.5,1)
		flower.set_scale(Vector2(scale,scale))
		terrain_layer.add_child(flower)	
	#создаём землю под камни	
	var stone_terrain_array : Array = []
	var stone_terrain_array_used : Array = []
	var random_point : Vector2
	for i in range(0,5):
		random_point = Vector2(randi_range(0,map_x),randi_range(0,map_y))
		for r in range(0,4):
			var stone_terrain = preload("res://Scenes/Map/Decor/stone_terrain.tscn").instantiate()
			var random_point_around := Vector2(randi_range(-100,100),randi_range(-100,100))
			stone_terrain.position = random_point+random_point_around
			terrain_layer.add_child(stone_terrain)
			stone_terrain_array.append(stone_terrain)
			stone_terrain_array_used.append(false)
			
	var len_stone_terrain_array : int = len(stone_terrain_array)
	var number : int
	var stop_select : bool
	#Создаём камни
	for i in range(0,18)	:
		var stone = preload("res://Scenes/Map/Decor/stone.tscn").instantiate()
		stop_select = true
		while stop_select:
			number = randf_range(0,len_stone_terrain_array)
			if stone_terrain_array_used[number]==false:
				stop_select = false
				stone_terrain_array_used[number] = true
		
		stone.position = stone_terrain_array[number].position
		scale = randf_range(0.2,1)
		stone.set_scale(Vector2(scale,scale))
		terrain_layer.add_child(stone)
	
	var terrain_tree_array_used_count : int = len(terrain_tree_array_used)
	for i in range(0,12):
		var tree_terrain = preload("res://Scenes/Map/Decor/stone_terrain.tscn").instantiate()
		var tree = preload("res://Scenes/Map/Decor/tree.tscn").instantiate()
		stop_select = true
		while stop_select:
			number = randi_range(0,terrain_tree_array_used_count)
			if terrain_tree_array_used[number]==false:
				stop_select = false
				terrain_tree_array_used[number] = true
		scale = randf_range(0.5,1.4)
		tree_terrain.position = terrain_grass_array[number].position+Vector2(0,120)
		tree_terrain.set_scale(Vector2(scale,scale))
		tree_terrain.self_modulate = Color(0.67,0.49,0.29)
		tree_terrain.rotation_degrees = randf_range(-30,30)
		terrain_layer.add_child(tree_terrain)
		tree.position = terrain_grass_array[number].position
		tree.self_modulate = terrain_color[randi_range(0,4)]
		tree.set_scale(Vector2(scale,scale))
		terrain_layer.add_child(tree)
		
		
	random_point = Vector2(randi_range(700,map_x-700),randi_range(700,map_y-700))
	
	for i in range(0,8):
		var chaim = preload("res://Scenes/Map/Decor/shaim.tscn").instantiate()
		chaim.position = random_point + Vector2(-400+140*i,-400)
		terrain_layer.add_child(chaim)
	for i in range(0,5):
		var chaim = preload("res://Scenes/Map/Decor/shaim.tscn").instantiate()
		chaim.position = random_point + Vector2(-400,-400+140*i)
		terrain_layer.add_child(chaim)
	for i in range(0,5):
		var chaim = preload("res://Scenes/Map/Decor/shaim.tscn").instantiate()
		chaim.position = random_point + Vector2(600,-400+140*i)
		terrain_layer.add_child(chaim)
			
	var town_hall = preload("res://Objects/Building_1.tscn").instantiate()
	town_hall.position = random_point
	terrain_layer.add_child(town_hall)
	
	
	
	#for r in town_hall._radius_area.get_overlapping_bodies():
	#	if r.is_in_group("Collider"):
	#		r.queue_free()
		
	var NPC_1 = preload("res://Objects/NPC_1.tscn").instantiate()
	NPC_1.position = random_point + Vector2(-170,240)
	terrain_layer.add_child(NPC_1)
	
	#границы карты
	var border_top = preload("res://Scenes/Map/Decor/Border_map.tscn").instantiate()
	border_top.position = Vector2(0,0)
	border_top.size = Vector2(map_x,32)
	border_top.get_node("StaticBody2D/CollisionShape2D").shape.size = Vector2(map_x*2,32)
	terrain_layer.add_child(border_top)
	var border_bottom = preload("res://Scenes/Map/Decor/Border_map.tscn").instantiate()
	border_bottom.position = Vector2(0,map_y)
	border_bottom.size = Vector2(map_x,32)
	border_bottom.get_node("StaticBody2D/CollisionShape2D").shape.size = Vector2(map_x*2,32)
	terrain_layer.add_child(border_bottom)
	var border_left = preload("res://Scenes/Map/Decor/Border_map.tscn").instantiate()
	border_left.position = Vector2(0,0)
	border_left.size = Vector2(32,map_y)
	border_left.get_node("StaticBody2D/CollisionShape2D").shape.size = Vector2(32,map_y)
	terrain_layer.add_child(border_left)
	var border_right = preload("res://Scenes/Map/Decor/Border_map.tscn").instantiate()
	border_right.position = Vector2(map_x,0)
	border_right.size = Vector2(32,map_y+32)
	border_right.get_node("StaticBody2D/CollisionShape2D").shape.size = Vector2(32,map_y)
	terrain_layer.add_child(border_right)
	
	
	random_point = Vector2(randi_range(700,map_x-700),randi_range(700,map_y-700))
	var dungeon = preload("res://Objects/Building_2.tscn").instantiate()
	dungeon.position = random_point
	terrain_layer.add_child(dungeon)
	
	for i in range(0,2):
		var unit = preload("res://Objects/Unit_1.tscn").instantiate()
		unit.position = random_point + Vector2(300+i*150,400)
		terrain_layer.add_child(unit)
	
	#var player = preload("res://Objects/Player.tscn").instantiate()
	#player.position = town_hall.position + Vector2(0,100)
	#terrain_layer.add_child(player)
		
	

		
			
		
	
