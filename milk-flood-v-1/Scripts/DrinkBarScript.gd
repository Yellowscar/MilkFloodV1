extends Node

@onready var AnimPlayer = %"ProtoScene Animation Player"

#ProtoText
@onready var ProtoText = %ProtoText

#BoobManager
@onready var BoobManager = %BoobManager

#Stimulation Bar, aka Stim Bar
@onready var StimBar = %Stimbar
var Stimulation: float = 0
var PlayerClimaxing: bool = false

var PlayerStimulating = false
var StimulationSensitivity = 1

#Drink Button Variables
var IsBestMilkButtonPressed = false
var IsWaterButtonPressed = false
var IsRootBeerButtonPressed = false
var IsBeerButtonPressed = false
var IsDrinkMilkButtonPressed = false

var MugCoolDown = 0

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


#Drink Ordering variables
var OrderLeeway

var OrderMilk
var OrderBeer
var OrderRootBeer
var OrderWater

var TrueOrderMilk
var TrueOrderBeer
var TrueOrderRootBeer
var TrueOrderWater

var OrderSize = 100


# calling in the orderbar nodes
@onready var OrderWaterBar = %OrderWaterBar
@onready var OrderRootBeerBar = %OrderRootBeerBar 
@onready var OrderBeerBar = %OrderBeerBar 
@onready var OrderMilkBar = %OrderDrinkMilkBar


var OrderBarMilk
var OrderBarBeer
var OrderBarRootBeer
var OrderBarWater


#Order success and failure count
var PlayerSuccess = 0
var PlayerFailure = 0

var IsMilkRight = false
var IsWaterRight = false
var IsRootBeerRight = false
var IsBeerRight = false


#PlayerMilk
@export_range(0.0, 100.0) var PlayerMilk: float = 0
@export var BellModifier: float = 1
@onready var PlayerMilkBar = $PlayerMilkBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%"ProtoScene Animation Player".play("Bell Icon Ring")
	
	
	OrderLeeway = 8
	
	OrderMilk = randf_range(0, 100) 
	OrderBeer = randf_range(0, 100)
	OrderRootBeer = randf_range(0, 100)
	OrderWater = randf_range(0, 100)
	
	var OrderSum = (OrderMilk + OrderBeer + OrderRootBeer + OrderWater)
	
	TrueOrderMilk = OrderMilk / OrderSum * OrderSize 
	TrueOrderBeer = OrderBeer / OrderSum * OrderSize
	TrueOrderRootBeer = OrderRootBeer / OrderSum * OrderSize
	TrueOrderWater =  OrderWater / OrderSum * OrderSize
	




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if MugCoolDown > 0:
		MugCoolDown -= 1 * delta
	else:
		MugCoolDown = 0
	
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
		Stimulation += 25 * delta * StimulationSensitivity
		PlayerMilk -= 15*delta
		OrderLeeway += 10*delta
	
	#handle stimulation and handle climax
	%Stimbar.value = Stimulation

	if PlayerStimulating == true and PlayerClimaxing == false:
		Stimulation += 60 * delta * StimulationSensitivity

	Stimulation -= 5 * delta

	
	if Stimulation > 99:
		PlayerClimaxing = true
		%"ProtoScene Animation Player".play("Cow Icon Bounce")
	
	if Stimulation < 1 and PlayerClimaxing == true:
		PlayerClimaxing = false
		%"ProtoScene Animation Player".play("Cow Icon Idle")
	
	if PlayerClimaxing == true:
		Stimulation -= 50 * delta
	
	

	
	
	
	#Texturebar offset
	TrueBestMilk = BestMilk
	TrueMilk = Milk + TrueBestMilk
	TrueBeer = Beer + TrueMilk
	TrueRootBeer = RootBeer + TrueBeer
	TrueWater = Water + TrueRootBeer
	
	OrderBarMilk = TrueOrderMilk
	OrderBarBeer = TrueOrderBeer + OrderBarMilk
	OrderBarRootBeer = TrueOrderRootBeer + OrderBarBeer
	OrderBarWater = TrueOrderWater + OrderBarRootBeer
	
	%OrderWaterBar.value = OrderBarWater
	%OrderRootBeerBar.value = OrderBarRootBeer
	%OrderBeerBar.value = OrderBarBeer
	%OrderDrinkMilkBar.value = OrderBarMilk
	
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

	if BestMilk > 100:
		BestMilk = 100
	if BestMilk < 0:
		BestMilk = 0

	if Milk > 100:
		Milk = 100
	if Milk < 0:
		Milk = 0

	if Beer > 100:
		Beer = 100
	if Beer < 0:
		Beer = 0

	if RootBeer > 100:
		RootBeer = 100
	if RootBeer < 0:
		RootBeer = 0

	if Water > 100:
		Water = 100
	if Water < 0:
		Water = 0
	
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
	
	# Handle prototext
	ProtoText.text = "Drinks; 
	BestMilk " + str(int(BestMilk)) + ", Milk " + str(int(Milk)) + ", Beer" + str(int(Beer)) + ", RootBeer " + str(int(RootBeer)) + ", Water" + str(int(Water)) + "                 
	
	Order; 
	Milk " + str(int(TrueOrderMilk)) + ", Beer " + str(int(TrueOrderBeer)) + ", Rootbeer " + str(int(TrueOrderRootBeer)) + ", Water " + str(int(TrueOrderWater)) + "
	
	Success; " + str(PlayerSuccess) + "
	Failure; " + str(PlayerFailure)




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

