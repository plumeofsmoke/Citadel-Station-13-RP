/obj/machinery/biogenerator
	name = "biogenerator"
	desc = "Converts plants into biomass, which can be used for fertilizer and sort-of-synthetic products."
	icon = 'icons/obj/biogenerator.dmi'
	icon_state = "biogen-stand"
	density = 1
	anchored = 1
	circuit = /obj/item/circuitboard/biogenerator
	use_power = USE_POWER_IDLE
	idle_power_usage = 40
	var/processing = 0
	var/obj/item/reagent_containers/glass/beaker = null
	var/points = 0
	var/menustat = "menu"
	var/build_eff = 1
	var/eat_eff = 1

/obj/machinery/biogenerator/Initialize(mapload, newdir)
	. = ..()
	var/datum/reagents/R = new/datum/reagents(1000)
	reagents = R
	R.my_atom = src

	beaker = new /obj/item/reagent_containers/glass/bottle(src)
	component_parts = list()
	component_parts += new /obj/item/stock_parts/matter_bin(src)
	component_parts += new /obj/item/stock_parts/manipulator(src)
	RefreshParts()

/obj/machinery/biogenerator/on_reagent_change()			//When the reagents change, change the icon as well.
	update_icon()

/obj/machinery/biogenerator/update_icon()
	if(!beaker)
		icon_state = "biogen-empty"
	else if(!processing)
		icon_state = "biogen-stand"
	else
		icon_state = "biogen-work"
	return

/obj/machinery/biogenerator/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(default_deconstruction_screwdriver(user, O))
		return
	if(default_deconstruction_crowbar(user, O))
		return
	if(default_part_replacement(user, O))
		return
	if(default_unfasten_wrench(user, O, 40))
		return
	if(istype(O, /obj/item/reagent_containers/glass))
		if(beaker)
			to_chat(user, "<span class='notice'>\The [src] is already loaded.</span>")
		else
			user.remove_from_mob(O)
			O.loc = src
			beaker = O
			updateUsrDialog()
	else if(processing)
		to_chat(user, "<span class='notice'>\The [src] is currently processing.</span>")
	else if(istype(O, /obj/item/storage/bag))
		var/i = 0
		for(var/obj/item/reagent_containers/food/snacks/grown/G in contents)
			i++
		if(i >= 10)
			to_chat(user, "<span class='notice'>\The [src] is already full! Activate it.</span>")
		else
			for(var/obj/item/reagent_containers/food/snacks/grown/G in O.contents)
				G.loc = src
				i++
				if(i >= 10)
					to_chat(user, "<span class='notice'>You fill \the [src] to its capacity.</span>")
					break
			if(i < 10)
				to_chat(user, "<span class='notice'>You empty \the [O] into \the [src].</span>")


	else if(!istype(O, /obj/item/reagent_containers/food/snacks/grown))
		to_chat(user, "<span class='notice'>You cannot put this in \the [src].</span>")
	else
		var/i = 0
		for(var/obj/item/reagent_containers/food/snacks/grown/G in contents)
			i++
		if(i >= 10)
			to_chat(user, "<span class='notice'>\The [src] is full! Activate it.</span>")
		else
			user.remove_from_mob(O)
			O.loc = src
			to_chat(user, "<span class='notice'>You put \the [O] in \the [src]</span>")
	update_icon()
	return

