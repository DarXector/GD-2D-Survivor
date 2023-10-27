extends Node

signal experience_vial_collected(value: float)
signal ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)

func emit_experienve_vial_collected(value: float):
	experience_vial_collected.emit(value)


func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	ability_upgrade_added.emit(upgrade, current_upgrades)