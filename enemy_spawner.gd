extends Node2D

var enemies = []
var time = 0
var enemies_number = 0
var enemiesbig_number = 0
var enemiesbig_number2 = 0
var enemy_scene = preload("res://Enemy.tscn")
var enemy_scenebig = preload("res://EnemyBig.tscn")
var enemy_scenebig_boss = preload("res://StageOneFinalBoss.tscn")
var enemy 
var boss_spawned = false
func _process(delta):
	time += delta
	if time as int == 10:
		get_node("spawn_timer1").start()
	if time as int == 25:
		get_node("spawn_timer2").start()
	if time as int == 45:
		get_node("spawn_timer3").start()
		get_node("spawn_timer4").start()
	if time as int == 60 || time as int == 80 || time as int == 120:
		swarm()
		spawn()
		add_child(enemy)
	if time as int == 85:
		get_node("spawn_timer5").start()
	if time as int == 100:
		get_node("spawn_timer6").start()
	if time as int == 135:
		get_node("spawn_timer7").start()
	if enemiesbig_number == 3:
		get_node("spawn_timer7").stop()
	if time as int == 160:
		get_node("spawn_timer8").start()
	if enemiesbig_number2 == 2:
		get_node("spawn_timer8").stop()
	if time as int == 185:
		get_node("spawn_timer2").start()
	if time as int == 215 and not boss_spawned:
		enemy = enemy_scenebig_boss.instance()
		enemy.name = "boss1"
		boss_spawned = true
		enemy.bullet_velocity = 200
		add_child(enemy)
		
func _on_spawn_timer_timeout():
	spawn()
	add_child(enemy)

func _on_spawn_timer2_timeout():
	get_node("spawn_timer1").stop()
	spawn()
	enemy.amplitude += 750
	enemy.velocity -= 80
	add_child(enemy)


func _on_spawn_timer3_timeout():
	get_node("spawn_timer2").stop()
	spawn()
	enemy.amplitude += 100
	enemy.freq += 10
	enemy.positiony = 100
	add_child(enemy)


func _on_spawn_timer4_timeout():
	spawn()
	enemy.amplitude += 100
	enemy.freq += 10
	enemy.positiony = 400
	add_child(enemy)


func _on_spawn_timer5_timeout():
	spawn()
	enemy.amplitude += 100
	enemy.freq += 10
	enemy.positiony = 250
	add_child(enemy)
	
func spawn():
	enemy = enemy_scene.instance()
	enemy.name = "enemy"+str(enemies_number)
	enemies_number += 1
func spawnbig():
	enemy = enemy_scenebig.instance()
	enemy.name = "big"+str(enemiesbig_number)

func _on_spawn_timer6_timeout():
	get_node("spawn_timer3").stop()
	get_node("spawn_timer4").stop()
	spawn()
	var amp = rand_range(90.5,800.5)
	var y = rand_range(1.1,190.5)
	enemy.amplitude += amp
	enemy.positiony -= y
	add_child(enemy)

func swarm():
	var label = get_parent().get_node("Label")
	label.text = "DEMON'S SWARM"
	label.visible = true
	yield(get_tree().create_timer(3),"timeout")
	label.visible = false


func _on_spawn_timer7_timeout():
	get_node("spawn_timer5").stop()
	spawnbig()
	add_child(enemy)
	enemiesbig_number += 1


func _on_spawn_timer8_timeout():
	spawnbig()
	add_child(enemy)
	enemiesbig_number2 +=1

