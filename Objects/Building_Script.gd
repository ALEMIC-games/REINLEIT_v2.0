extends Node

var health : int
var defense : int
var current_health : int

func set_values(_health : int, _defense : int, _radius : int) -> void:
	health = _health
	defense = _defense
	current_health = health
	$Area2D/CollisionShape2D.shape.radius = _radius
	get_parent()._radius_area = $Area2D
	
func get_damage(_damage : int) -> void:
	current_health-=(_damage-defense)
	if current_health<=0:
		get_parent().queue_free()

var damage : int

func set_damage(_damage : int) -> void:
	damage = _damage
