extends Node2D

func _ready() -> void:
	_mines();

func _mines():
	while true:
		await get_tree().create_timer(PlanetResourceHolder.timePerMine).timeout 
		if(PlanetResourceHolder.mine!=null&&PlanetResourceHolder.mineFixed):
			PlanetResourceHolder.stone += PlanetResourceHolder.stonePerMine*PlanetResourceHolder.mine.buildingCount
