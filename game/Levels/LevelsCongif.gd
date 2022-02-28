extends Node

var goblin = preload("res://Enemies/Goblin.tscn")
var masked = preload("res://Enemies/Masked.tscn")
var chief = preload("res://Enemies/Chief.tscn")
var bone = preload("res://Enemies/Bone.tscn")
var goo = preload("res://Enemies/Goo.tscn")

var level1 = [
	[
		[goblin, "s", 1], [goblin, "w", 1],
		[goblin, "e", 1]
	],
	[
		[goblin, "e", 3], [goblin, "w", 5],
		[goblin, "e", 2]
	],
	[
		[goblin, "s", 2], [goblin, "w", 2],
		[goblin, "e", 3], [goblin, "n", 5],
	],
	[
		[goblin, "n", 2], [goblin, "s", 5],
		[goblin, "n", 3]
	],
	[
		[goblin, "n", 4], [goblin, "n", 2],
	],
	[
		[goblin, "w", 6]
	],
	[
		[goblin, "s", 4], [goblin, "w", 5],
	],
	[
		[goblin, "e", 6]
	],
	[
		[goblin, "s", 2], [goblin, "w", 2],
		[goblin, "e", 3]
	],
	[
		[goblin, "e", 4], [goblin, "n", 3],
		[goblin, "s", 3]
	],
	[
		[goblin, "n", 2], [goblin, "e", 2],
		[goblin, "s", 3]
	],
	[
		[goblin, "s", 2], [goblin, "n", 3],
		[goblin, "s", 3]
	],
	[
		[goblin, "e", 4], [goblin, "n", 2],
	],
	[
		[goblin, "s", 6], [goblin, "n", 1]
	],
	[
		[goblin, "w", 6]
	],
	[
		[goblin, "n", 4], [goblin, "e", 2],
	],
	[
		[goblin, "s", 4], [goblin, "w", 3],
		[goblin, "e", 2], [goblin, "n", 2],
	],
	[
		[goblin, "e", 3], [goblin, "w", 4],
	],
	[
		[goblin, "s", 3], [goblin, "w", 3], [goblin, "n", 6],
	],
	[
		[goblin, "n", 3], [goblin, "n", 2],
		[goblin, "n", 3], [goblin, "n", 1]
	],
	[
		[goblin, "s", 4], [goblin, "s", 2], [goblin, "s", 3]
	],
	[
		[goblin, "w", 6], [goblin, "w", 1],
	],
	[
		[goblin, "s", 5]
	],
	[
		[goblin, "n", 3], [goblin, "e", 3],
		[goblin, "s", 3], [goblin, "w", 3],
	],
]
var level2 = [
	[
		[masked, "n", 1], [goblin, "w", 1], [goblin, "e", 1], [goblin, "s", 1],
	],
	[
		[goblin, "w", 3], [masked, "s", 1], [goblin, "e", 2], 
	],
	[
		[masked, "s", 1], [goblin, "w", 2], [masked, "n", 1]
	],
	[
		[goblin, "s", 2], [goblin, "e", 7], 
	],
	[
		[goblin, "n", 5], [masked, "s", 1]
	],
	[
		[masked, "n", 1], [goblin, "w", 2], [goblin, "e", 3], [goblin, "s", 2]
	],
	[
		[goblin, "s", 5], [masked, "n", 1]
	],
	[
		[goblin, "e", 3], [goblin, "w", 2], [goblin, "e", 3], [goblin, "s", 2]
	],
	[
		[goblin, "e", 4], [masked, "w", 1]
	],
	[
		[goblin, "e", 1], [goblin, "w", 2], [goblin, "e", 2], [goblin, "s", 2],
		[goblin, "e", 1], [goblin, "w", 1]
	],
	[
		[goblin, "w", 6], [masked, "e", 1]
	],
	[
		[goblin, "n", 9]
	],
	[
		[masked, "e", 1], [masked, "w", 1]
	],
	[
		[goblin, "s", 8], [goblin, "w", 3]
	],
	[
		[goblin, "w", 6], [goblin, "w", 2]
	],
	[
		[goblin, "n", 4], [goblin, "s", 2]
	],
	[
		[masked, "s", 1], [masked, "n", 1], [goblin, "e", 2]
	],
	[
		[goblin, "n", 5], [masked, "s", 1]
	],
	[
		[goblin, "s", 6], [masked, "n", 1]
	],
	[
		[goblin, "n", 5], [goblin, "n", 2], [goblin, "n", 3], [goblin, "n", 1]
	],
	[
		[masked, "n", 1], [goblin, "w", 2], [goblin, "e", 2], [goblin, "s", 3]
	],
	[
		[masked, "s", 1], [goblin, "w", 4], [masked, "n", 3]
	],
	[
		[goblin, "s", 5]
	],
	[
		[masked, "n", 1], [masked, "s", 1], [masked, "e", 1], [masked, "w", 2]
	],	
]
var level3 = [
	[
		[chief, "s", 1], [goblin, "w", 1], [goblin, "e", 1], [goblin, "n", 1],
	],
	[
		[goblin, "w", 2], [goblin, "e", 1], [goblin, "n", 1], [masked, "w", 1], 
	],
	[
		[goblin, "s", 2], [goblin, "w", 2], [goblin, "e", 2], [goblin, "n", 4],
	],
	[
		[goblin, "n", 2], [goblin, "s", 5], [masked, "e", 1], [goblin, "n", 3]
	],
	[
		[goblin, "w", 3], [chief, "e", 1], [goblin, "e", 2]
	],
	[
		[goblin, "e", 3], [masked, "s", 2], [goblin, "w", 1], 
	],
	[
		[chief, "n", 1], [goblin, "w", 4], [goblin, "n", 2], [goblin, "s", 4]
	],
	[
		[goblin, "w", 5], [masked, "n", 2], [goblin, "e", 2], 
	],
	[
		[goblin, "s", 2], [goblin, "n", 2], [goblin, "w", 1], [masked, "s", 1],
		[goblin, "s", 2], [goblin, "n", 2], 
	],
	[
		[goblin, "n", 5], [masked, "n", 2], [chief, "s", 1]
	],
	[
		[goblin, "n", 4], [goblin, "e", 3], [goblin, "s", 3], [goblin, "w", 3],
	],
	[
		[goblin, "s", 5], [masked, "n", 2], [goblin, "n", 2],
	],
	[
		[goblin, "s", 2], [goblin, "n", 2], [goblin, "n", 2], [goblin, "s", 2],
		[goblin, "n", 1], [masked, "w", 1]
	],
	[
		[masked, "n", 1], [masked, "e", 1], [masked, "s", 1],
	],
	[
		[goblin, "w", 3], [goblin, "e", 3], [goblin, "w", 2],
	],
	[
		[masked, "e", 1], [chief, "s", 1], [goblin, "e", 2],
	],
	[
		[goblin, "s", 2], [goblin, "w", 1], [goblin, "e", 3], [goblin, "n", 1]
	],
	[
		[goblin, "n", 3], [goblin, "e", 3], [masked, "n", 1], [goblin, "s", 2],
		[goblin, "w", 2],
	],
	[
		[goblin, "w", 2], [goblin, "e", 3], [chief, "n", 2], [masked, "e", 2]
	],
	[
		[masked, "s", 1], [masked, "e", 1], [masked, "n", 3],
	],
	[
		[masked, "s", 1], [goblin, "w", 1], [goblin, "e", 3], [goblin, "n", 1]
	],
	[
		[chief, "n", 1], [chief, "e", 1], [chief, "s", 1],
	],
	[
		[goblin, "e", 1], [goblin, "w", 1], [goblin, "e", 1], [goblin, "w", 1],
		[goblin, "n", 1], [goblin, "s", 1], [goblin, "e", 1], [goblin, "n", 1],
	],
	[
		[goblin, "s", 6], [chief, "n", 1], 
	],
]
var level4 = [
	[
		[masked, "s", 1], [masked, "w", 1], [goblin, "n", 1],
	],
	[
		[chief, "e", 1], [goblin, "w", 3], 
	],
	[
		[goblin, "s", 3], [goblin, "w", 3], [goblin, "n", 3],
	],
	[
		[goblin, "n", 2], [masked, "s", 1], [goblin, "n", 3], [masked, "w", 1]
	],
	[
		[goblin, "n", 5], [goblin, "w", 4], [goblin, "s", 1]
	],
	[
		[chief, "s", 2], [goblin, "w", 5], [goblin, "n", 1]
	],
	[
		[goblin, "s", 5], [goblin, "e", 3]
	],
	[
		[masked, "n", 3], [goblin, "n", 3], [chief, "s", 1]
	],
	[
		[goblin, "s", 2], [goblin, "w", 2], [goblin, "e", 2], 
	],
	[
		[goblin, "e", 2], [goblin, "n", 2], [goblin, "s", 2]
	],
	[
		[chief, "s", 3], [chief, "n", 1],
	],
	[
		[masked, "w", 3], [masked, "e", 1], 
	],
	[
		[goblin, "e", 3], [goblin, "s", 3]
	],
	[
		[goblin, "s", 3], [goblin, "n", 3], [goblin, "n", 2],
	],
	[
		[goblin, "s", 1], [chief, "n", 2],
	],
	[
		[goblin, "n", 3], [goblin, "w", 3]
	],
	[
		[goblin, "s", 3], [goblin, "w", 3], [masked, "s", 1], [goblin, "w", 2],
	],
	[
		[goblin, "e", 3], [chief, "n", 3], [chief, "s", 1], 
	],
	[
		[goblin, "s", 3], [masked, "e", 1], [goblin, "w", 3], [masked, "n", 1],
		[goblin, "n", 2], 
	],
	[
		[masked, "w", 2], [goblin, "n", 3], [chief, "s", 1],
		[goblin, "n", 3]
	],
	[
		[goblin, "s", 3], [goblin, "s", 2],
		[goblin, "w", 1], [masked, "n", 1] , [goblin, "s", 3]
	],
	[
		[goblin, "w", 5], [goblin, "n", 2]
	],
	[
		[goblin, "s", 6]
	],
	[
		[chief, "n", 9]
	],
]
var level5 = "boss"
var level6 = [
	[
		[bone, "s", 1],
	],
	[
		[masked, "w", 1], [masked, "e", 1], [goblin, "s", 5]
	],
	[
		[chief, "w", 1], [goblin, "n", 3], [goblin, "e", 2]
	],
	[
		[goblin, "w", 3], [goblin, "s", 2], [goblin, "n", 1], [goblin, "s", 2]
	],
	[
		[masked, "n", 1], [masked, "s", 1], [goblin, "e", 3], [bone, "s", 1]
	],
	[
		[goblin, "w", 2], [goblin, "n", 1], [goblin, "e", 3]
	],
	[
		[chief, "s", 2], [goblin, "n", 1], [goblin, "n", 2], [bone, "w", 1]
	],
	[
		[goblin, "n", 2], [goblin, "s", 2], [masked, "n", 2]
	],
	[
		[masked, "w", 1], [goblin, "e", 2], [goblin, "w", 2],
		[goblin, "s", 3]
	],
	[
		[goblin, "n", 3], [goblin, "s", 3], [goblin, "n", 3], [chief, "w", 1]
	],
	[
		[masked, "n", 1], [goblin, "s", 2], [masked, "s", 1],
		[goblin, "n", 4]
	],
	[
		[bone, "n", 1], [goblin, "w", 2], [goblin, "n", 4], [masked, "s", 1]
	],
	[
		[chief, "w", 1], [bone, "s", 1]  ,[goblin, "e", 3]
	],
	[
		[goblin, "w", 3], [goblin, "w", 2], [bone, "n", 1]
	],
	[
		[masked, "e", 1], [masked, "w", 1], [masked, "n", 1], [goblin, "w", 4]
	],
	[
		[goblin, "n", 1], [bone, "s", 1], [chief, "w", 2]
	],
	[
		[goblin, "w", 2], [goblin, "e", 2], [goblin, "s", 1], [goblin, "n", 3]
	],
	[
		[masked, "s", 2], [goblin, "n", 3], [bone, "w", 2]
	],
	[
		[goblin, "s", 3], [goblin, "n", 2], [goblin, "e", 1], [bone, "w", 1]
	],
	[
		[chief, "s", 1], [chief, "n", 1], [bone, "e", 1], [masked, "w", 1]
	],
	[
		[goblin, "e", 4], [goblin, "n", 2], [chief, "s", 1]
	],
	[
		[chief, "e", 1], [goblin, "n", 5], [bone, "s", 1]
	],
	[
		[goblin, "s", 3], [goblin, "n", 3], [goblin, "e", 3], [goblin, "w", 3]
	],
	[
		[masked, "s", 1], [masked, "n", 1], [masked, "e", 1], [masked, "w", 1]
	],
]
var level7 = [
	[
		[bone, "n", 1]
	],
	[
		[chief, "n", 2], [goblin, "s", 2], [goblin, "w", 2]
	],
	[
		[goblin, "w", 3], [bone, "e", 1], [bone, "w", 1]
	],
	[
		[masked, "e", 2], [masked, "w", 2], [goblin, "n", 3]
	],
	[
		[goblin, "w", 3], [goblin, "e", 4], [goblin, "n", 2]
	],
	[
		[chief, "s", 2], [bone, "n", 1], [goblin, "e", 2]
	],
	[
		[masked, "n", 2], [goblin, "s", 4],
	],
	[
		[chief, "n", 1], [chief, "s", 1]
	],
	[
		[bone, "w", 1], [bone, "e", 1], [masked, 1, "s"]
	],
	[
		[goblin, "w", 3], [goblin, "e", 2], [goblin, "n", 4], [masked, "s", 1],
	],
	[
		[bone, "n", 1], [goblin, "e", 4], [chief, "n", 1]
	],
	[
		[chief, "s", 1], [masked, "e", 2], [chief, "n", 1]
	],
	[
		[bone, "w", 2], [bone, "e", 2],
	],
	[
		[masked, "n", 1], [masked, "e", 1], [goblin, "s", 4], [goblin, "w", 3]
	],
	[
		[chief, "n", 1], [chief, "s", 1], [chief, "n", 1], [bone, "w", 1]
	],
	[
		[masked, "n", 1], [goblin, "w", 3], [goblin, "e", 3], [goblin, "s", 2]
	],
	[
		[goblin, "e", 5], [bone, "n", 2],
	],
	[
		[bone, "w", 1], [bone, "e", 1], [bone, "w", 1], [bone, "e", 1]
	],
	[
		[goblin, "s", 2], [goblin, "n", 2], [goblin, "w", 1], [masked, "s", 1],
		[goblin, "s", 2], [goblin, "n", 2],
	],
	[
		[chief, "s", 2], [chief, "n", 1],
	],
	[
		[goblin, "n", 5], [bone, "e", 1],
	],
	[
		[goblin, "w", 4], [goblin, "e", 2], [masked, 1, "s"]
	],
	[
		[chief, "n", 2], [chief, "s", 2], [goblin, "w", 2]
	],
	[
		[bone, "w", 3], [bone, "e", 3]
	],
]
var level8 = "boss"
var level9 = [
	[
		[goo, "s", 1], [goo, "w", 1], [goo, "e", 1]
	],
	[
		[goblin, "e", 3], [goblin, "w", 5],
	],
	[
		[goblin, "s", 2], [bone, "n", 1], [goblin, "w", 4]
	],
	[
		[goo, "s", 3], [goblin, "n", 3]
	],
	[
		[goblin, "n", 5], [chief, "w", 1], [bone, "e", 2],
	],
	[
		[goblin, "w", 3], [masked, "n", 1], [masked, "s", 1]
	],
	[
		[bone, "w", 2], [goo, "e", 2],
	],
	[
		[goblin, "e", 3], [chief, "s", 1], [masked, "n", 1]
	],
	[
		[goblin, "w", 4], [goblin, "n", 3], [goblin, "s", 2], [bone, "e", 1]
	],
	[
		[goo, "e", 2], [goo, "w", 2]
	],
	[
		[goblin, "n", 2], [masked, "e", 2], [goblin, "s", 3]
	],
	[
		[chief, "e", 1], [goo, "n", 2], [bone, "s", 1]
	],
	[
		[goblin, "e", 5], [goblin, "n", 2], [goo, "w", 3]
	],
	[
		[goblin, "s", 8], [goblin, "n", 1]
	],
	[
		[masked, "w", 1], [masked, "e", 2]
	],
	[
		[goblin, "n", 5], [chief, "e", 1],
	],
	[
		[goo, "s", 2], [goo, "w", 2], [goblin, "e", 2], [goblin, "n", 2],
	],
	[
		[chief, "n", 1], [chief, "s", 1], [bone, "s", 1]
	],
	[
		[goblin, "s", 2], [goblin, "w", 3], [goblin, "n", 4],
	],
	[
		[masked, "n", 2], [goblin, "n", 2], [goblin, "n", 3], [goo, "n", 1]
	],
	[
		[goblin, "s", 4], [goblin, "s", 2], [goblin, "s", 3]
	],
	[
		[goo, "w", 3], [masked, "w", 1],
	],
	[
		[bone, "w", 3]
	],
	[
		[goo, "s", 9]
	],
]
var level10 = [
	[
		[masked, "n", 1], [goo, "w", 2], [goo, "e", 1], [goblin, "s", 1],
	],
	[
		[goblin, "w", 3], [bone, "s", 1], [goo, "e", 2], 
	],
	[
		[masked, "s", 1], [goblin, "w", 2], [masked, "n", 1]
	],
	[
		[goo, "s", 3], [goblin, "e", 5], 
	],
	[
		[bone, "n", 1], [goblin, "n", 2], [chief, "s", 1]
	],
	[
		[masked, "n", 1], [goo, "w", 1], [goblin, "e", 3], [goo, "s", 1]
	],
	[
		[goblin, "s", 4], [masked, "n", 1]
	],
	[
		[goblin, "e", 3], [goblin, "w", 2], [goblin, "e", 3], [goblin, "s", 2]
	],
	[
		[goblin, "e", 4], [masked, "w", 1]
	],
	[
		[bone, "e", 1], [bone, "w", 1], [goblin, "e", 2], [goblin, "s", 2],
		[goblin, "e", 1], [goblin, "w", 1]
	],
	[
		[goblin, "w", 4], [masked, "e", 1]
	],
	[
		[goo, "n", 6]
	],
	[
		[chief, "e", 1], [chief, "w", 1]
	],
	[
		[goblin, "s", 4], [bone, "w", 1]
	],
	[
		[goblin, "w", 4], [bone, "w", 2]
	],
	[
		[goblin, "n", 4], [goblin, "s", 2]
	],
	[
		[masked, "s", 1], [masked, "n", 1], [goblin, "e", 2]
	],
	[
		[goblin, "n", 5], [masked, "s", 2]
	],
	[
		[chief, "w", 2], [masked, "n", 1], [goo, "s", 2]
	],
	[
		[goblin, "n", 5], [goo, "n", 2], [goo, "n", 2], [goblin, "n", 1]
	],
	[
		[masked, "n", 1], [goblin, "w", 2], [bone, "e", 1], [goblin, "s", 3]
	],
	[
		[bone, "w", 2], [goo, "e", 4]
	],
	[
		[bone, "n", 2], [goo, "s", 4]
	],
	[
		[masked, "n", 1], [masked, "s", 1], [masked, "e", 1], [chief, "w", 2]
	],	
]
var level11 = "boss"
var levels = [
	level1, level2, level3, level4, level5, level6, level7, level8,
	level9, level10, level11
]
