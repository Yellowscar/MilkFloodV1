extends Node2D

@onready var ComboBoob = %"Combined Boob"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%"Combined Boob".play("StraightFromTap1")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
