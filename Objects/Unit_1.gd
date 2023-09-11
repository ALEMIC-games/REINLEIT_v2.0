extends CharacterBody2D

var parametrs : PackedInt32Array = [3000,100,100,500,500,500,510,500,500,100,100,100,100,100,100,100]
var is_attacking := true
var type_of_attacking = 'ближний'
var having_mana := false
var invulnerable := false
var eneme_group := "Player"

func _ready():
	$Unit_Script.set_values(parametrs, is_attacking,type_of_attacking,having_mana,invulnerable,eneme_group,$CollisionShape2D)
	
