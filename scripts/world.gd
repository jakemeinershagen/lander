extends Node2D

# size will actually be this times 2, since this is only one side
const OUTER_LIMIT = 800

var loaded_chunks = []

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	var ship_pos = floor($Ship.position.x / $TileMap.tile_set.tile_size.x)
	
	var left_limit = ship_pos - OUTER_LIMIT
	var right_limit = ship_pos + OUTER_LIMIT
	
	var valid_chunks = []
	for pos in range(left_limit, right_limit+1, $TileMap.CHUNK_SIZE):
		var chunk_num = $TileMap.get_chunk_num(pos)
		if chunk_num not in loaded_chunks:
			$TileMap.load_chunk(chunk_num)
			loaded_chunks.append(chunk_num)
		valid_chunks.append(chunk_num)
	
	loaded_chunks.sort()
	for chunk_num in loaded_chunks:
		if chunk_num not in valid_chunks:
			$TileMap.unload_chunk(chunk_num)
			loaded_chunks.pop_at(loaded_chunks.bsearch(chunk_num))
