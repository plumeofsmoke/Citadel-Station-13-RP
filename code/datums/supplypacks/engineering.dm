/*
*	Here is where any supply packs
*	related to engineering tasks live.
*/


/datum/supply_pack/eng
	group = "Engineering"

/datum/supply_pack/eng/lightbulbs
	name = "Replacement lights"
	contains = list(/obj/item/storage/box/lights/mixed = 3)
	cost = 10
	containertype = /obj/structure/closet/crate
	containername = "Replacement lights"

/datum/supply_pack/eng/smescoil
	name = "Superconducting Magnetic Coil"
	contains = list(/obj/item/smes_coil)
	cost = 20
	containertype = /obj/structure/closet/crate/engineering
	containername = "Superconducting Magnetic Coil crate"

/datum/supply_pack/eng/smescoil/super_capacity
	name = "Superconducting Capacitance Coil"
	contains = list(/obj/item/smes_coil/super_capacity)
	cost = 25
	containertype = /obj/structure/closet/crate/engineering
	containername = "Superconducting Capacitance Coil crate"

/datum/supply_pack/eng/smescoil/super_io
	name = "Superconducting Transmission Coil"
	contains = list(/obj/item/smes_coil/super_io)
	cost = 25
	containertype = /obj/structure/closet/crate/engineering
	containername = "Superconducting Transmission Coil crate"

/datum/supply_pack/eng/electrical
	name = "Electrical maintenance crate"
	contains = list(
			/obj/item/storage/toolbox/electrical = 2,
			/obj/item/clothing/gloves/yellow = 2,
			/obj/item/cell = 2,
			/obj/item/cell/high = 2
			)
	cost = 10
	containertype = /obj/structure/closet/crate/engineering/electrical
	containername = "Electrical maintenance crate"

/datum/supply_pack/eng/e_welders
	name = "Electric welder crate"
	contains = list(
			/obj/item/weldingtool/electric = 3
			)
	cost = 15
	containertype = /obj/structure/closet/crate/engineering/electrical
	containername = "Electric welder crate"

/datum/supply_pack/eng/mechanical
	name = "Mechanical maintenance crate"
	contains = list(
			/obj/item/storage/belt/utility/full = 3,
			/obj/item/clothing/suit/storage/hazardvest = 3,
			/obj/item/clothing/head/welding = 2,
			/obj/item/clothing/head/hardhat
			)
	cost = 10
	containertype = /obj/structure/closet/crate/engineering
	containername = "Mechanical maintenance crate"

/datum/supply_pack/eng/fueltank
	name = "Fuel tank crate"
	contains = list(/obj/structure/reagent_dispensers/fueltank)
	cost = 10
	containertype = /obj/structure/largecrate
	containername = "fuel tank crate"

/datum/supply_pack/eng/solar
	name = "Solar Pack crate"
	contains  = list(
			/obj/item/solar_assembly = 21,
			/obj/item/circuitboard/solar_control,
			/obj/item/tracker_electronics,
			/obj/item/paper/solar
			)
	cost = 20
	containertype = /obj/structure/closet/crate/engineering
	containername = "Solar pack crate"

/datum/supply_pack/eng/engine
	name = "Emitter crate"
	contains = list(/obj/machinery/power/emitter = 2)
	cost = 10
	containertype = /obj/structure/closet/crate/secure/engineering
	containername = "Emitter crate"
	access = access_ce

/datum/supply_pack/eng/engine/field_gen
	name = "Field Generator crate"
	contains = list(/obj/machinery/field_generator = 2)
	containertype = /obj/structure/closet/crate/secure/engineering
	containername = "Field Generator crate"
	access = access_ce

/datum/supply_pack/eng/engine/sing_gen
	name = "Singularity Generator crate"
	contains = list(/obj/machinery/the_singularitygen)
	containertype = /obj/structure/closet/crate/secure/engineering
	containername = "Singularity Generator crate"
	access = access_ce

