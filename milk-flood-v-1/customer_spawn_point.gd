extends Node2D

@onready var CustomerDummyScene = load("res://CustomerDummy.tscn")

func SpawnACustomer():
	var SceneToSpawn = CustomerDummyScene.instantiate()
	add_child(SceneToSpawn)
	SceneToSpawn.position = %CustomerSpawnPoint.position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SpawnACustomer()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("TestKey") or GlobalNode.DrinkHasBeenServedBool == true:
		SpawnACustomer()
