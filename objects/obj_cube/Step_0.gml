if needDestroy == true{
	destroy()
}

if needCreate == true{
	create()
}

if needChangePosition == true{
	move_to(moveX,moveY)
}

if needEatAnimation == true{
	eat_animaiton(step)
	step++
}