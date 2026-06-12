extends Node

enum Menu 
{
	NONE,
	HOUSE,
	MINE
}

static var house = Menu.NONE;
static var houseFixed = false;
static var houseCost = 5;
static var houseCostIncrease = 0.3;

static var mine = Menu.NONE;
static var mineFixed = false;
static var mineCost = 10;
static var mineCostIncrease = 0.2;
static var menPerMine = 1;
static var stonePerMine = 1;
static var timePerMine = 1;
static var menInMine = 0;

static var menuState = Menu.NONE;
static var stone: int = 0;
static var men:int = 0


static var menPerHouse:int = 1
