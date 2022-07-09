extends Node2D

signal playerInitialize

var player 

func _process(_delta):
    if not player:
        initializePlayer()
        return

func initializePlayer():
    player = get_tree().get_root().get_node("/root/Prototype2/GameArea/Puzzle/Player")
    if not player:
        return
    
    emit_signal("playerInitialize", player)

    player.inventory.connect("inventoryChange", self, "_onPlayerInventoryChange")

    player.inventory.addItemToInventory("Key", 3)

func _onPlayerInventoryChange(inventory):
    pass
