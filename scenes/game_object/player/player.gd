extends CharacterBody2D

const MAX_SPEED = 125
const ACCELERATION_SMOOTHING = 25

@onready var damage_interval_timer = $DamageIntervalTimer
@onready var health_component = $HealthComponent
@onready var health_bar = $HealthBar
@onready var abilities = $Abilities
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var velocity_component = $VelocityComponent

var number_colliding_bodies = 0
var base_speed = 0

func _ready():
	base_speed = velocity_component.max_speed
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)
	health_component.health_changed.connect(on_health_changed)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	update_health_display(health_component.get_health_percent())


func _process(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(self)

	if movement_vector.x > 0:
		sprite.flip_h = false
	elif movement_vector.x < 0:
		sprite.flip_h = true

	if movement_vector != Vector2.ZERO:
		animation_player.play("walk")
	else:
		animation_player.play("RESET")


func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)


func check_deal_damage():
	if number_colliding_bodies > 0 && damage_interval_timer.is_stopped():
		health_component.damage(1)
		damage_interval_timer.start()
		print("Dealt damage to player", health_component.current_health)


func update_health_display(new_health: float):
	health_bar.value = new_health


func on_body_entered(other_body: Node2D):
	number_colliding_bodies += 1
	check_deal_damage()


func on_body_exited(other_body: Node2D):
	number_colliding_bodies -= 1


func on_damage_interval_timer_timeout():
	check_deal_damage()


func on_health_changed(new_health: float):
	GameEvents.emit_player_damaged()
	update_health_display(new_health)


func on_ability_upgrade_added(ability_upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if ability_upgrade is Ability:
		abilities.add_child(ability_upgrade.ability_controller_scene.instantiate())
	elif ability_upgrade.id == "player_speed":
		velocity_component.max_speed = base_speed + (current_upgrades["player_speed"]["level"] * 0.1) * base_speed
	# elif ability_upgrade.id == "player_health":
	# 	health_component.max_health = ability_upgrade.value
	# 	health_component.current_health = ability_upgrade.value
	# 	update_health_display(health_component.get_health_percent())
