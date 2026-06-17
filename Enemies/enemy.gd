extends Node2D

@export var shooter = false;
@export var moveTime = 10;
var dist = 1;
@export var orbit = false;
@export var orbitSpeed = 0.1;

var startPos;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".rotate(randf()*PI*2)
	startPos = $Icon.position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(orbit):
		$".".rotate(orbitSpeed)
	if(shooter):
		pass;
	else:
		$Icon.position.y = lerpf(startPos,0,dist/moveTime)
		dist+=delta
