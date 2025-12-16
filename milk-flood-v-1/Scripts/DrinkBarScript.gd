extends Node

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


#func BestMilkMilking():
	

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
	
	if IsWaterButtonPressed == true:
		Water += 40*delta
	
	if IsRootBeerButtonPressed == true:
		RootBeer += 40*delta
	
	if IsBeerButtonPressed == true:
		Beer += 40*delta
	
	if IsDrinkMilkButtonPressed == true:
		Milk += 40*delta
	
	if IsBestMilkButtonPressed == true:
		BestMilk += 40*delta
	
	TrueBestMilk = BestMilk
	TrueMilk = Milk + TrueBestMilk
	TrueBeer = Beer + TrueMilk
	TrueRootBeer = RootBeer + TrueBeer
	TrueWater = Water + TrueRootBeer
	
	
	%BestMilkBar.value = TrueBestMilk
	%DrinkMilkBar.value = TrueMilk
	%BeerBar.value = TrueBeer
	%RootBeerBar.value = TrueRootBeer
	%WaterBar.value = TrueWater
	
	




#func _on_water_button_pressed() -> void:
	#Water += 50*get_process_delta_time()
	#print("button pressed...")

#button signals
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
