extends RigidBody2D

signal killed

var SPEED = rand_range(50.0, 200.0)

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	linear_velocity = Vector2(0, SPEED)
	if position.y > screen_size.y + 50:
		queue_free()

func die():
	emit_signal("killed")
	queue_free()
