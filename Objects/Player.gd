extends CharacterBody2D

var speed := 15

func _physics_process(_delta):
	if Input.is_action_pressed("A"):
		position.x+=-speed
	if Input.is_action_pressed("W"):
		position.y+=-speed
	if Input.is_action_pressed("S"):
		position.y+=speed
	if Input.is_action_pressed("D"):
		position.x+=speed
	move_and_slide()

var parametrs : PackedInt32Array = [10000,1,1,1000,1000,1000,1000,1000,1000,1000,0,0,0,0,0,0]
var is_attacking := true
var type_of_attacking = 'ближний'
var having_mana := false
var invulnerable := false
var eneme_group := "Eneme"

func _ready():
	self.add_to_group("player_objects")
	$Unit_Script.set_values(parametrs, is_attacking,type_of_attacking,having_mana,invulnerable,eneme_group,$CollisionShape2D)
	$Unit_Script.is_player = true
	$Unit_Script.get_node("ProgressBar").visible = false
