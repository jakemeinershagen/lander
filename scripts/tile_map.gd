extends TileMapLayer

const CHUNK_SIZE = 100

func _ready() -> void:
	Globals.tile_size = tile_set.tile_size


func get_chunk_num(x):
	if x < 0:
		x -= 100
	return floor(x / 100)


func load_chunk(chunk_num):
	var left_limit = chunk_num * CHUNK_SIZE
	var right_limit = chunk_num * CHUNK_SIZE + CHUNK_SIZE
	
	for x in range(left_limit, right_limit):
		set_cell(Vector2(x, 0), 1, Vector2(11, 2), 0)
		set_cell(Vector2(x, 1), 1, Vector2(7, 4), 0)
		set_cell(Vector2(x, 2), 1, Vector2(7, 4), 0)


func unload_chunk(chunk_num):
	var left_limit = chunk_num * CHUNK_SIZE
	var right_limit = chunk_num * CHUNK_SIZE + CHUNK_SIZE
	
	for x in range(left_limit, right_limit):
		set_cell(Vector2(x, 0), -1, Vector2(11, 2), 0)
