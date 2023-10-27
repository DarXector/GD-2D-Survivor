extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: Node
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}

func _ready():
	experience_manager.level_up.connect(on_level_up)


func apply_upgrade(chosen_upgrade: AbilityUpgrade):
	var has_upgrade = current_upgrades.has(chosen_upgrade.id)
	var upgrade = null
	if has_upgrade:
		upgrade = current_upgrades[chosen_upgrade.id]
		upgrade.level += 1
	else:
		upgrade = chosen_upgrade.duplicate()
		upgrade.level = 1
		current_upgrades[chosen_upgrade.id] = upgrade

	if upgrade.max_level > 0:
		var current_level = upgrade.level
		if current_level == upgrade.max_level:
			upgrade_pool = upgrade_pool.filter(func (pool_upgrade: AbilityUpgrade): return pool_upgrade.id != upgrade.id)
	
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


func pick_upgrades():
	var chosen_upgrades:Array[AbilityUpgrade] = []
	var filtered_upgrades = upgrade_pool.duplicate()
	for i in 2:
		if filtered_upgrades.size() == 0:
			break
		var chosen_upgrade = filtered_upgrades.pick_random() as AbilityUpgrade
		chosen_upgrades.append(chosen_upgrade)
		filtered_upgrades = filtered_upgrades.filter(func (upgrade: AbilityUpgrade): return upgrade.id != chosen_upgrade.id)
	
	return chosen_upgrades



func on_upgrade_selected(chosen_upgrade: AbilityUpgrade):
	apply_upgrade(chosen_upgrade)


func on_level_up(new_level):
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	var chosen_upgrades = pick_upgrades()
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
	
	