extends Node

@export var max_range = 150
@export var sword_ability: PackedScene

var damage = 5
var base_wait_time

# Called when the node enters the scene tree for the first time.
func _ready():
	base_wait_time = $Timer.wait_time
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null: return
	
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func(enemy: Node2D): 
		return enemy.global_position.distance_squared_to(player.global_position) < pow(max_range, 2)
	)
	
	if enemies.size() == 0: return
	
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer") as Node2D
	var sword_instance = sword_ability.instantiate() as SwordAbility
	foreground_layer.add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage
	
	var enemy = enemies[0] as Node2D
	
	sword_instance.global_position = enemy.global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemy_direction = enemy.global_position - sword_instance.global_position
	sword_instance.rotation = enemy_direction.angle()


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "sword_rate":
		$Timer.wait_time = base_wait_time * (1 - upgrade.level * 0.1)
		$Timer.start()
	# elif upgrade.id == "sword_damage":
	# 	damage = 5 + upgrade.level * 5
	# elif upgrade.id == "sword_range":
	# 	max_range = 150 + upgrade.level * 50
	# elif upgrade.id == "sword_count":
	# 	$Timer.wait_time = base_wait_time / (1 + upgrade.level * 0.1)
	# 	damage = 5 + upgrade.level * 5
	# 	max_range = 150 + upgrade.level * 50
	# else:
	# 	return