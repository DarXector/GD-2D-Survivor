extends Node

signal experience_updated(current_experience: float, target_experience: float)
signal level_up(new_level: int)

const TARGET_EXPERIENCE_GOWTH = 5

var current_experience: float = 0
var current_level = 1
var target_experience = 2


func _ready():
	GameEvents.experience_vial_collected.connect(increment_ecperience)


func increment_ecperience(value: float):
	current_experience = min(current_experience + value, target_experience)

	if current_experience == target_experience:
		current_level += 1
		target_experience = current_experience + TARGET_EXPERIENCE_GOWTH
		current_experience = 0
		level_up.emit(current_level)

	experience_updated.emit(current_experience, target_experience)
