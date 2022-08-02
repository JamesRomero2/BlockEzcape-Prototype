extends Node2D

var item_name = ""
var item_quantity = 1

func set_item(name, quantity):
	item_name = name
	item_quantity = quantity
	$TextureRect.texture = load("res://icon.png")

 
