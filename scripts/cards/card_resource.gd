extends Resource
class_name CardResource

@export var id: String
# TODO: i18n
@export var display_name: String

@export var max_uses := 10

@export var cooldown := 0.2

# OK to keep these null: essentially these are "event listeners" that can be swapped out by designers

@export var on_added: CardResponder
@export var on_use: CardResponder
@export var on_destroy: CardResponder
