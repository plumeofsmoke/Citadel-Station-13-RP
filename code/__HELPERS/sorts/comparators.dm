//
// Comparators for use with /datum/sortInstance (or wherever you want)
// They should return negative, zero, or positive numbers for a < b, a == b, and a > b respectively.
//

/proc/cmp_numeric_dsc(a,b)
	return b - a

/proc/cmp_numeric_asc(a,b)
	return a - b

/proc/cmp_text_asc(a,b)
	return sorttext(b,a)

/proc/cmp_text_dsc(a,b)
	return sorttext(a,b)

/proc/cmp_name_asc(atom/a, atom/b)
	return sorttext(b.name, a.name)

/proc/cmp_name_dsc(atom/a, atom/b)
	return sorttext(a.name, b.name)

GLOBAL_VAR_INIT(cmp_field, "name")
/proc/cmp_records_asc(datum/data/record/a, datum/data/record/b)
	return sorttext(b.fields[GLOB.cmp_field], a.fields[GLOB.cmp_field])

/proc/cmp_records_dsc(datum/data/record/a, datum/data/record/b)
	return sorttext(a.fields[GLOB.cmp_field], b.fields[GLOB.cmp_field])

// Datum cmp with vars is always slower than a specialist cmp proc, use your judgement.
/proc/cmp_datum_numeric_asc(datum/a, datum/b, variable)
	return cmp_numeric_asc(a.vars[variable], b.vars[variable])

/proc/cmp_datum_numeric_dsc(datum/a, datum/b, variable)
	return cmp_numeric_dsc(a.vars[variable], b.vars[variable])

/proc/cmp_datum_text_asc(datum/a, datum/b, variable)
	return sorttext(b.vars[variable], a.vars[variable])

/proc/cmp_datum_text_dsc(datum/a, datum/b, variable)
	return sorttext(a.vars[variable], b.vars[variable])

/proc/cmp_ckey_asc(client/a, client/b)
	return sorttext(b.ckey, a.ckey)

/proc/cmp_ckey_dsc(client/a, client/b)
	return sorttext(a.ckey, b.ckey)

// Sorts subsystems alphabetically
/proc/cmp_subsystem_display(datum/controller/subsystem/a, datum/controller/subsystem/b)
	return sorttext(b.name, a.name)

// Sorts subsystems by init_order
/proc/cmp_subsystem_init(datum/controller/subsystem/a, datum/controller/subsystem/b)
	return initial(b.init_order) - initial(a.init_order)	//uses initial() so it can be used on types

// Sorts subsystems by priority
/proc/cmp_subsystem_priority(datum/controller/subsystem/a, datum/controller/subsystem/b)
	return a.priority - b.priority

/proc/cmp_filter_data_priority(list/A, list/B)
	return A["priority"] - B["priority"]

/proc/cmp_timer(datum/timedevent/a, datum/timedevent/b)
	return a.timeToRun - b.timeToRun

// Sorts qdel statistics recorsd by time and count
/proc/cmp_qdel_item_time(datum/qdel_item/A, datum/qdel_item/B)
	. = B.hard_delete_time - A.hard_delete_time
	if (!.)
		. = B.destroy_time - A.destroy_time
	if (!.)
		. = B.failures - A.failures
	if (!.)
		. = B.qdels - A.qdels

// Sorts jobs by department, and then by flag within department
/proc/cmp_job_datums(var/datum/job/a, var/datum/job/b)
	. = 0
	if( LAZYLEN(a.departments) && LAZYLEN(b.departments) )
		var/list/common_departments = a.departments & b.departments // Makes a list that contains only departments that were in both.
		if(!common_departments.len)
			. = sorttext(b.departments[1], a.departments[1])

	if(. == 0) //Same department, push up if they're a head
		. = b.sorting_order - a.sorting_order

	if(. == 0) //Already in same sorting order, sort by name
		. = sorttext(b.title, a.title)

/proc/cmp_department_datums(var/datum/department/a, var/datum/department/b)
	. = b.sorting_order - a.sorting_order // First, sort by the sorting order vars.
	if(. == 0) // If they have the same var, then sort by name.
		. = sorttext(b.name, a.name)

// Sorts entries in a performance stats list.
/proc/cmp_generic_stat_item_time(list/A, list/B)
	. = B[STAT_ENTRY_TIME] - A[STAT_ENTRY_TIME]
	if (!.)
		. = B[STAT_ENTRY_COUNT] - A[STAT_ENTRY_COUNT]

// Compares complexity of recipes for use in cooking, etc. This is for telling which recipe to make, not for showing things to the player.
/proc/cmp_recipe_complexity_dsc(datum/recipe/A, datum/recipe/B)
	var/a_score = LAZYLEN(A.items) + LAZYLEN(A.reagents) + LAZYLEN(A.fruit)
	var/b_score = LAZYLEN(B.items) + LAZYLEN(B.reagents) + LAZYLEN(B.fruit)
	return b_score - a_score

/proc/cmp_area_names_asc(area/A, area/B)
	return sorttext(B.name, A.name)

/proc/cmp_area_names_dsc(area/A, area/B)
	return sorttext(A.name, B.name)

/proc/cmp_surgery_priority_asc(datum/surgery_step/A, datum/surgery_step/B)
	return B.priority - A.priority

/proc/cmp_holiday_priority(datum/holiday/A, datum/holiday/B)
	return A.priority - B.priority
