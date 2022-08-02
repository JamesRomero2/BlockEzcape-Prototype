extends GridContainer

func _onPlayerInitialize(player):
	player.inventory.connect("inventoryChange", self, "_onPlayerInventoryChange")

func _onPlayerInventoryChange(inventory):
	for node in get_children():
		node.queue_free()

	for item in inventory.getItems():
		# var itemLabel = Label.new()
		# itemLabel.text = "%s x%d" % [item.item_reference.name, item.item_quantity]
		# add_child(itemLabel)
		
		var itemPanel = TextureRect.new()
		itemPanel.texture = item.item_reference.inventoryTexture
		add_child(itemPanel)
