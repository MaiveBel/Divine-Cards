extends Node2D

#selecting cards
signal cardMouseEntered(Card)
signal cardMouseExited(Card)

signal playCard(Node2D)
signal drawCard(int)
signal positionCardInHand(Vector2,rotationRotation,targetZ,targetCard)
signal calculateCardPositions()
