extends Area2D

@export var ItemResource: InventoryItem

func collect(inventory: Inventory):
	inventory.insert(ItemResource)
	queue_free()


func _on_body_entered(body):
	if body is Player:
		collect(body.inventory)
