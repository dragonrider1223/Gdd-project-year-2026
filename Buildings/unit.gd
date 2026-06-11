extends Node2D

@export var speed = 1;

var walking = true;
var targetRotation;

@export var minWaitTime = 1;
@export var maxWaitTime = 5;


@export var wiggleRoom = 0.1;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	targetRotation = (randf()*2*PI)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(walking):
		rotation = rotate_toward(rotation,targetRotation,speed*delta)
		if(rotation<0):
			rotation = (2*PI)+rotation
		if(rotation>2*PI):
			rotation = rotation-(2*PI)
		if(rotation<=targetRotation+wiggleRoom&&rotation>=targetRotation-wiggleRoom):
			walking = false;
			$IdleTimer.wait_time = randf_range(minWaitTime,maxWaitTime)
			$IdleTimer.start()


func _on_idle_timer_timeout() -> void:
	targetRotation = (randf()*2*PI)
	walking = true;
