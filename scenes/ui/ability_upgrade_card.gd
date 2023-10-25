extends PanelContainer

@onready var name_label:Label = $%NameLabel
@onready var description_label:Label = $%DescriptionLabel

func set_ability_upgrade ( ability_upgrade: AbilityUpgrade ):
	name_label.text = ability_upgrade.name
	description_label.text = ability_upgrade.description
