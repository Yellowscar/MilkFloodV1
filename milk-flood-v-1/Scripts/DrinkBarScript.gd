extends Node

#BoobManager
@onready var BoobManager = %BoobManager

#Stimulation Bar, aka Stim Bar
@onready var StimBar = %Stimbar
var Stimulation: float = 0
var PlayerClimaxing: bool = false

#Drink Button Variables
var IsBestMilkButtonPressed = false
var IsWaterButtonPressed = false
var IsRootBeerButtonPressed = false
var IsBeerButtonPressed = false
var IsDrinkMilkButtonPressed = false

# Drink Bar Variables
@onready var BestMilkBar = %BestMilkBar
@onready var DrinkMilkBar = %DrinkMilkBar
@onready var BeerBar = %BeerBar
@onready var RootBeerBar = %RootBeerBar
@onready var WaterBar = %WaterBar

@export_range(0.0, 100.0) var BestMilk: float = 0
@export_range(0.0, 100.0) var Milk: float = 0
@export_range(0.0, 100.0) var Beer: float = 0
@export_range(0.0, 100.0) var RootBeer: float = 0
@export_range(0.0, 100.0) var Water: float = 0

var TrueBestMilk = BestMilk
var TrueMilk = Milk + TrueBestMilk
var TrueBeer = Beer + TrueMilk
var TrueRootBeer = RootBeer + TrueBeer
var TrueWater = Water + TrueRootBeer


#PlayerMilk
@export_range(0.0, 100.0) var PlayerMilk: float = 0
@export var BellModifier: float = 1
@onready var PlayerMilkBar = $PlayerMilkBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var BestMilkBarValue = BestMilkBar.value
	#var DrinkMilkBarValue = DrinkMilkBar.value
	#var BeerBarValue = BeerBar.value
	#var RootBeerBarValue = RootBeerBar.value
	#var WaterBarValue =  WaterBar.value
	
	#handle drink buttons and BestMilk button
	if IsWaterButtonPressed == true and PlayerClimaxing == false: 
		Water += 40*delta
	if IsRootBeerButtonPressed == true and PlayerClimaxing == false:
		RootBeer += 40*delta
	if IsBeerButtonPressed == true and PlayerClimaxing == false:
		Beer += 40*delta
	if IsDrinkMilkButtonPressed == true and PlayerClimaxing == false:
		Milk += 40*delta
	
	#handles milking
	if IsBestMilkButtonPressed == true and PlayerClimaxing == false:
		BestMilk += 40 * delta
		Stimulation += 25 * delta
		PlayerMilk -= 15*delta
	
	#handles stimulation
	%Stimbar.value = Stimulation
	Stimulation -= 5 * delta
	
	if Stimulation > 99:
		PlayerClimaxing = true
	
	if Stimulation < 1:
		PlayerClimaxing = false
	
	if PlayerClimaxing == true:
		Stimulation -= 50 * delta
	
	#Texturebar offset
	TrueBestMilk = BestMilk
	TrueMilk = Milk + TrueBestMilk
	TrueBeer = Beer + TrueMilk
	TrueRootBeer = RootBeer + TrueBeer
	TrueWater = Water + TrueRootBeer
	
	#Bestmilk vairable
	
	%BestMilkBar.value = TrueBestMilk
	%DrinkMilkBar.value = TrueMilk
	%BeerBar.value = TrueBeer
	%RootBeerBar.value = TrueRootBeer
	%WaterBar.value = TrueWater
	
	#Variable Limits
	if PlayerMilk > 100:
		PlayerMilk = 100
	if PlayerMilk < 0:
		PlayerMilk = 0
	if Stimulation > 100:
		Stimulation = 100
	if Stimulation < 0:
		Stimulation = 0
	
	var BoobStage = 1
	
#	if PlayerMilk < 31:
#		BoobStage = 1
#	
#	if PlayerMilk > 30:
#		BoobStage = 1.2
#	
#	if PlayerMilk > 60:
#		BoobStage = 1.4
	
#	if PlayerMilk > 90:
#		BoobStage = 1.6
	
	
	
	PlayerMilk += 1.5 * delta * BellModifier
	$PlayerMilkBar.value = PlayerMilk
	
	%BoobManager.scale.x = BoobStage + (PlayerMilk / 30)
	%BoobManager.scale.y = BoobStage + ((PlayerMilk) / 40)




#func _on_water_button_pressed() -> void:
	#Water += 50*get_process_delta_time()
	#print("button pressed...")

#Drink button signals
func _on_water_button_button_down() -> void:
	IsWaterButtonPressed = true
func _on_water_button_button_up() -> void:
	IsWaterButtonPressed = false
func _on_root_beer_button_button_down() -> void:
	IsRootBeerButtonPressed = true
func _on_root_beer_button_button_up() -> void:
	IsRootBeerButtonPressed = false
func _on_beer_button_button_down() -> void:
	IsBeerButtonPressed = true
func _on_beer_button_button_up() -> void:
	IsBeerButtonPressed = false
func _on_drink_milk_button_button_down() -> void:
	IsDrinkMilkButtonPressed = true
func _on_drink_milk_button_button_up() -> void:
	IsDrinkMilkButtonPressed = false
#BestMilk Button, extra special
func _on_best_milk_button_button_down() -> void:
	IsBestMilkButtonPressed = true
func _on_best_milk_button_button_up() -> void:
	IsBestMilkButtonPressed = false


func _on_bell_button_button_down() -> void:
	if PlayerClimaxing == false:
		PlayerMilk += 20
		BellModifier += 0.10


func _on_mug_button_button_down() -> void:
	BestMilk = 0
	Water = 0 
	RootBeer = 0 
	Beer = 0
	Milk = 0 
