extends SpringArm3D

var camera_rotation = Vector2()
var camera_zoom = 0.0
@export var rotation_speed = 1.0
@export var zoom_speed = 1.0

func _input(event):
	if event is InputEventMouseMotion:
		print(event.relative)
		camera_rotation = event.relative
	elif event.is_action_pressed('mouse_wheel_up'):
		camera_zoom = -1.0
	elif event.is_action_pressed('mouse_wheel_down'):
		camera_zoom = 1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_rotation(delta)
	handle_zoom(delta)
	
func handle_rotation(delta: float):
	self.rotate(self.transform.basis.x, delta * -camera_rotation.y * rotation_speed)
	self.rotate(Vector3.UP, delta * -camera_rotation.x * rotation_speed)

	camera_rotation = Vector2()
	
func handle_zoom(delta:float):
	self.spring_length += camera_zoom * delta * zoom_speed
	camera_zoom = 0.0
