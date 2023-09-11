extends Node2D

func _on_timer_timeout():
	$AnimationPlayer.play("Logo")
	Core.centered_position($Sprite2D,Vector2(0,0))
	Core.set_full_size([$ColorRect])

func _on_animation_player_animation_finished(_anim_name):
	queue_free()
	
