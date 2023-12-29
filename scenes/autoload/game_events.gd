extends Node

signal experience_vial_collected(value: float)
signal player_damaged()
signal ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)


func emit_experienve_vial_collected(value: float):
	experience_vial_collected.emit(value)


func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	ability_upgrade_added.emit(upgrade, current_upgrades)


func emit_player_damaged():
	player_damaged.emit()
	