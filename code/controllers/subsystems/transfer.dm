SUBSYSTEM_DEF(transfer)
	wait = 10 SECONDS
	name = "Transfer"
	var/timerbuffer = 0 //buffer for time check
	var/currenttick = 0
	var/shift_hard_end = 0 //VOREStation Edit
	var/shift_last_vote = 0 //Citadel Edit

// should be a config someday lol
#define NUMBER_OF_VOTE_EXTENSIONS 2

/datum/controller/subsystem/transfer/Initialize()
	timerbuffer = config_legacy.vote_autotransfer_initial
	shift_hard_end = config_legacy.vote_autotransfer_initial + (config_legacy.vote_autotransfer_interval * NUMBER_OF_VOTE_EXTENSIONS) //VOREStation Edit //Change this "1" to how many extend votes you want there to be.
	shift_last_vote = shift_hard_end - config_legacy.vote_autotransfer_interval //VOREStation Edit
	return ..()

/datum/controller/subsystem/transfer/fire(resumed)
	currenttick = currenttick + 1
	//VOREStation Edit START
/*	if (round_duration_in_ds >= shift_last_vote - 2 MINUTES)
		shift_last_vote = 999999999999 //Setting to a stupidly high number since it'll be not used again.
		to_world("<b>Warning: This upcoming round-extend vote will be your ONLY extend vote. Wrap up your scenes in the next 60 minutes if the round is extended.</b>") //VOREStation Edit
*/
	if (round_duration_in_ds >= shift_hard_end - 1 MINUTE)
		init_shift_change(null, 1)
		shift_hard_end = timerbuffer + config_legacy.vote_autotransfer_interval //If shuttle somehow gets recalled, let's force it to call again next time a vote would occur.
		timerbuffer = timerbuffer + config_legacy.vote_autotransfer_interval //Just to make sure a vote doesn't occur immediately afterwords.
	else if (round_duration_in_ds >= timerbuffer - 1 MINUTE)
		SSvote.autotransfer()
	//VOREStation Edit END
		timerbuffer = timerbuffer + config_legacy.vote_autotransfer_interval
