extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ScrollDown"):
		$Camera2D.position.y += 60
	if Input.is_action_just_pressed("ScrollUp"):
		$Camera2D.position.y += -60
		
	
	if $Camera2D.position.y < -766:
		$Camera2D.position.y = -766
	
	if $Camera2D.position.y > 1485:
		$Camera2D.position.y = 1485
