extends Node2D

func DummyJustEntered() -> void:
	%DummyAnimationPlayer.play("DummyIdle")

func DummyMustLeave() -> void:
	%DummyAnimationPlayer.play("DummyExit")
	print("dummy leaving now")
	GlobalNode.DrinkHasBeenServedBool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%DummyAnimationPlayer.play("DummyEnter")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalNode.DrinkHasBeenServedBool == true:
		%DummyAnimationPlayer.play("DummyExit")
		print("dummy leaving now")
		GlobalNode.DrinkHasBeenServedBool = false
