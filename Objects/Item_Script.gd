extends Node2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		var p := get_parent()
		var id_item : int = p.id	
		GameScript.create_float_label(get_parent().position,"Получен предмет")
		p.item_was_got(body)
		p.queue_free()
