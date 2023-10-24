extends Node

var current_experience: float = 0


func _ready():
	GameEvents.experience_vial_collected.connect(increment_ecperience)


func increment_ecperience(value: float):
	current_experience += value
