extends Control

func _ready():
	$AnimationPlayer.play("go")
	
func _on_animation_player_animation_finished(_anim_name):
	self.queue_free()
