extends Node2D

var fadingOut = false

func _ready() -> void:
	PlanetResourceHolder.musicManager = self

func FadeVolume(out: bool):
	fadingOut = out
	$FadeTimer.start(0)

func _process(delta: float) -> void:
	if(fadingOut):
		$Music.volume_linear = $FadeTimer.time_left
	else:
		$Music.volume_linear = 1-$FadeTimer.time_left
