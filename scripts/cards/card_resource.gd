class_name Card
extends Resource
## A resource containing the stats and behaviors of a given Card in game.
## 
## The Card resource is designed in such a way that it will rarely have to be extended, naturally encouraging composition-designed cards over inheritance-based implementations.
## You can customize what a card "does" by changing its [CardResponder]s. Currently, one exists for on add, on use, and on destroy.


## The unique id of this card. No other card should have the same id!
@export var id: String

# TODO: i18n
## The display name of this card.
@export var display_name: String

## The maximum number of uses of this card. Must be positive.
@export var max_uses := 10

## The cooldown, in seconds, between uses of this card. Must be greater than 0.
@export var cooldown := 0.2

# OK to keep these null: essentially these are "event listeners" that can be swapped out by designers

## The action to do when this card is added to a hand. This can be anything that extends [CardResponder], or null to do nothing.
@export var on_added: CardResponder
## The action to do when this card is used. This can be anything that extends [CardResponder], or null to do nothing.
@export var on_use: CardResponder
## The action to do when this card is destroyed. This can be anything that extends [CardResponder], or null to do nothing.
@export var on_destroy: CardResponder
