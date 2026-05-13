extends Node2D

var menuType:PlanetResourceHolder.Menu


func _on_collision_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if  event is InputEventMouseButton and event.pressed:
		PlanetResourceHolder.menuState = menuType;
		print(PlanetResourceHolder.menuState)
