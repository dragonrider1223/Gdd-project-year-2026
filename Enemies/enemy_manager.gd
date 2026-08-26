extends Node2D

@onready var enemy = preload("res://Enemies/Enemy.tscn");

@export var maxTime = 60
@export var minTime = 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlanetResourceHolder.enemyManager = self

func startSpawning():
	$EnemySpawnTimer.wait_time = randf_range(minTime,maxTime)
	PlanetResourceHolder.EnemyBar.max_value = $EnemySpawnTimer.wait_time
	$EnemySpawnTimer.start()
	PlanetResourceHolder.EnemyBar.show()

func _on_enemy_spawn_timer_timeout() -> void:
	PlanetResourceHolder.EnemyBar.max_value = $EnemySpawnTimer.wait_time
	$EnemySpawnTimer.wait_time = randf_range(minTime,maxTime)
	spawn()

func _process(delta: float) -> void:
	PlanetResourceHolder.EnemyBar.value = $EnemySpawnTimer.time_left

func spawn():
	var newEnemy = enemy.instantiate()
	self.add_child(newEnemy)
