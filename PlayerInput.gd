extends Node

signal move_direction_changed(direction: Vector2)
signal jump_requested

func _unhandled_input(event):
	if event.is_echo():
		pass
	
	if event.is_action_pressed("jump"):
		emit_signal("jump_requested")
	else:
		var horizontal = Input.get_action_strength("right") - Input.get_action_strength("left")
		var vertical = Input.get_action_strength("forward") - Input.get_action_strength("back")
		emit_signal("move_direction_changed", Vector2(vertical,horizontal).normalized())

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
