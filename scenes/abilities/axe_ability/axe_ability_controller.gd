extends Node


@export var axe_ability_scene: PackedScene

var base_damage = 10
var additional_damage_percent = 1
var base_wait_time


func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return

	var foregorund = get_tree().get_first_node_in_group("foreground_layer")
	if foregorund == null:
		return

	var axe_instance = axe_ability_scene.instantiate()
	foregorund.add_child(axe_instance)
	axe_instance.global_position = player.global_position
	axe_instance.hitbox_component.damage = base_damage * additional_damage_percent


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "axe_damage":
		additional_damage_percent = 1 + upgrade.level * 0.1
