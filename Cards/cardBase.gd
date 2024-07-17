extends Node2D

@onready var signal_bus = get_node("/root/SignalBus")


@export var cardInfo = Card
@onready var cardBorder = $CardBorder
@export var cardBackground := Sprite2D
@onready var cardImage = $CardImage
@onready var cardTime = $Time
@onready var cardName = $Name
@onready var cardType = $Type
@onready var cardRange = $Range
@onready var cardDescription = $Description





# Called when the node enters the scene tree for the first time.
func _ready():
	cardBorder.texture = cardInfo.borderImage
	cardBackground.texture = cardInfo.backgroundImage
	cardImage.texture = cardInfo.image
	cardDescription.text = str(cardInfo.description)
	cardRange.text = str(cardInfo.range)
	cardTime.text = str(cardInfo.time)
	cardName.text = str(cardInfo.name)
	cardType.text = str(cardInfo.type[0])



