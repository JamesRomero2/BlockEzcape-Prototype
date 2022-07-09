extends Resource
class_name ItemResource

export var name : String
export var stackable : bool
export var maxStackSize : int = 1

enum itemType {KEYITEM, PUZZLEITEM, TRAPSITEM}
export(itemType) var type
export var orbTexture : Texture
export var inventoryTexture : Texture
