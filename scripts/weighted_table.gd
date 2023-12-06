class_name WeightedTable

var items: Array[Dictionary] = []
var weight_sum: int = 0

func add_item(item, weight: int):
	items.append({"item": item, "weight": weight})
	weight_sum += weight


func get_item(exclude: Array = []):
	var adjusted_items: Array[Dictionary] = items
	var adjusted_weight_sum = weight_sum

	if exclude.size() > 0:
		adjusted_items = []
		adjusted_weight_sum = 0
		for item in items:
			if item["item"] in exclude:
				continue
			adjusted_items.append(item)
			adjusted_weight_sum += item["weight"]

	var random_number: int = randi_range(1, adjusted_weight_sum)
	var current_weight: int = 0
	for item in adjusted_items:
		current_weight += item["weight"]
		if random_number <= current_weight:
			return item["item"]
	return null


func remove_item(item_to_remove):
	items = items.filter(func (item): return item["item"].id != item_to_remove.id)
	weight_sum = 0
	for item in items:
		weight_sum += item["weight"]
