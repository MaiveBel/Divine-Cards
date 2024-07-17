extends Resource
class_name Card
#card info = ["Types",Name,Time,Range,Special Effect]
@export var type = ["Attack"]
@export var name : String = ""
@export var time : int = 1
@export var range : int = 1
@export var specialEffects : Array[Array] = [["Effect",1]]
@export var image : Texture
@export var borderImage : Texture
@export var backgroundImage : Texture
@export var description : String = "ay lmao it broke"

func Play(target):
	pass

