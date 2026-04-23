extends Node2D

@onready var image = $Icon

#image scaling vars
var initialImageScale = Vector2(1,1);
var targetImageScale = Vector2(1,1);
var imageScaleTime:float = 0.1; #should be 0.1 to make it take 0.1 second to scale up to size
var currentImageScaleTime:float = 1;
var rotateAmount:float = 0.1;

func _on_static_body_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if  event is InputEventMouseButton and event.pressed:
		PlanetResourceHolder.stone+=1;
		print(PlanetResourceHolder.stone)
		

func _process(delta: float) -> void:
	image.scale = lerp(initialImageScale,targetImageScale,currentImageScaleTime)
	currentImageScaleTime = minf(currentImageScaleTime+(delta*(1/imageScaleTime)),1)
	image.rotate(rotateAmount*delta)
	image.material.set_shader_parameter("pixelCount",(16*image.scale.x));


func _on_static_body_2d_mouse_entered() -> void:
	initialImageScale = image.scale
	targetImageScale = Vector2(1.2,1.2)
	currentImageScaleTime = 0;


func _on_static_body_2d_mouse_exited() -> void:
	initialImageScale = image.scale
	targetImageScale = Vector2(1,1)
	currentImageScaleTime = 0;
