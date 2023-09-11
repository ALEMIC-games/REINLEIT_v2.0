extends Node2D

var _health := 700
var _defense := 1
var be_allowed_to_entered := false
var _radius := 400
@warning_ignore("unused_private_class_variable")
var _radius_area : Area2D

func _ready() -> void:
	$Building_area.visible = false
	self.set_process(false)
	$Building_Script.set_values(_health,_defense,_radius)
	
func _on_area_2d_body_entered(body) -> void:
	if be_allowed_to_entered:
		if body.is_in_group("Player"):
			$ColorRect.visible = true
			self.set_process(true)

func _on_area_2d_body_exited(body) -> void:
	if body.is_in_group("Player"):
		$ColorRect.visible = false
		self.set_process(false)

func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		pass
	
	
