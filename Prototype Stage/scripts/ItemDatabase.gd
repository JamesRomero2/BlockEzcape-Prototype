extends Node

var items = Array()

func _ready():
    var directory = Directory.new()
    directory.open("res://gameObjects/Items")
    directory.list_dir_begin()

    var filename = directory.get_next()
    while filename:
        if not directory.current_is_dir():
            items.append(load("res://gameObjects/Items/%s" % filename))

        filename = directory.get_next()

func getItemFromDB(item_name):
    for i in items:
        if i.name == item_name:
            return i

    return null