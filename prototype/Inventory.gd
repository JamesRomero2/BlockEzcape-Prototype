extends Node2D

signal addItemToSlot(holdingItem, slot)
signal removeItem(slot)

onready var inventorySlots := $GridContainer
onready var tileMap = get_node("/root/Prototype/GameArea/PuzzlePhase/TileMap")

const SLOTCLASS := preload("res://prototype/Slot.gd")

var holdingItem = null
onready var inventoryItems = get_parent().get("inventory")


func _ready():
	var slots = inventorySlots.get_children()
	for i in range(slots.size()):
		slots[i].connect("gui_input", self, "slotGuiInput", [slots[i]])
		slots[i].slotIndex = i

	initializeInventory()

func initializeInventory():
	var slots = inventorySlots.get_children()
	for i in range(slots.size()):
		if inventoryItems.has(i):
			slots[i].initializeItem(inventoryItems[i][0], inventoryItems[i][1])


func slotGuiInput(event: InputEvent, slot: SLOTCLASS):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if holdingItem != null:
				if !slot.item:
					emit_signal("addItemToSlot", holdingItem, slot)
					slot.putIntoSlot(holdingItem)
					holdingItem = null
				else:
					if holdingItem.item_name != slot.item.item_name:
						emit_signal("removeItem", slot)
						emit_signal("addItemToSlot", holdingItem, slot)
						var tempItem = slot.item
						slot.pickFromSlot()
						tempItem.global_position = event.global_position
						slot.putIntoSlot(holdingItem)
						holdingItem = tempItem
			elif slot.item:
				emit_signal("removeItem", slot)
				holdingItem = slot.item
				slot.pickFromSlot()
				holdingItem.global_position = get_global_mouse_position() - Vector2(10,10)

func _input(_event):
	if holdingItem:
		holdingItem.global_position = get_global_mouse_position()
		var mouseTile = tileMap.world_to_map(get_global_mouse_position())
		var localPos = tileMap.map_to_world(mouseTile)
		var worldPos = tileMap.to_global(localPos)
		
		holdingItem.global_position = worldPos
		# holdingItem.global_position = Vector2(round(get_global_mouse_position().x / 16) * 16, round(get_global_mouse_position().y / 16) * 16)
		

func _on_Prototype_inventorySignal():
	initializeInventory()