/obj/machinery/biogenerator/interact(mob/user as mob)
	if(stat & BROKEN)
		return
	user.set_machine(src)
	var/dat = "<TITLE>Biogenerator</TITLE>Biogenerator:<BR>"
	if(processing)
		dat += "<FONT COLOR=red>Biogenerator is processing! Please wait...</FONT>"
	else
		dat += "Biomass: [points] points.<HR>"
		switch(menustat)
			if("menu")
				if(beaker)
					dat += "<A href='?src=\ref[src];action=activate'>Activate Biogenerator!</A><BR>"
					dat += "<A href='?src=\ref[src];action=detach'>Detach Container</A><BR><BR>"
					dat += "Food:<BR>"
					dat += "<A href='?src=\ref[src];action=create;item=milk;cost=20'>10 milk</A> <FONT COLOR=blue>([round(20/build_eff)])</FONT> | <A href='?src=\ref[src];action=create;item=milk5;cost=95'>x5</A><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=cream;cost=30'>10 cream</A> <FONT COLOR=blue>([round(30/build_eff)])</FONT> | <A href='?src=\ref[src];action=create;item=cream5;cost=120'>x5</A><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=meat;cost=50'>Slab of meat</A> <FONT COLOR=blue>([round(50/build_eff)])</FONT> | <A href='?src=\ref[src];action=create;item=meat5;cost=24s0'>x5</A><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=eggbox;cost=80'>A dozen eggs</A> <FONT COLOR=blue>([round(80/build_eff)])</FONT><BR>"
					dat += "Nutrient:<BR>"
					dat += "<A href='?src=\ref[src];action=create;item=ez;cost=60'>E-Z-Nutrient</A> <FONT COLOR=blue>([round(60/build_eff)])</FONT> | <A href='?src=\ref[src];action=create;item=ez5;cost=300'>x5</A><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=l4z;cost=120'>Left 4 Zed</A> <FONT COLOR=blue>([round(120/build_eff)])</FONT> | <A href='?src=\ref[src];action=create;item=l4z5;cost=600'>x5</A><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=rh;cost=150'>Robust Harvest</A> <FONT COLOR=blue>([round(150/build_eff)])</FONT> | <A href='?src=\ref[src];action=create;item=rh5;cost=750'>x5</A><BR>"
					dat += "Leather:<BR>"
					dat += "<A href='?src=\ref[src];action=create;item=leather_sheet;cost=20'>Leather Sheet</A> <FONT COLOR=blue>([round(20/build_eff)])</FONT> | <A href='?src=\ref[src];action=create;item=leather_sheet5;cost=100'>x5</A><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=wallet;cost=100'>Wallet</A> <FONT COLOR=blue>([round(100/build_eff)])</FONT><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=gloves;cost=250'>Botanical gloves</A> <FONT COLOR=blue>([round(250/build_eff)])</FONT><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=plantbag;cost=320'>Plant bag</A> <FONT COLOR=blue>([round(320/build_eff)])</FONT><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=plantbaglarge;cost=640'>Large plant bag</A> <FONT COLOR=blue>([round(640/build_eff)])</FONT><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=tbelt;cost=300'>Utility belt</A> <FONT COLOR=blue>([round(300/build_eff)])</FONT><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=satchel;cost=400'>Leather Satchel</A> <FONT COLOR=blue>([round(400/build_eff)])</FONT><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=cashbag;cost=400'>Cash Bag</A> <FONT COLOR=blue>([round(400/build_eff)])</FONT><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=chembag;cost=400'>Chemistry Bag</A> <FONT COLOR=blue>([round(400/build_eff)])</FONT><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=workboots;cost=400'>Workboots</A> <FONT COLOR=blue>([round(400/build_eff)])</FONT><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=leathershoes;cost=400'>Leather Shoes</A> <FONT COLOR=blue>([round(400/build_eff)])</FONT><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=leatherchaps;cost=400'>Leather Chaps</A> <FONT COLOR=blue>([round(400/build_eff)])</FONT><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=leathercoat;cost=500'>Leather Coat</A> <FONT COLOR=blue>([round(500/build_eff)])</FONT><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=leatherjacket;cost=500'>Leather Jacket</A> <FONT COLOR=blue>([round(500/build_eff)])</FONT><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=wintercoat;cost=500'>Winter Coat</A> <FONT COLOR=blue>([round(500/build_eff)])</FONT><BR>"
					dat += "<A href='?src=\ref[src];action=create;item=algae;cost=400'>4 Algae Sheets</A> <FONT COLOR=blue>([round(400/build_eff)])</FONT><BR>" //VOREStation Edit - Algae for oxygen generator
					//dat += "Other<BR>"
					//dat += "<A href='?src=\ref[src];action=create;item=monkey;cost=500'>Monkey</A> <FONT COLOR=blue>(500)</FONT><BR>"
				else
					dat += "<BR><FONT COLOR=red>No beaker inside. Please insert a beaker.</FONT><BR>"
			if("nopoints")
				dat += "You do not have biomass to create products.<BR>Please, put growns into reactor and activate it.<BR>"
				dat += "<A href='?src=\ref[src];action=menu'>Return to menu</A>"
			if("complete")
				dat += "Operation complete.<BR>"
				dat += "<A href='?src=\ref[src];action=menu'>Return to menu</A>"
			if("void")
				dat += "<FONT COLOR=red>Error: No growns inside.</FONT><BR>Please, put growns into reactor.<BR>"
				dat += "<A href='?src=\ref[src];action=menu'>Return to menu</A>"
	user << browse(dat, "window=biogenerator")
	onclose(user, "biogenerator")
	return

