extends Node

enum F_TYPE  {
	BOROVNICA = 0,
	MALINA = 1,
	JAGODA = 2,
	GROZDJE = 3,
	SLJIVA = 4,
	KRUSKA = 5,
	NEKTARINA = 6,
	JABUKA = 7,
	DUNJA = 8,
	DINJA = 9,
	LUBENICA = 10,
}


var fruit_array = [
	load("res://scenes/fruits/borovnica.tscn"),
	load("res://scenes/fruits/malina.tscn"),
	load("res://scenes/fruits/jagoda.tscn"),
	load("res://scenes/fruits/grozdje.tscn"),
	load("res://scenes/fruits/sljiva.tscn"),
	load("res://scenes/fruits/kruska.tscn"),
	load("res://scenes/fruits/nektarina.tscn"),
	load("res://scenes/fruits/jabuka.tscn"),
	load("res://scenes/fruits/dunja.tscn"),
	load("res://scenes/fruits/dinja.tscn"),
	load("res://scenes/fruits/lubenica.tscn")
]


