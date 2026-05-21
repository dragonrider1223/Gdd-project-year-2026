extends Node2D

var menuType:PlanetResourceHolder.Menu
@onready var houseSprite = preload("res://Buildings/house.png");


func _on_collision_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if  event is InputEventMouseButton and event.pressed:
		PlanetResourceHolder.menuState = menuType;
		print(PlanetResourceHolder.menuState)

func setSprite():
	if(menuType==PlanetResourceHolder.Menu.HOUSE):
		$Collision/Icon.texture = houseSprite
