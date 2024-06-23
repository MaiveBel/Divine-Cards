extends Node2D

#selecting cards
signal disableCards(Node2D)
signal enableCards(Node2D)

signal selectedCard(Node2D,int)
signal putCardBackInHand(Node2D,int)

signal playCard(Node2D)
signal drawCard(int)
signal positionCardInHand(Vector2,rotationRotation,targetZ,targetCard)
signal calculateCardPositions()
