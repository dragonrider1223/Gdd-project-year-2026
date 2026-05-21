extends Control

@onready var stoneCounter = $StoneCpunt
@onready var menHolder = $MenCounter

@onready var houseButton = $MenuHolder/TabContainer/HouseMenu/HouseButton
@onready var mineButton = $MenuHolder/TabContainer/MineMenu/MineButton

@onready var menus:Array = [$MenuHolder/TabContainer/HouseMenu,$MenuHolder/TabContainer/MineMenu] 

var currentState = PlanetResourceHolder.menuState

var  houseCost :int = 10
var  mineCost :int = 100

# TODO: add menu buttons to not have to click the house / change to a tab system

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	stoneCounter.text = str(PlanetResourceHolder.stone)+" stone"
	menHolder.text ="occupied workers: "+str(PlanetResourceHolder.men)+"/"+str(PlanetResourceHolder.menPerHouse*PlanetResourceHolder.house.buildingCount)
	if(PlanetResourceHolder.menuState!=currentState):
		currentState =PlanetResourceHolder.menuState
		if(currentState==PlanetResourceHolder.Menu.NONE):
			$MenuHolder.visible = false;
			$MenuOpenButton.visible = true;
		else:
			$MenuOpenButton.visible = false;
			$MenuHolder.visible = true;
			for i in menus:
				i.visible = false;
			menus[currentState-1].visible = true;

func _ready() -> void:
	houseButton.text = "BUY HOUSE\n"+str(houseCost)+" stone"
	mineButton.text = "BUY MINE\n"+str(mineCost)+" stone\n"+str(PlanetResourceHolder.menPerMine)+" workers"
	$MenuHolder.visible = false;


func _on_button_button_down() -> void:	
	if PlanetResourceHolder.house != null:
		if PlanetResourceHolder.stone >= houseCost:
			PlanetResourceHolder.house.buildingCount+=1;
			PlanetResourceHolder.stone-=houseCost
			setCosts();

func _on_mine_button_button_down() -> void:
	if PlanetResourceHolder.mine != null:
		if PlanetResourceHolder.stone >= mineCost&&(PlanetResourceHolder.menPerHouse*PlanetResourceHolder.house.buildingCount)-PlanetResourceHolder.men>=PlanetResourceHolder.menPerMine:
			PlanetResourceHolder.mine.buildingCount+=1;
			PlanetResourceHolder.men+=PlanetResourceHolder.menPerMine
			PlanetResourceHolder.stone-=mineCost
			setCosts();


func _on_fix_mine_button_button_down() -> void:
	if PlanetResourceHolder.mine != null:
		if PlanetResourceHolder.stone >= mineCost&&(PlanetResourceHolder.menPerHouse*PlanetResourceHolder.house.buildingCount)-PlanetResourceHolder.men>=PlanetResourceHolder.menPerMine*3:
			PlanetResourceHolder.stone-= mineCost
			PlanetResourceHolder.men+=PlanetResourceHolder.menPerMine*3
			PlanetResourceHolder.mineFixed = true
			$MenuHolder/TabContainer/MineMenu/FixMineWall.visible = false;
			

func _on_fix_house_button_button_down() -> void:
	if PlanetResourceHolder.house != null:
		if PlanetResourceHolder.stone >= houseCost/2:
			PlanetResourceHolder.stone-= houseCost/2
			$MenCounter.visible = true
			$MenuHolder/TabContainer/HouseMenu/FixeHouseWall.visible = false;

func setCosts() ->void:
	houseCost = roundi(PlanetResourceHolder.houseCost+pow((PlanetResourceHolder.houseCost),1+(PlanetResourceHolder.houseCostIncrease*(PlanetResourceHolder.house.buildingCount-1))))
	houseButton.text = "BUY HOUSE\n"+str(houseCost)+" stone"
	
	mineCost = roundi(PlanetResourceHolder.mineCost+pow((PlanetResourceHolder.mineCost),1+(PlanetResourceHolder.mineCostIncrease*(PlanetResourceHolder.mine.buildingCount-1))))
	mineButton.text = "BUY MINE\n"+str(mineCost)+" stone\n"+str(PlanetResourceHolder.menPerMine)+" workers"

func _on_close_button_pressed() -> void:
	PlanetResourceHolder.menuState = PlanetResourceHolder.Menu.NONE


func _on_menu_open_button_pressed() -> void:
	PlanetResourceHolder.menuState = PlanetResourceHolder.Menu.HOUSE;
