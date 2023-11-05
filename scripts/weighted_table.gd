class_name WeightedTable

var items: Array[Dictionary] = []
var total_weight: int = 0

func add_item(item, weight: int):
	items.append({"item": item, "weight": weight})
	total_weight += weight


func get_item():
	var random_number: int = randi_range(1, total_weight)
	var current_weight: int = 0
	for item in items:
		current_weight += item["weight"]
		if random_number <= current_weight:
			return item["item"]
	return null
