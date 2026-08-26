extends Panel

func _on_button_pressed() -> void:
	$".".hide()
	$"../ScrapMetalCount".show()
	PlanetResourceHolder.enemyManager.startSpawning()
