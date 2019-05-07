extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var Enemy
export (PackedScene) var Player
export (PackedScene) var Player_Bullet

var player_instance
var screen_size

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	randomize()
	start_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func start_game():
	$EnemySpawnTimer.start()
	player_instance = Player.instance()
	add_child(player_instance)
	player_instance.start(Vector2(screen_size.x / 2, screen_size.y - 50))
	$Player.connect("hit", self, "_on_Player_hit")
	$Player.connect("shoot", self, "_on_Player_shoot")
	

func _on_Player_hit():
	# TEMP
	get_tree().reload_current_scene()

func _on_Player_shoot():
	var bullet = Player_Bullet.instance()
	add_child(bullet)
	bullet.position = player_instance.position + Vector2(0, -10)

func _on_EnemySpawnTimer_timeout():
	var enemy = Enemy.instance()
	add_child(enemy)
	enemy.position = Vector2(rand_range(0, get_viewport_rect().size.x), - 50)
	$Enemy.connect("killed", self, "_on_Enemy_killed")

func _on_Enemy_killed():
	score += 1
	if score % 5 == 0:
		$EnemySpawnTimer.wait_time *= 0.95
