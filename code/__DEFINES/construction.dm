//
// Frame construction
//

// Frame construction states
#define FRAME_PLACED 0		// Has been placed (can be anchored or not).
#define FRAME_UNFASTENED 1	// Circuit added.
#define FRAME_FASTENED 2	// Circuit fastened.
#define FRAME_WIRED 3		// Frame wired.
#define FRAME_PANELED 4		// Glass panel added.

// The frame classes define a sequence of construction steps.
#define FRAME_CLASS_ALARM "alarm"
#define FRAME_CLASS_COMPUTER "computer"
#define FRAME_CLASS_DISPLAY "display"
#define FRAME_CLASS_MACHINE "machine"

// Does the frame get built on the floor or a wall?
#define FRAME_STYLE_FLOOR "floor"
#define FRAME_STYLE_WALL "wall"

//
// Pipe Construction
//

//Construction Orientation Types - Each of these categories has a different selection of how pipes can rotate and flip. Used for RPD.
#define PIPE_STRAIGHT			0	// 2 directions: N/S, E/W
#define PIPE_BENDABLE			1	// 6 directions: N/S, E/W, N/E, N/W, S/E, S/W
#define PIPE_TRINARY			2	// 4 directions: N/E/S, E/S/W, S/W/N, W/N/E
#define PIPE_TRIN_M				3	// 8 directions: N->S+E, S->N+E, N->S+W, S->N+W, E->W+S, W->E+S, E->W+N, W->E+N
#define PIPE_DIRECTIONAL		4	// 4 directions: N, S, E, W
#define PIPE_ONEDIR				5	// 1 direction: N/S/E/W
#define PIPE_UNARY_FLIPPABLE	6	// 8 directions: N, S, E, W, N-flipped, S-flipped, E-flipped, W-flipped
#define PIPE_TRIN_T				7	// 8 directions: N->S+E, S->N+E, N->S+W, S->N+W, E->W+S, W->E+S, E->W+N, W->E+N

// Pipe connectivity bit flags
#define CONNECT_TYPE_REGULAR	1	// Center of tile, 'normal'
#define CONNECT_TYPE_SUPPLY		2	// Atmos air supply pipes
#define CONNECT_TYPE_SCRUBBER	4	// Atmos air scrubber pipes
#define CONNECT_TYPE_HE			8	// Heat exchanger pipes
#define CONNECT_TYPE_FUEL		16	// Fuel pipes for overmap ships
#define CONNECT_TYPE_AUX		32	// Aux pipes for 'other' things (airlocks, etc)

// We are based on the three named layers of supply, regular, and scrubber.
#define PIPING_LAYER_SUPPLY		1
#define PIPING_LAYER_REGULAR	2
#define PIPING_LAYER_SCRUBBER	3
#define PIPING_LAYER_FUEL		4
#define PIPING_LAYER_AUX		5
#define PIPING_LAYER_DEFAULT	PIPING_LAYER_REGULAR

// We offset the layer values of the different pipe types to ensure they look nice
#define PIPES_SCRUBBER_LAYER	(PIPES_LAYER - 0.05)
#define PIPES_AUX_LAYER			(PIPES_LAYER - 0.04)
#define PIPES_FUEL_LAYER		(PIPES_LAYER - 0.03)
#define PIPES_SUPPLY_LAYER		(PIPES_LAYER - 0.01)
#define PIPES_HE_LAYER			(PIPES_LAYER + 0.01)

// Pipe flags
#define PIPING_ALL_LAYER 1					// Intended to connect with all layers, check for all instead of just one.
#define PIPING_ONE_PER_TURF 2 				// Can only be built if nothing else with this flag is on the tile already.
#define PIPING_DEFAULT_LAYER_ONLY 4			// Can only exist at PIPING_LAYER_DEFAULT
#define PIPING_CARDINAL_AUTONORMALIZE 8		// North/South East/West doesn't matter, auto normalize on build.

// Macro for easy use of boilerplate code for searching for a valid node connection.
#define STANDARD_ATMOS_CHOOSE_NODE(node_num, direction) \
	for(var/obj/machinery/atmospherics/target in get_step(src, direction)) { \
		if(can_be_node(target, node_num)) { \
			node##node_num = target; \
			break; \
		} \
	}

//
// Disposals Construction
//
#define DISPOSAL_PIPE_STRAIGHT			0
#define DISPOSAL_PIPE_CORNER			1
#define DISPOSAL_PIPE_JUNCTION			2
#define DISPOSAL_PIPE_JUNCTION_FLIPPED	3
#define DISPOSAL_PIPE_JUNCTION_Y		4
#define DISPOSAL_PIPE_TRUNK				5
#define DISPOSAL_PIPE_BIN				6
#define DISPOSAL_PIPE_OUTLET			7
#define DISPOSAL_PIPE_CHUTE				8
#define DISPOSAL_PIPE_SORTER			9
#define DISPOSAL_PIPE_SORTER_FLIPPED	10
#define DISPOSAL_PIPE_UPWARD			11
#define DISPOSAL_PIPE_DOWNWARD			12
#define DISPOSAL_PIPE_TAGGER			13
#define DISPOSAL_PIPE_TAGGER_PARTIAL	14

#define DISPOSAL_SORT_NORMAL			0
#define DISPOSAL_SORT_WILDCARD			1
#define DISPOSAL_SORT_UNTAGGED			2

//tablecrafting defines
#define CAT_NONE	""
#define CAT_WEAPONRY	"Weaponry"
#define CAT_WEAPON	"Ranged Weapons"
#define CAT_MELEE	"Melee Weapons"
#define CAT_MISC	"Misc"
#define CAT_AMMO	"Ammunition"
#define CAT_PARTS	"Weapon Parts"
#define CAT_ROBOT	"Robots"
#define CAT_MISCELLANEOUS	"Miscellaneous"
#define CAT_OTHER	"Other"
#define CAT_TOOL	"Tools & Storage"
#define CAT_FURNITURE	"Furniture"
#define CAT_PRIMAL  "Tribal"
#define CAT_CLOTHING	"Clothing"
#define CAT_FOOD	"Foods"
#define CAT_BREAD	"Breads"
#define CAT_BURGER	"Burgers"
#define CAT_CAKE	"Cakes"
#define CAT_DONUT	"Donuts"
#define CAT_EGG	"Egg-Based Food"
#define CAT_MEAT	"Meats"
#define CAT_MEXICAN	"Mexican"
#define CAT_MISCFOOD	"Misc. Food"
#define CAT_PASTRY	"Pastries"
#define CAT_PIE	"Pies & Sweets"
#define CAT_PIZZA	"Pizzas"
#define CAT_SALAD	"Salads"
#define CAT_SEAFOOD    "Seafood"
#define CAT_SANDWICH	"Sandwiches"
#define CAT_SOUP	"Soups"
#define CAT_SPAGHETTI	"Spaghettis"
#define CAT_ICE	"Frozen"
