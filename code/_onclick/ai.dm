/*
	AI ClickOn()

	Note currently ai restrained() returns 0 in all cases,
	therefore restrained code has been removed

	The AI can double click to move the camera (this was already true but is cleaner),
	or double click a mob to track them.

	Note that AI have no need for the adjacency proc, and so this proc is a lot cleaner.
*/
/mob/living/silicon/ai/DblClickOn(var/atom/A, params)
	if(client.buildmode) // comes after object.Click to allow buildmode gui objects to be clicked
		build_click(src, client.buildmode, params, A)
		return

	if(control_disabled || stat) return

	if(ismob(A))
		ai_actual_track(A)
	else
		A.move_camera_by_click()


/mob/living/silicon/ai/ClickOn(var/atom/A, params)
	if(world.time <= next_click)
		return
	next_click = world.time + 1

	if(client.buildmode) // comes after object.Click to allow buildmode gui objects to be clicked
		build_click(src, client.buildmode, params, A)
		return

	if(stat)
		return

	var/list/modifiers = params2list(params)
	if(modifiers["shift"] && modifiers["ctrl"])
		CtrlShiftClickOn(A)
		return
	if(modifiers["middle"])
		MiddleClickOn(A)
		return
	if(modifiers["shift"])
		ShiftClickOn(A)
		return
	if(modifiers["alt"]) // alt and alt-gr (rightalt)
		AltClickOn(A)
		return
	if(modifiers["ctrl"])
		CtrlClickOn(A)
		return

	if(control_disabled || !canClick())
		return

	if(aiCamera.in_camera_mode)
		aiCamera.camera_mode_off()
		aiCamera.captureimage(A, usr)
		return

	/*
		AI restrained() currently does nothing
	if(restrained())
		RestrainedClickOn(A)
	else
	*/
	A.add_hiddenprint(src)
	A.attack_ai(src)

/*
	AI has no need for the UnarmedAttack() and RangedAttack() procs,
	because the AI code is not generic;	attack_ai() is used instead.
	The below is only really for safety, or you can alter the way
	it functions and re-insert it above.
*/
/mob/living/silicon/ai/UnarmedAttack(atom/A)
	A.attack_ai(src)
/mob/living/silicon/ai/RangedAttack(atom/A)
	A.attack_ai(src)

/atom/proc/attack_ai(mob/user as mob)
	return

/*
	Since the AI handles shift, ctrl, and alt-click differently
	than anything else in the game, atoms have separate procs
	for AI shift, ctrl, and alt clicking.
*/

/mob/living/silicon/ai/ShiftClickOn(var/atom/A)
	if(!control_disabled && A.AIShiftClick(src))
		return
	..()

/mob/living/silicon/ai/CtrlClickOn(var/atom/A)
	if(!control_disabled && A.AICtrlClick(src))
		return
	..()

/mob/living/silicon/ai/AltClickOn(var/atom/A)
	if(!control_disabled && A.AIAltClick(src))
		return
	..()

/mob/living/silicon/ai/MiddleClickOn(var/atom/A)
	if(!control_disabled && A.AIMiddleClick(src))
		return
	..()

/*
	The following criminally helpful code is just the previous code cleaned up;
	I have no idea why it was in atoms.dm instead of respective files.
*/

/atom/proc/AICtrlShiftClick(mob/user)
	return

/atom/proc/AIShiftClick(mob/user)
	return

/obj/machinery/door/airlock/AIShiftClick(mob/user)  // Opens and closes doors!
	add_hiddenprint(user)
	toggle_open(user)//instead of topic() procs
	return 1

/atom/proc/AICtrlClick(mob/user)
	return

/obj/machinery/door/airlock/AICtrlClick(mob/user) // Bolts doors
	add_hiddenprint(user)
	toggle_bolt(user)//apparently this is better than the topic function
	return 1

/obj/machinery/power/apc/AICtrlClick(mob/user) // turns off/on APCs.
	add_hiddenprint(user)
	toggle_breaker(user)
	return 1

/obj/machinery/turretid/AICtrlClick(mob/user) //turns off/on Turrets
	add_hiddenprint(user)
	enabled = !enabled //toggles the turret on/off
	return 1

/atom/proc/AIAltClick(var/atom/A)
	return AltClick(A)

/obj/machinery/door/airlock/AIAltClick(mob/user) // Electrifies doors.
	if(electrified_until)
		electrify(0, 1)
	else
		electrify(-1,1)
	return 1

/obj/machinery/turretid/AIAltClick(mob/user) //toggles lethal on turrets
	add_hiddenprint(user)
	lethal = !lethal
	return 1

/atom/proc/AIMiddleClick(var/mob/living/silicon/user)
	return 0

/obj/machinery/door/airlock/AIMiddleClick(mob/user) // Toggles door bolt lights.
	if(..())
		return
	add_hiddenprint(user)
	if(wires.is_cut(WIRE_BOLT_LIGHT))
		to_chat(user, "The lights are not responsive to your command.")
		return
	lights = !lights
	to_chat(user, "<span class='notice'>Lights are now [lights ? "enabled." : "disabled."]</span>")
	update_icon()
	return 1

//
// Override AdjacentQuick for AltClicking
//

/mob/living/silicon/ai/TurfAdjacent(var/turf/T)
	return (cameranet && cameranet.checkTurfVis(T))
