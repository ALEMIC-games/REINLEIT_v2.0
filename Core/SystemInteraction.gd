extends CanvasLayer

@onready var obj_bitr_text := $Panel/Label
@onready var a_current_text := 0
@onready var a_step_for_end_text := 0
@onready var node_signal
var action : bool

func  _ready():
	self.visible = false
	
func loading(): 
	Core.centered_position(self,Vector2(0,0))
	
func select_dialog(i: int) -> void: 
	obj_bitr_text.text = 'obj_bitr_text_' + str(i)

func _process(_delta) -> void:
	pass
	#if self.visible:
	#	if Input.is_action_just_pressed("ui_accept"):
	#		if a_step_for_end_text>a_current_text:
	#			a_current_text+=1
	#			select_dialog(a_current_text)
	#		else: 
	#			self.visible = false
	#			set_process(false)
	#			get_tree().paused = false
	#			if action:
	#				node_signal.bitr_signal()
	#				action = false
		
#func show(begin_step: int ,step_to_end : int, node : Variant, _action : bool):
#	visible = true
#	set_process(true)
#	a_current_text = begin_step
#	a_step_for_end_text = a_current_text + step_to_end
#	get_tree().paused = true
#	node_signal = node
#	action = _action