#Bell Icon functions
func _on_bell_button_button_down() -> void:
	if PlayerClimaxing == false:
		PlayerMilk += 20
		BellModifier += 0.10
		%"ProtoScene Animation Player".play("Bell Icon Ring")

func StopThatRinging() -> void:
	%"ProtoScene Animation Player".play("Bell Icon Idle")


func _on_mug_button_button_down() -> void:
	if PlayerClimaxing == false and MugCoolDown == 0:
		print("global variable changed")
		
		if Water > TrueOrderWater - OrderLeeway and Water < TrueOrderWater + OrderLeeway:
			IsWaterRight = true
		
		if RootBeer > TrueOrderRootBeer - OrderLeeway and RootBeer < TrueOrderRootBeer + OrderLeeway:
			IsRootBeerRight = true
		
		if Beer > TrueOrderBeer - OrderLeeway and Beer < TrueOrderBeer + OrderLeeway:
			IsBeerRight = true
		
		if Milk > TrueOrderMilk - OrderLeeway and Milk < TrueOrderMilk + OrderLeeway:
			IsMilkRight = true
		
		
		
		if IsWaterRight == true and IsRootBeerRight == true and IsBeerRight == true and IsMilkRight == true:
			PlayerSuccess += 1
		else: 
			PlayerFailure += 1
		
		BestMilk = 0
		Water = 0 
		RootBeer = 0 
		Beer = 0
		Milk = 0 
		
		
		
		OrderMilk = randf_range(0, 100) 
		OrderBeer = randf_range(0, 100)
		OrderRootBeer = randf_range(0, 100)
		OrderWater = randf_range(0, 100)
		
		var OrderSum = (OrderMilk + OrderBeer + OrderRootBeer + OrderWater)
		
		TrueOrderMilk = OrderMilk / OrderSum * OrderSize 
		TrueOrderBeer = OrderBeer / OrderSum * OrderSize
		TrueOrderRootBeer = OrderRootBeer / OrderSum * OrderSize
		TrueOrderWater =  OrderWater / OrderSum * OrderSize
		
		GlobalNode.DrinkHasBeenServedBool = true
		MugCoolDown = 1


func _on_drink_it_button_button_down() -> void:
	if PlayerClimaxing == false:
		BestMilk = 0
		Water = 0 
		RootBeer = 0 
		Beer = 0
		Milk = 0 
	

#heartbutton, for stimulation
func _on_heart_button_button_down() -> void:
	PlayerStimulating = true

func _on_heart_button_button_up() -> void:
	PlayerStimulating = false 
