extends Node2D

@export var buildingCount = 3;

@export var offset = 0;
var BuildingBlocks: Array[Node2D]

@onready var blockHolder = $BlockHolder
var block = preload("res://Buildings/building_block.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	orderBuildings()

func orderBuildings():
	for blocks in BuildingBlocks:
		blocks.queue_free()
	BuildingBlocks = []
	for i in (buildingCount):
		var newBlock = block.instantiate()
		newBlock.position = blockHolder.position+ Vector2(0,offset*i)
		blockHolder.add_child(newBlock)
		BuildingBlocks.append(newBlock)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	orderBuildings()
