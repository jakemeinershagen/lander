extends Node2D

# size will actually be this times 2, since this is only one side
const VISIBLE_SIZE = 500
const OUTER_LIMIT = 100


func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var ship_pos = $Ship.position.x / $TileMap.tile_set.tile_size.x
	
	# track list of chunks loaded
	# get chunks within outer limit
	# diff loaded - out_of_range
	# remove out_of_range chunks
	# load chunks that don't exist