/datum/supply_pack/eng/engine/collector
	name = "Collector crate"
	contains = list(/obj/machinery/power/rad_collector = 3)
	containertype = /obj/structure/closet/crate/secure/engineering
	containername = "collector crate"
	access = access_engine

/datum/supply_pack/eng/engine/PA
	name = "Particle Accelerator crate"
	cost = 40
	contains = list(
			/obj/structure/particle_accelerator/fuel_chamber,
			/obj/machinery/particle_accelerator/control_box,
			/obj/structure/particle_accelerator/particle_emitter/center,
			/obj/structure/particle_accelerator/particle_emitter/left,
			/obj/structure/particle_accelerator/particle_emitter/right,
			/obj/structure/particle_accelerator/power_box,
			/obj/structure/particle_accelerator/end_cap,
			/obj/item/paper/particle_info
			)
	containertype = /obj/structure/closet/crate/secure/engineering
	containername = "Particle Accelerator crate"
	access = access_ce

/datum/supply_pack/eng/shield_generator
	name = "Shield Generator Construction Kit"
	contains = list(
		/obj/item/circuitboard/shield_generator,
		/obj/item/stock_parts/capacitor,
		/obj/item/stock_parts/micro_laser,
		/obj/item/smes_coil,
		/obj/item/stock_parts/console_screen,
		/obj/item/stock_parts/subspace/amplifier
		)
	cost = 80
	containertype = /obj/structure/closet/crate/engineering
	containername = "shield generator construction kit crate"
/datum/supply_pack/eng/smbig
	name = "Supermatter Core"
	contains = list(/obj/machinery/power/supermatter)
	cost = 150
	containertype = /obj/structure/closet/crate/secure/phoron
	containername = "Supermatter crate (CAUTION)"
	access = access_ce

/datum/supply_pack/eng/teg
	contains = list(
		/obj/machinery/power/generator,
		/obj/machinery/atmospherics/binary/circulator = 2)
	name = "Mark I TEG + Circulators"
	cost = 35
	containertype = /obj/structure/closet/crate/secure/large
	containername = "Mk1 TEG crate"
	access = access_engine
/*
/datum/supply_pack/eng/circulator
	contains = list(/obj/machinery/atmospherics/binary/circulator = 2)
	name = "Binary atmospheric circulators"
	cost = 15
	containertype = /obj/structure/closet/crate/secure/large
	containername = "Atmospheric circulators crate"
	access = access_engine
*/
/datum/supply_pack/eng/radsuit
	contains = list(
			/obj/item/clothing/suit/radiation = 3,
			/obj/item/clothing/head/radiation = 3
			)
	name = "Radiation suits package"
	cost = 20
	containertype = /obj/structure/closet/radiation
	containername = "Radiation suit locker"

/datum/supply_pack/eng/pacman_parts
	name = "P.A.C.M.A.N. portable generator parts"
	cost = 25
	containername = "P.A.C.M.A.N. Portable Generator Construction Kit"
	containertype = /obj/structure/closet/crate/secure/engineering
	access = access_tech_storage
	contains = list(
			/obj/item/stock_parts/micro_laser,
			/obj/item/stock_parts/capacitor,
			/obj/item/stock_parts/matter_bin,
			/obj/item/circuitboard/pacman
			)

/datum/supply_pack/eng/super_pacman_parts
	name = "Super P.A.C.M.A.N. portable generator parts"
	cost = 35
	containername = "Super P.A.C.M.A.N. portable generator construction kit"
	containertype = /obj/structure/closet/crate/secure/engineering
	access = access_tech_storage
	contains = list(
			/obj/item/stock_parts/micro_laser,
			/obj/item/stock_parts/capacitor,
			/obj/item/stock_parts/matter_bin,
			/obj/item/circuitboard/pacman/super
			)

/datum/supply_pack/eng/fusion_core
	name = "R-UST Mk. 8 Tokamak fusion core crate"
	cost = 50
	containername = "R-UST Mk. 8 Tokamak Fusion Core crate"
	containertype = /obj/structure/closet/crate/secure/engineering
	access = access_engine
	contains = list(
			/obj/item/book/manual/rust_engine,
			/obj/machinery/power/fusion_core,
			/obj/item/circuitboard/fusion_core
			)

