extends Node2D

var can_be_used := false

func _ready():
	pass # Replace with function body.

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		can_be_used = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		can_be_used = false

func _input(_event):
	if Input.is_action_just_pressed("ui_accept"):
		if can_be_used:
			get_parent().interaction()
