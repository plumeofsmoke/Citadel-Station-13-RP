GLOBAL_VAR_INIT(timezoneOffset, 0) // The difference betwen midnight (of the host computer) and 0 world.ticks.

GLOBAL_VAR_INIT(gametime_offset, 432000) // 12:00 in seconds

GLOBAL_VAR_INIT(TAB, "&nbsp;&nbsp;&nbsp;&nbsp;")
GLOBAL_VAR_INIT(Debug2, FALSE)

//Loadout stuff
GLOBAL_DATUM_INIT(global_underwear, /datum/category_collection/underwear, new)

GLOBAL_VAR_INIT(internal_tick_usage, 0.2 * world.tick_lag)

// All religion stuff
GLOBAL_VAR(religion)
GLOBAL_VAR(deity)
GLOBAL_VAR(bible_name)
GLOBAL_VAR(bible_icon_state)
GLOBAL_VAR(bible_item_state)
GLOBAL_VAR(holy_weapon_type)
GLOBAL_VAR(holy_armor_type)
GLOBAL_VAR(holy_icon_type)
