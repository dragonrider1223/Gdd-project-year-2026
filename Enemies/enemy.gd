extends Node2D

@export var shooter = false;
@export var moveTime = 10;
@export var planetRadius = 10;
var dist = 1;
@export var orbit = false;
@export var orbitSpeed = 0.1;
@export var health = 10;
@export var shakeCount = 10.0;
var currentShakeCount = 10.0;
@export var maxShakeDist = 10.0;


var startPos;

func _on_static_body_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if  event is InputEventMouseButton and event.pressed:
		damage();

func damage():
	health-=1;
	$knockbackTimer.start(1)
	$whiteFlashTimer.start()
	$shakeTimer.start()
	currentShakeCount = shakeCount
	if(health<=0):
		death()
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".rotate(randf()*PI*2)
	startPos = $Icon.position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(health>0):
		if(shakeCount>0):
			var mult = 1;
			if(floori( currentShakeCount)%2==0):
				mult*=-1
			$Icon.position.x = maxShakeDist *(currentShakeCount/shakeCount)*mult
		else:
			$Icon.transform.x = 0;
		
		if($knockbackTimer.time_left>0):
			dist-=$knockbackTimer.time_left*2*delta
		if($whiteFlashTimer.time_left>0):
			$Icon/Flash.modulate.a = $whiteFlashTimer.time_left*1;
		else:
			$Icon/Flash.modulate.a = 0;
			
		if(PlanetResourceHolder.instance!=null):
			if(orbit):
				$".".rotate(orbitSpeed)
			if(shooter):
				pass;
			else:
				dist+=delta
				$Icon.position.y = lerpf(startPos,0,dist/moveTime)
				if ($Icon.position.y>-planetRadius):
					PlanetResourceHolder.instance._damage(100);
					death()
	else:
		$Icon.self_modulate.a = 0


func _on_shake_timer_timeout() -> void:
	if(currentShakeCount>0):
		currentShakeCount-=1;
		$shakeTimer.start()
		

func death():
	$DeathTImer.start()
	$Icon.texture = null
	$Icon/GPUParticles2D.emitting = true;
	$Icon/GPUParticles2D/GPUParticles2D2.emitting = true;

func _on_death_t_imer_timeout() -> void:
	queue_free()
