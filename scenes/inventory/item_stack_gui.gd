extends Panel

class_name ItemStackGui

@onready var itemSprite: Sprite2D = $Item
@onready var amountLabel: Label = $AmountLabel

var inventorySlot: InventorySlot

func update():
	if !inventorySlot || !inventorySlot.item: return
	
	itemSprite.visible = true
	itemSprite.texture = inventorySlot.item.texture
	amountLabel.visible = inventorySlot.amount > 1
	amountLabel.text = str(inventorySlot.amount)
