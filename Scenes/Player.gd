extends Area2D

signal hit
signal shoot

const SPEED = 20.0
var screen_size
var reloading = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement(delta)
	shooting(delta)

func shooting(delta):
	if Input.is_action_pressed("shoot") && !reloading:
		shoot()

func shoot():
	emit_signal("shoot")
	$shoot_cooldown.start()
	reloading = true

# Moves the player towards the mouse
func movement(delta):
	# Direction is not normalized as this allows for smooth movement.
	# Could apply some math, eg. log, to change movement behaviour.
	var direction = (get_global_mouse_position() - position)
	var velocity = direction * SPEED
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.call_deferred("set_disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_shoot_cooldown_timeout():
	reloading = false
