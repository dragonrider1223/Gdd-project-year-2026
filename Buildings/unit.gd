extends Node2D

@export var speed = 1;

var walking = true;
var targetRotation;

@export var minWaitTime = 1;
@export var maxWaitTime = 5;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	targetRotation = (randf()*2*PI)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(walking):
		rotation = rotate_toward(rotation,targetRotation,speed*delta)
		print(str(rotation)+" - "+str(targetRotation))
		if(rotation==targetRotation||rotation==(-2*PI)+targetRotation):
			walking = false;
			$IdleTimer.wait_time = randf_range(minWaitTime,maxWaitTime)
			$IdleTimer.start()


func _on_idle_timer_timeout() -> void:
	targetRotation = (randf()*2*PI)
	walking = true;
