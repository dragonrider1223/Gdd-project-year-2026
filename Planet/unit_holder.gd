extends Node2D

var activeUnits: int = 0;

var unit = preload("res://Buildings/unit.tscn")
var units: Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	_ChangeUnitCount()

func _ChangeUnitCount():
	if(PlanetResourceHolder.houseFixed):
		if(PlanetResourceHolder.house!=null):
			activeUnits = (PlanetResourceHolder.menPerHouse*PlanetResourceHolder.house.buildingCount) - PlanetResourceHolder.men
			if(units.size()<activeUnits):
				var newUnit = unit.instantiate()
				newUnit.position = $".".position
				$".".add_child(newUnit)
				units.append(newUnit)
			elif (units.size()>activeUnits):
				if(units.back!=null):
					units.back().queue_free()
					units.remove_at(units.size()-1)
