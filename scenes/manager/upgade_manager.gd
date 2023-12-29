extends Node

@export var experience_manager: Node
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}

var upgrade_pool = WeightedTable.new()

var upgrade_axe = preload("res://resources/upgrades/axe.tres")
var upgrade_axe_damage = preload("res://resources/upgrades/axe_damage.tres")
var upgrade_sword_rate = preload("res://resources/upgrades/sword_rate.tres")
var upgrade_sowrd_damage = preload("res://resources/upgrades/sword_damage.tres")
var upgrade_player_speed = preload("res://resources/upgrades/player_speed.tres")


func _ready():
	upgrade_pool.add_item(upgrade_axe, 10)
	upgrade_pool.add_item(upgrade_sword_rate, 10)
	upgrade_pool.add_item(upgrade_sowrd_damage, 10)
	upgrade_pool.add_item(upgrade_player_speed, 5)

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
			upgrade_pool.remove_item(upgrade)
	
	update_upgrade_pool(upgrade)

	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


func update_upgrade_pool(chosen_upgrade: AbilityUpgrade):
	if chosen_upgrade.id == upgrade_axe.id:
		upgrade_pool.add_item(upgrade_axe_damage, 10)


func pick_upgrades():
	var chosen_upgrades:Array[AbilityUpgrade] = []
	for i in 2:
		if upgrade_pool.items.size() == chosen_upgrades.size():
			break
		var chosen_upgrade = upgrade_pool.get_item(chosen_upgrades) as AbilityUpgrade
		chosen_upgrades.append(chosen_upgrade)
	
	return chosen_upgrades



func on_upgrade_selected(chosen_upgrade: AbilityUpgrade):
	apply_upgrade(chosen_upgrade)


func on_level_up(new_level):
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	var chosen_upgrades = pick_upgrades()
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
	
	
