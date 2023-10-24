extends Node

signal experience_vial_collected(value: float)

func emit_experienve_vial_collected(value: float):
	experience_vial_collected.emit(value)
