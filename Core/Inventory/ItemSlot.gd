extends Button
var item_slot_index : int
var item_slot_have_item := false

func _on_pressed() -> void:
	if Inventory.item_is_selected and item_slot_have_item==false:
		if Inventory.current_item_slot.item_slot_index==item_slot_index:
			Inventory.delete_selected_item()
		else: 
			var r : TextureRect = Inventory.current_selected_item
			Inventory.add_item(r.item_id,r.number,item_slot_index)
	elif item_slot_have_item:
		Inventory.selected_item(item_slot_index)
	
func _on_mouse_entered():
	if item_slot_have_item:
		Inventory.set_item_description(self.position,get_child(0).item_id)
