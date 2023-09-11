extends Sprite2D

var id := 1
var title := "Первый предмет"

func item_was_got(body):
	body.get_node("Unit_Script").health_recovery(100)
