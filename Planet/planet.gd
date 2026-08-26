extends Node2D

@onready var image = $ImageHolder/Icon
@onready var imageHolder = $ImageHolder

#imageHolder shake and grow
var imageHolderRot:float = 0.0;
var shakeCount = -1;
var targetRot:float = 0.5;
var imageShakeTime:float = 0.1;
var currentImageShakeTime:float = 1;
var scaleMult:float = 0.1;

#image scaling vars
var initialImageScale = Vector2(1,1);
var targetImageScale = Vector2(1,1);
var imageScaleTime:float = 0.1; #should be 0.1 to make it take 0.1 second to scale up to size
var currentImageScaleTime:float = 1;
var rotateAmount:float = 0.1;


func _on_static_body_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if  event is InputEventMouseButton and event.pressed:
		PlanetResourceHolder.stone+=1;
		$PlanetHit.pitch_scale = randf_range(0.8,1.2)
		$PlanetHit.play(0)
		shakeCount = 3;

func _process(delta: float) -> void:
	if shakeCount>=0:
		currentImageShakeTime = minf(currentImageShakeTime+(delta*(1/imageShakeTime)),1)
		if(shakeCount>0):
			imageHolder.rotation = lerp(imageHolderRot,targetRot,currentImageShakeTime)
		else:
			imageHolder.rotation = lerp(imageHolderRot,0.0,currentImageShakeTime)
		if(currentImageShakeTime>=1):
			shakeCount-=1;
			initialImageScale = image.scale
			currentImageShakeTime = 0
			imageHolderRot = targetRot
			targetRot*=-1
	image.scale = lerp(initialImageScale,targetImageScale+Vector2(maxf(shakeCount*scaleMult,0),maxf(shakeCount*scaleMult,0)),currentImageScaleTime)
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


func _on_rigid_body_2d_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		_damage(100);

func _damage(amount: float):
	if(amount<=PlanetResourceHolder.stone):
		PlanetResourceHolder.stone-=amount;
	else:
		amount -= PlanetResourceHolder.stone;
		PlanetResourceHolder.stone=0;
		
		while(amount>0):
			if (amount>=100&&PlanetResourceHolder.mine.buildingCount>1):
				PlanetResourceHolder.mine.buildingCount -=1;
				amount -=100
			elif (amount >=10&&PlanetResourceHolder.house.buildingCount>1):
				PlanetResourceHolder.house.buildingCount -=1;
				amount -=10
			else:
				amount -=1;

func _ready() -> void:
	PlanetResourceHolder.instance = self;
