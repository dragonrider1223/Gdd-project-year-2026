extends Control

@onready var stoneCounter = $StoneCpunt
@onready var menHolder = $MenCounter

@onready var houseButton = $MenuHolder/TabContainer/HouseMenu/HouseButton
@onready var mineButton = $MenuHolder/TabContainer/MineMenu/MineButton

@onready var menus:Array = [$MenuHolder/TabContainer/HouseMenu,$MenuHolder/TabContainer/MineMenu] 

var currentState = PlanetResourceHolder.menuState

var  houseCost :int = 10
var  houseUpgradeCost :int = 150
var  mineCost :int = 20
var  mineUpgradeCost :int = 60
var  mineSizeUpgradeCost :int = 300

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
	mineButton.text = "BUY MINE\n"+str(mineCost)+" stone"
	$MenuHolder/TabContainer/HouseMenu/HouseUpgradeButton.text = "UPGRADE HOUSE CAPACITY\n"+str(houseUpgradeCost)+" stone"
	$MenuHolder/TabContainer/MineMenu/MineUpgradeButton.text = "UPGRADE MINE EFFICIENCY\n"+str(mineUpgradeCost)+" stone"
	$MenuHolder/TabContainer/MineMenu/MineUpgradeSizeButton.text = "UPGRADE MINE SIZE\n"+str(mineSizeUpgradeCost)+" stone"
	$MenuHolder.visible = false;
	$UnitMenuBG.visible = false;
	$UnitMenuBG/UnitAlocationMenu/Mines/MineAllocationText.text = "---Mines---\nWorkers allocated: 0/0"


func _on_button_button_down() -> void:	
	if PlanetResourceHolder.house != null:
		if PlanetResourceHolder.stone >= houseCost:
			PlanetResourceHolder.house.buildingCount+=1;
			PlanetResourceHolder.stone-=houseCost
			setCosts();

func _on_mine_button_button_down() -> void:
	if PlanetResourceHolder.mine != null:
		if PlanetResourceHolder.stone >= mineCost:
			PlanetResourceHolder.mine.buildingCount+=1;
			PlanetResourceHolder.stone-=mineCost
			setCosts();


func _on_fix_mine_button_button_down() -> void:
	if PlanetResourceHolder.mine != null:
		if PlanetResourceHolder.stone >= mineCost:
			PlanetResourceHolder.stone-= mineCost
			PlanetResourceHolder.mineFixed = true
			$MenuHolder/TabContainer/MineMenu/FixMineWall.visible = false;
			updateAllocationButtonsAndText()
			

func _on_fix_house_button_button_down() -> void:
	if PlanetResourceHolder.house != null:
		if PlanetResourceHolder.stone >= houseCost/2:
			PlanetResourceHolder.stone-= houseCost/2
			PlanetResourceHolder.houseFixed = true
			$MenCounter.visible = true
			$MenuHolder/TabContainer/HouseMenu/FixeHouseWall.visible = false;
			$UnitMenuBG/UnitAlocationMenu/FixeHouseWall.visible = false;