/datum/supply_pack/eng/fusion_fuel_injector
	name = "R-UST Mk. 8 fuel injector crate"
	cost = 30
	containername = "R-UST Mk. 8 fuel injector crate"
	containertype = /obj/structure/closet/crate/secure/engineering
	access = access_engine
	contains = list(
			/obj/machinery/fusion_fuel_injector,
			/obj/machinery/fusion_fuel_injector,
			/obj/item/circuitboard/fusion_injector
			)

/datum/supply_pack/eng/gyrotron
	name = "Gyrotron crate"
	cost = 15
	containername = "Gyrotron Crate"
	containertype = /obj/structure/closet/crate/secure/engineering
	access = access_engine
	contains = list(
			/obj/machinery/power/emitter/gyrotron,
			/obj/item/circuitboard/gyrotron_control
			)

/datum/supply_pack/eng/fusion_fuel_compressor
	name = "Fusion Fuel Compressor circuitry crate"
	cost = 10
	containername = "Fusion Fuel Compressor circuitry crate"
	containertype = /obj/structure/closet/crate/engineering
	contains = list(/obj/item/circuitboard/fusion_fuel_compressor)

/datum/supply_pack/eng/tritium
	name = "Tritium crate"
	cost = 75
	containername = "Tritium crate"
	containertype = /obj/structure/closet/crate/engineering
	contains = list(/obj/fiftyspawner/tritium)

/datum/supply_pack/eng/engine/fission
	name = "Fission Starter crate"
	contains = list(/obj/machinery/power/fission,
			/obj/item/circuitboard/fission_monitor,
			/obj/item/storage/briefcase/fission/fuelmixed,
			/obj/item/storage/briefcase/fission/reflectormixed,
			/obj/item/storage/briefcase/fission/controlmixed)
	cost = 50
	containertype = /obj/structure/closet/crate/secure/engineering
	containername = "fission core crate"
	access = access_ce

/datum/supply_pack/eng/engine/fission/expansion
	name = "Fission Expansion crate"
	contains = list(/obj/item/circuitboard/fission_monitor,
			/obj/item/storage/briefcase/fission/uranium,
			/obj/item/storage/briefcase/fission/tungstencarbide,
			/obj/item/storage/briefcase/fission/boron)
	cost = 30
	containertype = /obj/structure/closet/crate/secure/engineering
	containername = "fission expansion crate"
	access = access_ce

/datum/supply_pack/eng/thermoregulator
	contains = list(/obj/machinery/power/thermoregulator)
	name = "Thermal Regulator"
	cost = 30
	containertype = /obj/structure/closet/crate/large
	containername = "thermal regulator crate"

/datum/supply_pack/eng/radsuit
	contains = list(
			/obj/item/clothing/suit/radiation = 3,
			/obj/item/clothing/head/radiation = 3
			)

/datum/supply_pack/eng/algae
	contains = list(/obj/item/stack/material/algae/ten)
	name = "Algae Sheets (10)"
	cost = 20
	containertype = /obj/structure/closet/crate
	containername = "algae sheets crate"

/datum/supply_pack/eng/engine/tesla_gen
	name = "Tesla Generator crate"
	contains = list(/obj/machinery/the_singularitygen/tesla)
	containertype = /obj/structure/closet/crate/secure/engineering
	containername = "Tesla Generator crate"
	access = access_ce

/datum/supply_pack/eng/point_defense_cannon_circuit
	name = "Point Defense Turret Circuit"
	contains = list(/obj/item/circuitboard/pointdefense = 2)
	cost = 20
	containertype = /obj/structure/closet/crate/heph
	containername = "point defense turret circuit crate"

/datum/supply_pack/eng/point_defense_control_circuit
	name = "Point Defense Controller Circuit"
	contains = list(/obj/item/circuitboard/pointdefense_control = 1)
	cost = 30
	containertype = /obj/structure/closet/crate/heph
	containername = "point defense mainframe circuit crate"
