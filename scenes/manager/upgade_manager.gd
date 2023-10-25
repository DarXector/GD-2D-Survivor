extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: Node
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}

func _ready():
	experience_manager.level_up.connect(on_level_up)


func on_level_up(new_level):
	var chosen_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	if chosen_upgrade == null: return
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrades([chosen_upgrade] as Array[AbilityUpgrade])


func apply_upgrade(chosen_upgrade: AbilityUpgrade):
	var has_upgrade = current_upgrades.has(chosen_upgrade.id)
	if has_upgrade:
		var upgrade = current_upgrades[chosen_upgrade.id]
		upgrade.level += 1
	else:
		var upgrade = chosen_upgrade.duplicate()
		upgrade.level = 1
		current_upgrades[chosen_upgrade.id] = upgrade
