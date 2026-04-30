extends Node2D



func _on_collision_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if  event is InputEventMouseButton and event.pressed:
		PlanetResourceHolder.menuState = PlanetResourceHolder.Menu.HOUSE;
		print(PlanetResourceHolder.menuState)