/obj/machinery/biogenerator/attack_hand(mob/user as mob)
	interact(user)

/obj/machinery/biogenerator/proc/activate()
	if(usr.stat)
		return
	if(stat) //NOPOWER etc
		return
	if(processing)
		to_chat(usr, "<span class='notice'>The biogenerator is in the process of working.</span>")
		return
	var/S = 0
	for(var/obj/item/reagent_containers/food/snacks/grown/I in contents)
		S += 5
		if(I.reagents.get_reagent_amount("nutriment") < 0.1)
			points += 1
		else points += I.reagents.get_reagent_amount("nutriment") * 10 * eat_eff
		qdel(I)
	if(S)
		processing = 1
		update_icon()
		updateUsrDialog()
		playsound(src.loc, 'sound/machines/blender.ogg', 40, 1)
		use_power(S * 30)
		sleep((S + 15) / eat_eff)
		processing = 0
		playsound(src.loc, 'sound/machines/biogenerator_end.ogg', 40, 1)
		update_icon()
	else
		menustat = "void"
	return

/obj/machinery/biogenerator/proc/create_product(var/item, var/cost)
	cost = round(cost/build_eff)
	if(cost > points)
		menustat = "nopoints"
		return 0
	processing = 1
	update_icon()
	updateUsrDialog()
	points -= cost
	sleep(30)
	switch(item)
		if("milk")
			beaker.reagents.add_reagent("milk", 10)
		if("milk5")
			beaker.reagents.add_reagent("milk", 50)
		if("cream")
			beaker.reagents.add_reagent("cream", 10)
		if("cream5")
			beaker.reagents.add_reagent("cream", 50)
		if("meat")
			new/obj/item/reagent_containers/food/snacks/meat(loc)
		if("meat5")
			new/obj/item/reagent_containers/food/snacks/meat(loc) //This is ugly.
			new/obj/item/reagent_containers/food/snacks/meat(loc)
			new/obj/item/reagent_containers/food/snacks/meat(loc)
			new/obj/item/reagent_containers/food/snacks/meat(loc)
			new/obj/item/reagent_containers/food/snacks/meat(loc)
		if("eggbox")
			new/obj/item/storage/fancy/egg_box(loc)
		if("ez")
			new/obj/item/reagent_containers/glass/bottle/eznutrient(loc)
		if("l4z")
			new/obj/item/reagent_containers/glass/bottle/left4zed(loc)
		if("rh")
			new/obj/item/reagent_containers/glass/bottle/robustharvest(loc)
		if("ez5") //It's not an elegant method, but it's safe and easy. -Cheridan
			new/obj/item/reagent_containers/glass/bottle/eznutrient(loc)
			new/obj/item/reagent_containers/glass/bottle/eznutrient(loc)
			new/obj/item/reagent_containers/glass/bottle/eznutrient(loc)
			new/obj/item/reagent_containers/glass/bottle/eznutrient(loc)
			new/obj/item/reagent_containers/glass/bottle/eznutrient(loc)
		if("l4z5")
			new/obj/item/reagent_containers/glass/bottle/left4zed(loc)
			new/obj/item/reagent_containers/glass/bottle/left4zed(loc)
			new/obj/item/reagent_containers/glass/bottle/left4zed(loc)
			new/obj/item/reagent_containers/glass/bottle/left4zed(loc)
			new/obj/item/reagent_containers/glass/bottle/left4zed(loc)
		if("rh5")
			new/obj/item/reagent_containers/glass/bottle/robustharvest(loc)
			new/obj/item/reagent_containers/glass/bottle/robustharvest(loc)
			new/obj/item/reagent_containers/glass/bottle/robustharvest(loc)
			new/obj/item/reagent_containers/glass/bottle/robustharvest(loc)
			new/obj/item/reagent_containers/glass/bottle/robustharvest(loc)
		if("leather_sheet")
			new/obj/item/stack/material/leather(loc)
		if("leather_sheet5")
			new/obj/item/stack/material/leather(loc)
			new/obj/item/stack/material/leather(loc)
			new/obj/item/stack/material/leather(loc)
			new/obj/item/stack/material/leather(loc)
			new/obj/item/stack/material/leather(loc)
		if("wallet")
			new/obj/item/storage/wallet(loc)
		if("gloves")
			new/obj/item/clothing/gloves/botanic_leather(loc)
		if("plantbag")
			new/obj/item/storage/bag/plants(loc)
		if("plantbaglarge")
			new/obj/item/storage/bag/plants/large(loc)
		if("tbelt")
			new/obj/item/storage/belt/utility(loc)
		if("satchel")
			new/obj/item/storage/backpack/satchel(loc)
		if("cashbag")
			new/obj/item/storage/bag/cash(loc)
		if("chembag")
			new/obj/item/storage/bag/chemistry(loc)
		if("monkey")
			new/mob/living/carbon/human/monkey(loc)
		if("workboots")
			new/obj/item/clothing/shoes/boots/workboots(loc)
		if("leathershoes")
			new/obj/item/clothing/shoes/laceup/brown(loc)
		if("leatherchaps")
			new/obj/item/clothing/under/pants/chaps
		if("leathercoat")
			new/obj/item/clothing/suit/leathercoat(loc)
		if("leatherjacket")
			new/obj/item/clothing/suit/storage/toggle/brown_jacket(loc)
		if("wintercoat")
			new/obj/item/clothing/suit/storage/hooded/wintercoat(loc)
		if("algae") //VOREStation Edit - Algae for oxygen generator
			var/obj/item/stack/material/algae/A = new(loc)
			A.amount = 4 //VOREStation Edit End
	processing = 0
	menustat = "complete"
	update_icon()
	return 1

/obj/machinery/biogenerator/Topic(href, href_list)
	if(stat & BROKEN) return
	if(usr.stat || usr.restrained()) return
	if(!in_range(src, usr)) return

	usr.set_machine(src)

	switch(href_list["action"])
		if("activate")
			activate()
		if("detach")
			if(beaker)
				beaker.loc = src.loc
				beaker = null
				update_icon()
		if("create")
			create_product(href_list["item"], text2num(href_list["cost"]))
		if("menu")
			menustat = "menu"
	updateUsrDialog()

/obj/machinery/biogenerator/RefreshParts()
	..()
	var/man_rating = 0
	var/bin_rating = 0

	for(var/obj/item/stock_parts/P in component_parts)
		if(istype(P, /obj/item/stock_parts/matter_bin))
			bin_rating += P.rating
		if(istype(P, /obj/item/stock_parts/manipulator))
			man_rating += P.rating

	build_eff = man_rating
	eat_eff = bin_rating
