extends Node2D

var health:= 0
var health_reg:= 0
var current_health:= 0
var health_percent : float = 1

var defense := 0
var invulnerable := false

var mana:= 0
var mana_reg:= 0
var current_mana:= 0
var mana_percent : float = 1
var having_mana := false

var is_attacking := false
var damage := 0 
var damage_percent : float = 1
var range_of_attacking := 0
var type_of_attacking : String

var eneme_group : String
var is_player := false
var self_collision_shape
var range_of_looking := 0
var attack_speed : float = 1
func set_values(array : PackedInt32Array, _is_attacking: bool, _type_of_attacking : String, _having_mana : bool, _invulnerable : bool, _eneme_group : String, _self_collision_shape) -> void:
	
	self_collision_shape = _self_collision_shape
	health = array[0]
	health_reg = array[1]
	current_health = health
	$RangeOfLooking/CollisionShape2D.shape.radius = range_of_looking
	$CD.wait_time = attack_speed
	$ProgressBar.max_value = health
	$ProgressBar.value = health

	defense = array[2]
	
	having_mana = _having_mana
	if having_mana:
		mana = array[3]
		mana_reg = array[4]
		current_mana = mana

	is_attacking = _is_attacking
	if is_attacking:
		damage = array[5]
		range_of_attacking = array[6]
		$Area2D/CollisionShape2D.shape.radius = range_of_attacking
		type_of_attacking = _type_of_attacking
		if type_of_attacking == 'ближний':
			pass
		elif type_of_attacking == 'дальний':
			pass
			
	invulnerable = _invulnerable
	
	eneme_group = _eneme_group
	
func get_damage(_damage : int) -> bool:
	var total_damage = _damage-defense
	if invulnerable==false:
		if total_damage>0:
			current_health-=total_damage
			$ProgressBar.value = current_health
			Core.create_float_label(get_parent().position,str(total_damage))
			health_percent = float(current_health)/float(health)
			if is_player:
				UiPlayerActives.hp.change(current_health,health)
			if current_health<=0:
				is_living = false
				target_name = get_parent().name
				get_parent().queue_free()
				return true
			else: return false
		else:
			Core.create_float_label(get_parent().position,'0')
			return false
	else:
		Core.create_float_label(get_parent().position,'0')
		return false

@onready var cd := $CD
var target 
var target_in_range := false
var count_objects_around := 0
var is_living := true

func _on_area_2d_body_entered(body : CharacterBody2D) -> void:
	var objects_around : Array = $Area2D.get_overlapping_bodies()
	if body.is_in_group(eneme_group):
		#Initialization.Game_UI.get_node("count").text = str(body) + str(eneme_group) + '/n'+ str(objects_around)
		if cd.is_stopped():
			if target==null:
				target = body
				target_name = target.name
				target_in_range = true
				attack()

var target_name := ''
func attack() -> void:
	cd.start()
	var total_damage : int = damage*int(damage_percent)
	if target.get_node("Unit_Script").get_damage(total_damage):
		pass
			
func _on_cd_timeout() -> void:
	if target!=null:
		if target_in_range:
			attack()

func target_next(body : CharacterBody2D) -> void:
	var objects_around = $Area2D.get_overlapping_bodies()
	count_objects_around = len(objects_around)
	if is_player:
		#Initialization.Game_UI.get_node("count").text = str(body)+ "умер" + target_name + str(objects_around)
		pass
	if count_objects_around>0:
		#Initialization.Game_UI.get_node("count").text += "умер"
		for i in objects_around:
			if i!=get_parent():
				if i.is_in_group(eneme_group):
					if body!=i:
						target = i
						target_in_range = true
						#Initialization.Game_UI.get_node("count").text += str(target)
						break
	else: 
		target_in_range = false
		target = null
							
func _on_area_2d_body_exited(body : CharacterBody2D) -> void:
	if body.is_in_group("target_object"):
		if body.get_node("Unit_Script").is_living:
			if body == target:
				target_in_range = false
				target = null
				#Initialization.Game_UI.get_node("count").text = "вышел"
				target_next(body)
		else:
			target_next(body)

		
		
func _on_recovery_timeout() -> void:
	if current_health<health:
		current_health+=health_reg
	if current_mana<mana:
		current_mana+=mana_reg
	$ProgressBar.value = current_health
	if get_parent().is_in_group("Player"):
		UiPlayerActives.hp.change(current_health,health)
#Восстановление здоровья (желательно вынести отдельно)		
var additional_health_recovery := 0 
var percent_health_recovery : float = 1
func health_recovery(value : int) -> void:
	var total_value := value*int(percent_health_recovery)+additional_health_recovery
	if current_health==health:
		pass
	elif current_health<health and health-current_health>total_value:
		current_health+=total_value
	elif current_health<health and health-current_health<total_value:
		current_health=health
	if get_parent().is_in_group("Player"):
		UiPlayerActives.hp.change(current_health,health)
	
#вынести создание вспывающих текстовых надписей и цифр
