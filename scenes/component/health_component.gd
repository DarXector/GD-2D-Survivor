extends Node
class_name HealthComponent

signal died()

@export var max_health = 10

var current_healt

func _ready():
	current_healt = max_health

func damage(amount:float):
	current_healt = max(current_healt - amount, 0)
	Callable(check_death).call_deferred()


func check_death():
	if current_healt == 0:
		died.emit()
		owner.queue_free()
