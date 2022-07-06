extends Node2D

onready var inventorySlots := $GridContainer

const SLOTCLASS := preload("res://prototype/Slot.gd")

var holdingItem = null
onready var inventoryItems = get_parent().get("inventory")


func _ready():
	for inv_slot in inventorySlots.get_children():
		inv_slot.connect("gui_input", self, "slotGuiInput", [inv_slot])

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
					slot.putIntoSlot(holdingItem)
					holdingItem = null
				else:
					var tempItem = slot.item
					slot.pickFromSlot()
					tempItem.global_position = event.global_position
					slot.putIntoSlot(holdingItem)
					holdingItem = tempItem
			elif slot.item:
				holdingItem = slot.item
				slot.pickFromSlot()
				holdingItem.global_position = get_global_mouse_position() - Vector2(10,10)

func _input(event):
	if holdingItem:
		holdingItem.global_position = get_global_mouse_position() - Vector2(10,10)



func _on_Prototype_inventorySignal():
	initializeInventory()
