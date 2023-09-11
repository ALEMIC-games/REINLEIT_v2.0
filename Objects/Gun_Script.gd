extends Node2D

var gun_sprite : Sprite2D 

func _ready():
	gun_sprite = get_parent().get_node("Sprite2D")
	
func _physics_process(_delta):
	gun_sprite.look_at(MousePoint.position)
	if Input.is_action_just_pressed("left_click"):
		var bullet = preload("res://Objects/Bullet.tscn").instantiate()
		GameScene.add_child(bullet)
		bullet.angle = get_angle_to(MousePoint.position)
		#dssdbullet.position = get_parent().get_parent().position + Vector2(10d0,0)
		#get_node("Sprite2D").get_node("Marker2D").get_global_position()
	pass
	var gun_rotation : float = gun_sprite.rotation_degrees
	$Label.text = str(gun_sprite.rotation_degrees)
	if -180<gun_rotation and gun_rotation<180:
		gun_sprite.flip_h = true
	else:
		gun_sprite.flip_h = false
	
