extends Node

func loading() -> void:
	pass

var item_list_total := {
	1: {"path" : "res://Objects/Item_1.tscn"}
}

func item_create(item_position : Vector2, type : int) -> void:
	var item = load(item_list_total[type]['path'])
	add_child(item)
