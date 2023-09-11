extends CanvasLayer

@onready var grid_container := $Panel/InventoryWindow/ScrollContainer/ItemList
@onready var animation_player := $AnimationPlayer
@onready var inventory_window := $Panel/InventoryWindow

var slot_free_array : Array = []
var slot_array : Array = []
var show := false

var slots_count : int = 18

func _ready() -> void:
	self.set_physics_process(false)
	self.visible = false
	inventory_window.visible = false
	
func loading() -> void:
	$Panel.position = Vector2(Settings.screen_size.x-150,Settings.screen_size.y/2-200)
	for i in range(0,slots_count):
		var slot : Button = preload("res://Core/Inventory/ItemSlot.tscn").instantiate()
		slot.item_slot_index = i
		grid_container.add_child(slot)
		slot_array.append(slot)
		slot_free_array.append(true)
	add_item(1,4,0)

var current_item_slot : Button
var current_item_selected : TextureRect
var current_selected_item : TextureRect
var item_is_selected := false
	
func selected_item(index : int) -> void: 
	current_selected_item = current_item_slot.get_child(0)
	current_item_slot = slot_array[index]
	var item_selected = preload("res://Core/Inventory/ItemIcon.tscn").instantiate()
	item_selected.modulate = Color(1,1,1,0.8)
	current_item_selected = item_selected
	Inventory.add_child(item_selected)
	self.set_physics_process(true)
	current_selected_item.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	item_is_selected = true
	
func _physics_process(_delta):
	current_item_selected.position = MousePoint.position
	if Input.is_action_just_pressed("left_click"):
		pass
		#delete_selected_item()
		#current_item_slot.item_slot_have_item = false
		#current_selected_item.queue_free()
		#current_item_selected.queue_free()
	elif Input.is_action_just_pressed("right_click"):
		delete_selected_item()
		
func delete_selected_item() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	self.set_physics_process(false)
	current_item_selected.queue_free()
	current_selected_item.visible = true
	item_is_selected = false
	
func add_item(item_id : int, number : int, point : int) -> void:
	for i in slots_count:
		if slot_free_array[i]:
			if point==i:
				current_item_slot = slot_array[i]
				current_item_slot.item_slot_index = i
				current_item_slot.item_slot_have_item = true
				slot_free_array[i] = false
				break
	var item_icon : TextureRect = preload("res://Core/Inventory/ItemIcon.tscn").instantiate()
	current_item_slot.add_child(item_icon)
	item_icon.item_id = item_id
	item_icon.texture = item_dictionary[item_id]['icon']
	item_icon.get_node("Count").text = str(number)
	item_icon.number = number

@onready var item_description := $Panel/InventoryWindow/ItemDescription
@onready var title := $Panel/InventoryWindow/ItemDescription/Title
@onready var description := $Panel/InventoryWindow/ItemDescription/Description
func set_item_description(point : Vector2, item_id : int) -> void:
	item_description.visible = true
	item_description.position = point + Vector2(-350,0)
	title.text = 'item_title_' + str(item_id)
	description.text = 'item_description_' + str(item_id)
#Inventory.item_description.visible = false
	
var item_dictionary := {
	1: {'max_number': 1, 'icon' : preload("res://Resources/icon.svg")}
}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

func close() -> void:
	animation_player.play("close")
	
func open() -> void:
	animation_player.play("open")

func _on_animation_player_animation_finished(anim_name : String) -> void:
	if anim_name=="close":
		show = false
	elif anim_name=="open":
		show = true

func _on_inventory_button_pressed() -> void:
	if Inventory.show:
		Inventory.close()
	else:
		Inventory.open()