func setCosts() ->void:
	houseCost = roundi(PlanetResourceHolder.houseCost+pow((PlanetResourceHolder.houseCost),1+(PlanetResourceHolder.houseCostIncrease*(PlanetResourceHolder.house.buildingCount-1))))
	houseButton.text = "BUY HOUSE\n"+str(houseCost)+" stone"
	
	mineCost = roundi(PlanetResourceHolder.mineCost+pow((PlanetResourceHolder.mineCost),1+(PlanetResourceHolder.mineCostIncrease*(PlanetResourceHolder.mine.buildingCount-1))))
	mineButton.text = "BUY MINE\n"+str(mineCost)+" stone"
	
	houseUpgradeCost = roundi(PlanetResourceHolder.houseCost*15+pow((PlanetResourceHolder.houseCost*15),1+(PlanetResourceHolder.houseCostIncrease*(PlanetResourceHolder.menPerHouse-1))))
	$MenuHolder/TabContainer/HouseMenu/HouseUpgradeButton.text = "UPGRADE HOUSE CAPACITY\n"+str(houseUpgradeCost)+" stone"
	
	mineUpgradeCost = roundi(PlanetResourceHolder.mineCost*3+pow((PlanetResourceHolder.mineCost)*3,1+(PlanetResourceHolder.mineCostIncrease*(PlanetResourceHolder.stonePerMine-1))))
	$MenuHolder/TabContainer/MineMenu/MineUpgradeButton.text = "UPGRADE MINE EFFICIENCY\n"+str(mineUpgradeCost)+" stone"
	
	
	mineSizeUpgradeCost = roundi(PlanetResourceHolder.mineCost*15+pow((PlanetResourceHolder.mineCost)*15,1+(PlanetResourceHolder.mineCostIncrease*(PlanetResourceHolder.menPerMine-1))))
	$MenuHolder/TabContainer/MineMenu/MineUpgradeSizeButton.text = "UPGRADE MINE SIZE\n"+str(mineSizeUpgradeCost)+" stone"
	
	updateAllocationButtonsAndText()
	

func updateAllocationButtonsAndText():
	if(PlanetResourceHolder.mineFixed):
		$UnitMenuBG/UnitAlocationMenu/Mines/MineAllocationText.text = "---Mines---\nWorkers allocated: "+str(PlanetResourceHolder.menInMine)+"/"+str(PlanetResourceHolder.menPerMine*PlanetResourceHolder.mine.buildingCount)
	
	PlanetResourceHolder.men = PlanetResourceHolder.menInMine

func _on_close_button_pressed() -> void:
	PlanetResourceHolder.menuState = PlanetResourceHolder.Menu.NONE


func _on_menu_open_button_pressed() -> void:
	PlanetResourceHolder.menuState = PlanetResourceHolder.Menu.HOUSE;


func _on_house_upgrade_button_button_down() -> void:
	if PlanetResourceHolder.house != null:
		if PlanetResourceHolder.stone >= houseUpgradeCost:
			PlanetResourceHolder.menPerHouse+=1;
			PlanetResourceHolder.stone-=houseUpgradeCost
			setCosts();


func _on_mine_button_2_button_down() -> void:
	if PlanetResourceHolder.mine != null:
		if PlanetResourceHolder.stone >= mineUpgradeCost:
			PlanetResourceHolder.stonePerMine+=1;
			PlanetResourceHolder.stone-=mineUpgradeCost
			setCosts();


func _on_unit_menu_open_button_pressed() -> void:
	$UnitMenuBG.visible = true;
	$UnitMenuOpenButton.visible = false;


func _on_close_unit_menu_button_pressed() -> void:
	$UnitMenuBG.visible = false;
	$UnitMenuOpenButton.visible = true;


func _on_remove_units_mine_button_down() -> void:
	if(PlanetResourceHolder.menInMine>0):
		PlanetResourceHolder.menInMine-=1;
		updateAllocationButtonsAndText()


func _on_add_units_mine_button_down() -> void:
	if(PlanetResourceHolder.men<PlanetResourceHolder.menPerMine*PlanetResourceHolder.mine.buildingCount&&PlanetResourceHolder.mineFixed&&PlanetResourceHolder.men<PlanetResourceHolder.menPerHouse*PlanetResourceHolder.house.buildingCount):
		PlanetResourceHolder.menInMine+=1;
		updateAllocationButtonsAndText()


func _on_mine_upgrade_size_button_button_down() -> void:
	if PlanetResourceHolder.mine != null:
		if PlanetResourceHolder.stone >= mineSizeUpgradeCost:
			PlanetResourceHolder.menPerMine+=1;
			PlanetResourceHolder.stone-=mineSizeUpgradeCost
			setCosts();
