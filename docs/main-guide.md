Age of Empires II
Definitive Random Map Scripting Guide
CLICK HERE for a lightweight read-only version
CLICK HERE for the version with a full document outline (also read-only; but you may request edit access)
Table of Contents
Introduction
Syntax Overview
Syntax Skeleton
	PLAYER_SETUP
	LAND_GENERATION
	ELEVATION_GENERATION
	CLIFF_GENERATION
	TERRAIN_GENERATION
	CONNECTION_GENERATION
	OBJECTS_GENERATION
	Global Syntax
	Random Code
	Conditionals
	Map Sizes
	Math Operations
	Walls
Constant Reference
	Terrains
	Objects
	Effects
	Attributes
	Resources
	Technologies
	Classes
	Miscellaneous
Scripting and Testing
	Standard Units and Resources
	Game Mode Support
	Testing
	Publishing a Map
	Updating an Old Map for DE
Links and Resources
	Videos
	General Guides
	Example Scripts
	Syntax Highlighting
Appendix
	DE Update Changelogs
Introduction
Foreword
This guide is a comprehensive documentation of random map scripting in Age of Empires 2.  It was written after the release of the Definitive Edition, but is relevant for all older versions of AoE2 as well.  It is updated regularly, especially after the Definitive Edition adds new features to random map scripting.
If you notice typos, mistakes, inaccuracies, dead links, etc. or you have comments, suggestions or additions, contact me (on Discord) and I can fix the issue or give you commenting or editing permissions.
Come join the Random Map Discord to chat with other map scripters!
Have fun map scripting!  ~Zetnus
What is an RMS?
RMS stands for Random Map Script.  An RMS is what the game uses to randomly generate maps (such as Arabia or Black Forest).  Random Map Scripts are NOT scenarios and are NOT produced in the in-game editor (but they can be generated and tested in the editor).  They look different every time.  They are plain text files (with the extension .rms) and are made in any text editor (like Notepad).  Just click "save as" and type .rms as the extension.  The community has made RMS syntax highlighters for numerous common text editors (see the Syntax Highlighting section at the end of this guide).
How to choose an RMS in-game
To use a custom random map, you need to look under "random map", not in your scenarios list.  Change the "map style" to "custom" and then pick the map.  You can also choose a custom RMS and generate it in the scenario editor to see what it can look like.
Game Versions
Age of Empires 2 has received numerous expansions, has been re-released twice, and also has community-made patches.  In order to prevent confusion, let us briefly look at these versions and what they mean for random map scripting.

Age of Kings (1999) (AoK) - The first release.  Did not support custom random map scripts.  Not played anymore, although you still can play it if you get the CD.
Age of Conquerors (2000) (AoC) - Expansion to AoK.  Supported custom random map scripts.  Also referred to as the CD version of the game.  Played for many years and you can still play multiplayer on GameRanger.
UserPatch (UP) - Community-made quality-of-life update for AoC.  Currently on version 1.5.  Originates in the AI scripting community, but also brings many new features to RM scripting.  Used as the basis for multiplayer on Voobly.
HD Edition (2013) (HD) - Re-release of AoC on the Steam platform.  Eventually implemented most RMS features from UP1.4 (but not from 1.5).  Received 3 downloadable content (DLC) expansions, namely:
The Forgotten (AoF) - A fan-made expansion turned official.
African Kingdoms - Content centered around Africa.
Rise of the Rajas - Content centered around south-east Asia.
WololoKingdoms (WK) - A fan-made mod for AoC running on UP1.5 that adds all DLC objects from the HD Edition and allows it to be used for multiplayer on Voobly.
Definitive Edition (2019) (DE) - Remaster of the game, including all previous expansions.  Implements most UP1.5 features, and adds many new features.  Most of the RMS community now makes maps for DE.  DE has several expansions adding more civilizations and campaigns, but owning them is not required to use their new objects in RMS. Received several DLC expansions so far:
Lords of the West - Adds Burgundians and Sicilians.
Dawn of the Dukes - Adds Bohemians and Poles.
Dynasties of India - Splits the former Indians civilization into 4 new civs.
Return of Rome - Adds the Romans to AoE2.  Also adds AoE1 into the AoE2 engine and game, which gives AoE1 custom random map script support.
The Mountain Royals - Adds Georgians and Armenians.
Chronicles: Battle for Greece - Adds Athenians, Spartans, and Achaemenids, but not in ranked.
The Three Kingdoms - Adds 5 new Chinese civilizations. 
Chronicles: Alexander the Great - Adds Macedonians, Thracians, Puru, but not in ranked.
Where to put a manually downloaded RMS
If you manually download a custom RMS (rather than subscribing directly to a mod) you will need to manually place it in the correct place.  This varies by game version.
In DE, maps can be in a subfolder and will be grouped with other maps in that subfolder.

DE (Steam):
Steam\SteamApps\common\Aoe2DE\resources\_common\random-map-scripts
or:
Users\[WindowsUsername]\Games\Age of Empires 2 DE\[UserID]\resources\_common\random-map-scripts
This folder does not exist by default, so you must first create it.

DE (Microsoft Store):
Users\[WindowsUsername]\Games\Age of Empires 2 DE\[UserID]\resources\_common\random-map-scripts
This folder does not exist by default, so you must first create it.

HD:
Steam\SteamApps\common\Age2HD\resources\_common\random-map-scripts

AoC:
Microsoft Games\Age of Empires II\Random

WK (local):
Microsoft Games\Age of Empires II\Games\WololoKingdoms\Script.Rm

WK (Voobly):
Microsoft Games\Age of Empires II\Voobly Mods\AOC\Data Mods\WololoKingdoms\Script.Rm

HD + Voobly (using the Compatibility Patch):
Steam\steamapps\common\Age2HD\Random

HD + Voobly + WK:	
Steam\steamapps\common\Age2HD\Voobly Mods\AOC\Data Mods\WololoKingdoms\Script.Rm
Where to find the Standard Random Map Scripts
You might want to look at the standard map scripts, to see what they do, and how they do it.

DE (Steam): AoE2DE\resources\_common\drs\gamedata_x2
Note that you must create a separate renamed copy if you want to edit the official maps.

DE (Microsoft Store):
You can run the game and then open AoE2DE's process location by right-clicking it in the Task Manager's Details. The actual game folder and its subfolders are readable at all times (no need to take ownership), the parent folder (WindowsApps) is the one that is unreadable.
Note that you must create a separate renamed copy if you want to edit the official maps.

HD: Age2HD\resources\_common\drs\gamedata_x1 and Age2HD\resources\_common\drs\gamedata_x2
The scripts are there as *.rms files.  The _x1 folder contains the AoC versions of the scripts and is used when playing with the basegame dataset in HD.  The _x2 folder contains the updated versions, with DLC objects.

AoC: Age of Empires II\Data\gamedata_x1.drs
You can open the drs file with any text editor.  It will display a whole bunch of junk characters, but the map scripts are also there in plain text, so you can take a look or copy them into another file.

WK (local): Age of Empires II\Games\WololoKingdoms\Data\gamedata_x1.drs
You can open the drs file with any text editor.  It will display a whole bunch of junk characters, but the map scripts are also there in plain text, so you can take a look or copy them into another file.

Any (local) UserPatch mod: Age of Empires II\Games\ModName\Data\gamedata_x1.drs
You can open the drs file with any text editor.  It will display a whole bunch of junk characters, but the map scripts are also there in plain text, so you can take a look or copy them into another file.
Getting Started
This guide is long, and reads more like a reference or a documentation of everything that is possible, rather than as an easy introduction for beginners.  If you are completely new to random map scripting it might be easier to find an existing map and take a look at the script to tweak it to observe the changes.

I can also recommend taking a look TheMadCADer's YouTube playlist

If you want example scripts to look at and modify, take a look at Example Scripts.
(I do NOT recommend using the official map scripts in DE to learn, especially not those that are based on tournament maps/versions.  The DE official Arabia script and any of the Red Bull Wololo maps are very complex.) 

A quick overview of some important sections in this guide:
Syntax Skeleton - lists every possible command and attribute, along with default values, a description and an example.  Refer to it when you are unsure about the usage of a command.
Random Code and Conditionals - read these sections so that you understand how to vary things in your map.
Constants and Constant Reference - learn how to use terrains and objects that do not have a pre-defined name.
Testing and Publishing a Map - learn how to efficiently test your map and how to properly upload it.
Links and Resources - a list of external things that might be worth looking at, and also the place to pick up an RMS syntax highlighter.

Syntax Overview
A random map script contains up to seven different sections.
This is the order in which the game will use sections to generate the map:
<PLAYER_SETUP>   Determine player placement and modify things in the gamedata
<LAND_GENERATION>   Place main landmasses of terrain
<ELEVATION_GENERATION>   Create hills
<CLIFF_GENERATION>   Create cliffs
<TERRAIN_GENERATION>   Replace terrains with other terrains
<CONNECTION_GENERATION>   Replace terrains between players and/or non-player lands
<OBJECTS_GENERATION>   Place units, buildings, resources, etc.
.
The sections can be written in any order, but the game uses them in the order above.
The official scripts are (historically) not written in the "correct" order.
Not all sections are necessary.
If you don’t want cliffs, don’t include <CLIFF_GENERATION>
You can have multiple sections of the same type.  They should function identically to a single section, except that things defined earlier or later in the script will only be true if they are defined higher up in the file than the place they are referred to, regardless of the section header.

Each section has different commands that can be used in it.  Many commands have attributes that can be used to modify the commands from their defaults.  There is also global syntax that can be used anywhere in your script (including outside of sections).
You can use indentations, spaces, tabs, newlines freely in whichever way helps readability the most - they are all recognized as separators.  You could write the entire script in one line and it would still work.  Just make sure everything is separated by some sort of separator.
The rms parser is very robust.  It will ignore things it cannot interpret or cannot place and still move on.
Syntax is case-sensitive.
Commands and attributes are usually processed in the order they appear within their section.
Attributes are contained in curly brackets. The brackets don't have to be on a new line, but they often are written that way.  Attributes don't have to be indented, but it helps readability if they are.  Example:
command
{
attribute
attribute2 argument
}
For the examples in the guide, I will generally use a more compact notation to save space:
command {
attribute
attribute2 argument
}
One can also use even more compact notation by leaving out newlines entirely:
	command { attribute attribute2 argument }
Most attributes are optional; you can leave out an attribute and it will use its default value.
Attribute order within a command generally does not matter; however, if you duplicate an attribute or use mutually exclusive attributes, the final one will apply.
Some commands and attributes have arguments - either numeric values or identifiers associated with terrains and objects.
In most cases, the parser only uses integers (whole numbers); if you use a decimal, it will ignore everything past the decimal point (or comma, or any other non-numeric character).
DE allows some attributes to accept floating-point (decimal) values.  Check the description in the syntax reference section!
Negative numbers can be used, but it only makes sense to do so for some arguments.
In UP and DE, rnd(min,max) can be used instead of a numeric argument to pick a random number between min and max (inclusive).  Make sure not to include any spaces in the whole construct!
If you specify an identifier that is not defined, the parser ignores it (or substitutes the most recent valid identifier) and keeps going.
Not all commands and attributes work in all versions of the game - check the description in the syntax reference section!
You can use a maximum of 100000 create_ commands per section.  Commands that are in not-chosen logical branches do not contribute to the limit when not chosen.  In all versions prior to DE, this limit is only 99.


Syntax Skeleton
This section shows all the possible syntax, so you can see which attributes and commands are available.  It also acts as a table of contents.  Explanations are in the next chapter.
Arguments are listed as follows:
N refers to a whole number.
F refers to a number that can optionally be a decimal.
% refers to a number (usually in the range 0-100).
TYPE refers to a constant identifier.
CONDITION refers to something which you expect to sometimes be true and sometimes be false; it might be a game setting, or even something you define yourself!
FILENAME refers to an external file to be loaded.
/ means that there are multiple possible commands or attributes to choose from.  In some cases (but not all), these may be mutually exclusive.


<PLAYER_SETUP>
random_placement / grouped_by_team / direct_placement
nomad_resources
force_nomad_treaty
behavior_version N
override_map_size N
set_gaia_civilization N
ai_info_map_type TYPE N N N
effect_amount TYPE TYPE TYPE F
effect_percent TYPE TYPE TYPE F
guard_state TYPE TYPE F N
terrain_state N N N N
weather_type N N N N
water_definition N

<LAND_GENERATION>
base_terrain TYPE
base_layer TYPE
enable_waves N
create_player_lands / create_land
{
	terrain_type TYPE
	land_percent F / number_of_tiles N
	base_size N
	set_circular_base
	generate_mode N
	land_position % %
	circle_radius F F
	left_border F
	right_border F
	top_border F
	bottom_border F
	border_fuzziness %
	clumping_factor N
	land_conformity %
	base_elevation N
	assign_to_player N / assign_to TYPE N N N
	zone N / set_zone_by_team / set_zone_randomly
	other_zone_avoidance_distance N
	min_placement_distance N
	land_id N
}

<ELEVATION_GENERATION>
create_elevation N
{
	base_terrain TYPE
	base_layer TYPE
	number_of_tiles N
	number_of_clumps N
	set_scale_by_size / set_scale_by_groups
	spacing N
	enable_balanced_elevation
}

<CLIFF_GENERATION>
cliff_type TYPE
min_number_of_cliffs N
max_number_of_cliffs N
min_length_of_cliff N
max_length_of_cliff N
cliff_curliness %
min_distance_cliffs N
min_terrain_distance N

<TERRAIN_GENERATION>
color_correction TYPE
create_terrain TYPE
{
	base_terrain TYPE
	base_layer TYPE
	beach_terrain TYPE
	terrain_mask N
	spacing_to_other_terrain_types N
	spacing_to_specific_terrain TYPE N 
	set_flat_terrain_only
	land_percent % / number_of_tiles N
	number_of_clumps N
	clumping_factor N
	set_scale_by_size / set_scale_by_groups
	set_avoid_player_start_areas N
	height_limits N N
}

<CONNECTION_GENERATION>
accumulate_connections
create_connect_all_players_land / create_connect_teams_lands / create_connect_all_lands / create_connect_same_land_zones / create_connect_land_zones / create_connect_to_nonplayer_land
{
	default_terrain_replacement TYPE
	replace_terrain TYPE TYPE
	terrain_cost TYPE F
	terrain_size TYPE N N
}

<OBJECTS_GENERATION>
create_actor_area N N N N
create_object_group TYPE
{
	add_object TYPE %
}
create_object TYPE
{
	number_of_objects N
	number_of_groups N
	group_variance N
	group_placement_radius
	set_tight_grouping / set_loose_grouping
	min_connected_tiles N
	resource_delta N
	second_object TYPE
	set_scaling_to_map_size / set_scaling_to_player_number
	set_place_for_every_player / place_on_specific_land_id N
	avoid_other_land_zones N
	generate_for_first_land_only
	set_gaia_object_only
	set_gaia_unconvertible / set_building_capturable
	make_indestructible
	min_distance_to_players N
	max_distance_to_players N
	set_circular_placement
	terrain_to_place_on TYPE
	layer_to_place_on TYPE
	ignore_terrain_restrictions
	max_distance_to_other_zones N
	place_on_forest_zone / avoid_forest_zone N
	avoid_cliff_zone N
	min_distance_to_map_edge N
	min_distance_group_placement N
	temp_min_distance_group_placement N
	find_closest
	find_closest_to_map_center
	find_closest_to_map_edge
	enable_tile_shuffling
	require_path N
	force_placement
	actor_area N
	actor_area_radius N
	override_actor_radius_if_required
	actor_area_to_place_in N
	avoid_actor_area N
	avoid_all_actor_areas
	set_facet N
	match_player_civ
}

/* global syntax */
/* comment */
#include_drs FILENAME
#includeXS FILENAME
start_random
	percent_chance %
end_random
rnd(N,N)
if CONDITION
elseif CONDITION
else
endif
#define CONDITION
#const TYPE N


Syntax Reference
<PLAYER_SETUP>
Default: random_placement
Required section.  Determines how players will be placed, and modifies global parameters.
random_placement
Game versions: All
Mutually exclusive with: grouped_by_team

Players are positioned in a circle with some variation.  This is the default, and will apply even if you do not type it.

Example:
<PLAYER_SETUP>
random_placement
grouped_by_team
Game versions: UP/HD/DE
Mutually exclusive with: random_placement
External reference: UserPatch Reference
Requires: Team Together box ticked in the lobby (on by default)

Players of the same team are positioned in close proximity to each other.  Distance between team members is double the base_size used in create_player_lands.

Example:
<PLAYER_SETUP>
grouped_by_team
direct_placement
Game versions: UP/DE
External reference: UserPatch Reference

Allows the land_position attribute in create_land to be used in combination with the assign_to_player or assign_to attributes to individually position players at exact positions on the map.
On UP, !P will be appended to the map name in the objectives window.
On UP, it can be used in combination with random_placement / grouped_by_team but it only works when using land_position
On DE, it disables random_placement and grouped_by_team, but doesn't necessarily require land_position - it is possible to just specify borders instead.  If used with create_player_lands, these lands will be positioned entirely at random (ignoring the normal circular positioning), so this is usually not desirable.

Example: Directly place player 1 at the center of the map (50%, 50%).
<PLAYER_SETUP>
direct_placement
<LAND_GENERATION>
create_land {
	terrain_type DESERT
	land_percent 3
	land_position 50 50
	assign_to_player 1
}
nomad_resources
Game versions: UP/HD/DE
External reference: UserPatch Reference

Adds the cost of a town center (275 Wood, 100 Stone) to every player's starting resources.  Use this in your custom nomad map if you want players to be able to build a town center without first gathering wood.
In DE, this adds the actual cost of a town center for the player's civilization.  ie. Incas only get an extra 85 stone.

Example:
<PLAYER_SETUP>
nomad_resources
force_nomad_treaty
Game versions: DE only

Activates a treaty period on nomad maps which lasts until every player has completed a town center or until 5 min have elapsed, whichever occurs first.  Nomad treaty prevents combat and prevents construction within 10 tiles of another player's town center (foundation).
The border of the 10 tile radius is visible in explored tiles, which makes finding enemy town centers much easier.  For this reason, nomad maps for tournament games often intentionally choose not to have a nomad treaty, while instead having rules against early villager fighting.

Example:
<PLAYER_SETUP>
nomad_resources
force_nomad_treaty
behavior_version  VersionNumber
Game versions: DE only
Arguments:
VersionNumber - number (0-2) (default: 0)
0 is classic behavior, and is the default
1 is new behavior
(2 supposedly changes the behavior of object placement for per-player lands, but I haven't observed any noticeable differences)

Used for versioning changes that might affect how existing maps generate.  Changes land generation such that when specifying number_of_tiles or land_percent, the square land origin covered by the base_size is included in the total, rather than being additive.  Also fixes a bug where land order would influence the generation.
This command can be used anywhere in your script.  Player setup seems like an appropriate place to put it, so it is listed here.  
May be used in the future to gate off more fixes and changes that might break backwards compatibility.
To update an old map, you must increase number_of_tiles by ((base_size*2)+1)² to get the same number of tiles as you previously had.
You also should increase any sub-100 land_percent by an amount that varies with map size.
  
Example: Activate new land generation behavior in your script and observe that your lands get smaller.
behavior_version 1
<LAND_GENERATION>
create_player_lands {
    terrain_type DLC_BLACK
    number_of_tiles 250
    base_size 12
}
override_map_size  SideLength
Game versions: DE only
Arguments: 
SideLength - number (36-480) (default: use size set in lobby) (see: Map Sizes)
values smaller than 36 or larger than 480 will clamp to those limits

Used to manually adjust the square dimensions of the map.  This is used to make some of the official water maps one size larger than the size selected in the lobby.
Only one argument is accepted, so you are still restricted to square maps.
This command can be used anywhere in your script.  For general usage it should be used prior to any land generation, which is why it is listed here.
Affects the scaling of elevation (set_scale_by_size / set_scale_by_groups), terrains (set_scale_by_size / set_scale_by_groups), and objects (set_scaling_to_map_size).
Can theoretically be used multiple times.  Land generation will be based on what the current size is at that point in the script.
Does not influence the length of the wonder timer; it will only depend on the size set in the lobby.
This can be used to reduce the wonder timer in 8 player games, by having players choose the tiny size in the lobby for a script that overrides the size to something suitable for 8 players.

Example 1: Make the map always generate at a size of 100x100 tiles.
override_map_size 100

Example 2: Make a map generate somewhat larger than what is set in the lobby.
if TINY_MAP	override_map_size 144
elseif SMALL_MAP	override_map_size 168
elseif MEDIUM_MAP	override_map_size 200
elseif LARGE_MAP	override_map_size 220
elseif HUGE_MAP	override_map_size 240
elseif GIGANTIC_MAP	override_map_size 255
endif
set_gaia_civilization  CivNumber
Game versions: DE only
Arguments:
CivNumber - number (0-53) (default: 0 - gaia) (see: Civilizations)

Set the civilization for gaia to use.  This will affect the architectural style of any gaia buildings, and the appearance of any units that have regional variations.  It will also affect any civilization bonuses, upgrades and unique technologies (relevant especially for battle royale)
The default gaia civ in DE uses the western European architectural style.
This command can be used anywhere in your script.  Player setup seems like an appropriate place to put it, so I have listed it here.  
If used, gaia effects (see: Effect Constants) will no longer function when applied to units that can be player controlled. CHECK IF FIXED
If used, gaia buildings with make_indestrucible will be burning, so it is best not to use set_gaia_civilization if you wish to use indestructible gaia buildings.
If used multiple times, only the final instance will apply.
Does not work in the scenario editor.

Example: Create a Lithuanian monument for gaia somewhere on the map
set_gaia_civilization 35
<OBJECTS_GENERATION>
create_object MONUMENT
ai_info_map_type  MapType  IsNomad  IsMichi  ShowType
Game versions: All
External reference: UserPatch Reference
Arguments:
MapType - map type constant (see: Map Types) (default: CUSTOM)
Specify a standard map type that your map is similar to.  
IsNomad - boolean (1 or 0) (default: 0)
Specify if your map is nomad style (no town center to start with).
Always use this on nomad starts since it prevents issues where ally locations are revealed (fixed in DE)
IsMichi - boolean (1 or 0) (default: 0)
Specify if your map is Michi style (forest completely separating players).
ShowType - boolean (1 or 0) (default: 0)
Specify if you want your chosen map type to be shown in the objectives window (only works in UP)

Provide information about the map to AIs.  If your map is not very similar to an existing map, it is best to leave out the command entirely, or to use CUSTOM as the map type.

Example: A map that is a slightly modified version of Arabia and you want the objectives screen to say Arabia.
<PLAYER_SETUP>
ai_info_map_type ARABIA 0 0 1
effect_amount  EffectType  Type  AttributeType  Amount
Game versions: UP/DE
External reference: UserPatch Reference, UserPatch Effects Guide
Arguments:
EffectType - effect constant (see: Effect Constants)
Type - object/resource/technology/effect constant (see: Objects, Resource Constants, Technology Constants, Miscellaneous Constants, Class Constants, Advanced Genie Editor)
AttributeType - attribute constant (see: Attribute Constants)
Amount - number
DE only: accepts floating-point values

Modify various aspects of the gamedata, specifically for your map.  See the linked guides for a better overview of the possibilities.  
When modifying objects, you may need to target ALL hidden variations, one-by-one.
If an object ends up with more than 32767 hitpoints, it is instantly destroyed. Be sure to consider in-game upgrades and civ bonuses.
If you disable an object with this command, in-game techs/ages (unless disabled) may re-enable it. The civ tech tree may also override changes.
(UP only) !C will be appended to the map name in the Objectives window.
In vanilla UP only, the relevant constants must first be defined before use.

Example 1: Add 10000 starting food.
<PLAYER_SETUP>
effect_amount MOD_RESOURCE AMOUNT_STARTING_FOOD ATTR_ADD 10000

Example 2: Houses support 10/15/20/25 population in dark/feudal/castle/imperial age.
<PLAYER_SETUP>
effect_amount SET_ATTRIBUTE HOUSE ATTR_STORAGE_VALUE 10
effect_amount SET_ATTRIBUTE HOUSE_F ATTR_STORAGE_VALUE 15
effect_amount SET_ATTRIBUTE HOUSE_C ATTR_STORAGE_VALUE 20
effect_amount SET_ATTRIBUTE HOUSE_I ATTR_STORAGE_VALUE 25

Example 3: Exploding villagers.
https://snippets.aoe2map.net/ArbalestHandCartBerserkEliteCamelArcher

Example 4: Examples from UserPatchConst file.
#const OUTLAW 158
#const RI_LOOM 22
<PLAYER_SETUP>
effect_amount SET_ATTRIBUTE VILLAGER_CLASS ATTR_HITPOINTS 20
effect_percent ADD_ATTRIBUTE VILLAGER_CLASS ATTR_MOVE_SPEED 30
effect_amount MUL_ATTRIBUTE VILLAGER_CLASS ATTR_HITPOINTS 2
effect_amount MOD_RESOURCE AMOUNT_STARTING_FOOD ATTR_ADD 20
effect_amount MUL_RESOURCE AMOUNT_STARTING_FOOD ATTR_DISABLE 5
effect_amount SET_TECH_COST RI_LOOM AMOUNT_GOLD 10
effect_amount ADD_TECH_COST RI_LOOM AMOUNT_GOLD 20
effect_amount MOD_TECH_TIME RI_LOOM ATTR_SET 60
effect_amount ENABLE_OBJECT TRANSPORT_SHIP ATTR_ENABLE 0
effect_amount UPGRADE_UNIT WOLF OUTLAW 0
effect_amount DISABLE_TECH RI_LOOM ATTR_DISABLE 22 /* note that ENABLE_TECH does not exist in DE, use MODIFY_TECH instead */
effect_amount ENABLE_TECH RI_LOOM ATTR_ENABLE 22
effect_amount MODIFY_TECH RI_LOOM ATTR_SET_TIME 60
effect_amount SET_PLAYER_DATA DATA_CIV_NAME_ID ATTR_SET 10230
effect_percent  EffectType  Type  AttributeType  %
Game versions: UP/DE
External reference: UserPatch Reference, UserPatch Effects Guide
Arguments:
EffectType - effect constant (see: Effect Constants)
Type - object/resource/technology/effect constant (see: Objects, Resource Constants, Technology Constants, Class Constants, Miscellaneous Constants, Advanced Genie Editor)
AttributeType - attribute constant (see: Attribute Constants)
% - number
DE only: accepts floating-point values

Same as effect_amount but allows for greater precision.  The specified value is divided by 100 so that you can use decimal values. 

Example 1: Add 0.3 speed to all villagers (30/100 = 0.3)
<PLAYER_SETUP>
effect_percent ADD_ATTRIBUTE VILLAGER_CLASS ATTR_MOVE_SPEED 30

Example 2: Nerf the slinging of resources by making tributing more inefficient and moving coinage to imperial age.
https://snippets.aoe2map.net/GbetoEliteRattanArcherChemistryThalassocracy
guard_state  ObjectType  ResourceType  ResourceDelta  Flags
Game versions: UP/DE
External reference: UserPatch Reference
Arguments: 
ObjectType - object constant or class constant (see: Objects, Class Constants)
for villagers use VILLAGER_CLASS instead of VILLAGER
ResourceType - resource amount constant (see: Resource Constants)
ResourceDelta - number (default: 0)
DE only: accepts floating-point values
Flags - number (0-7) (default: 0)
0: no flags
1: lose if you do not control the specified ObjectType
2: activate a resource trickle of the ResourceType at the level of ResourceDelta/100, as long as you control ObjectType
4: invert the ObjectType requirement for the other flags
add the values to apply multiple flags

Set up additional lose conditions and/or resource trickles based on controlling or not controlling a specified object.
Only one guard_state command can be active in your script!
(UP only) If used, !G will be appended to the map name in the Objectives window, along with the guard state details

Example: Activate a guardstate on the king, to make a map regicide even in other game modes.
<PLAYER_SETUP>
guard_state KING AMOUNT_GOLD 0 1

Example 2: Slowly drain a player's food while they do not control the monument.
<PLAYER_SETUP>
guard_state MONUMENT AMOUNT_FOOD -5 6

Example 3: Enable a small, relic-style gold trickle and configure players to be defeated if all villagers are lost.
<PLAYER_SETUP>
guard_state VILLAGER_CLASS AMOUNT_GOLD 10 3
terrain_state  Mode  Parameter1  Parameter2  Flags
Game versions: UP only
External reference: UserPatch Reference
Arguments: 
Mode - number (0) (default: 0)
Parameter1 - number (0) (default: 0)
Parameter1 - number (0) (default: 0)
Flags - number (0-7) (default: 0)
0: no flags
1: enable building on shallows; also allows resources to be placed on shallows
2: thinner blending of shallows and beach terrain
4: changes ice blending to use shallows-style blending
add the values to apply multiple flags

Changes the shallows terrain to allow it to be buildable.  Can also be used to modify shallows and ice blending properties.  There may be further unknown and undocumented functionality.
Parameters 1 and 2 are unimplemented as far as we currently know, and the only known mode is 0, so just set the first three numbers to 0 if you use this command.

Example: Activate all flags to allow for buildable shallows with alternate blending
<PLAYER_SETUP>
terrain_state 0 0 0 7
weather_type  PrecipitationStyle  LiveColor  FogColor  WaterDirection
Game versions: UP only
External reference: UserPatch Reference, Weather Effects Guide
Arguments:
PrecipitationStyle - number (-4 to 4) (default: 0)
0 is no precipitation; 2 is rain; 3 is thunderstorm; 4 is snow.
Precipitation goes west to east.  Use negative numbers for east to west.
LiveColor - number (0 to 255) (default: 0)
Color of terrain tinting in revealed areas.
0 is none; 1-255 refers to the color palette.
FogColor - number (0 to 255) (default: 0)
Color of terrain tinting in the fog of war.
0 is none; 1-255 refers to the color palette.
WaterDirection - number (-1 to 1) (default 0)
Direction of animated water.
0 is random; 1 is west to east; -1 is east to west.

Set up precipitation and terrain tinting.
It usually looks good to match the precipitation and water direction.
It often makes sense to pick similar colors for live and fog tinting.
Terrain tinting looks bad on streams and recordings, so you may want to leave it out.
In DE, consider using color_correction and water_definition instead.

Example: Westward thunderstorm
<PLAYER_SETUP>
weather_type -3 16 0 -1
water_definition  WaterType
Game versions: DE only
Arguments:
WaterType - water color correction constant (see: Water Definitions) (default: 0 (sunny daytime))
Since none of the constants are pre-defined, you will have to define them yourself with #const before using them.

Specify a water profile to apply on your map.  Each option applies different color correction, waves and reflections to 3D water.  
Not visible if the "Render 3D Water" setting is disabled.
BUG: 3D water appears inconsistently in the scenario editor.  Make sure to test in singleplayer instead.
Waves on shorelines are controlled by enable_waves.
General color correction is controlled by color_correction.
on UP, use weather_type instead.

Example: Water with rapid waves and limited sunlight.
<PLAYER_SETUP>
#const HURRICANE 8
water_definition HURRICANE

<LAND_GENERATION>
Place large areas of terrain, including the player starting areas.  Required if you want to place players.  Land origins (square bases) are placed in order. After all origins are placed, all lands grow simultaneously from their origins outwards in all directions to fill the amount of space specified for each land, or until they run into a border or another land.  Land growth happens all at once!
External guide: Land Generation in Age of Empires II
base_terrain  TerrainType
Game versions: All
See also: base_terrain (elevation), base_terrain (terrain)
Arguments: 
TerrainType - terrain constant (see: Terrains) (default: GRASS)
BUG (DE): Does not default to GRASS, so make sure to specify the base terrain.

Specify a terrain to initially fill the map.  Maps with rivers going through them or oceans on the outside usually use water.  Maps with forest on the outside usually use forest terrain.

Example: Fill the map with water
<LAND_GENERATION>
base_terrain WATER
base_layer  TerrainType
Game versions: DE only
See also: base_layer (elevation), base_layer (terrain)
Arguments: 
TerrainType - terrain constant (see: Terrains) (default: no layered terrain)

Specify a terrain to layer on top of the map's base_terrain.  This layered terrain is visual only, and does not confer any terrain properties or object restrictions.
Must be used AFTER base_terrain.
If used, you must specify the same base_layer in create_elevation, should you want to generate elevation on the map base terrain.

Example: Initially fill the map with dirt3, and layer snow on top of that
<LAND_GENERATION>
base_terrain DIRT3
base_layer SNOW
enable_waves  ShowWaves
Game versions: DE only
External reference: Official DE Documentation
Arguments: 
ShowWaves - boolean (1 or 0) (default: 1)

Enabled by default, so you only need to include it if you want to disable animated beach waves on your map.
Waves are only visible if the player has "Render Beach Waves" turned on in the game settings.
BUG: beach waves appear inconsistently in the scenario editor.  Make sure to test in singleplayer instead.
This setting only applies to waves where water borders land.  Waves in general are controlled by water_definition.

Example: Disable beach waves
<LAND_GENERATION>
enable_waves 0
create_player_lands  { Attributes } 
Game versions: All

Creates a land for every player.
Usually this command is used only once, but it can be repeated to, for example, give every player two starting towns.
Not required.  You can use create_land with the assign_to_player or assign_to attributes to give lands directly to individual players instead (or in addition to creating player lands).
If you do not give players any lands at all, you cannot give them any starting units or resources.  They will start at an entirely random location with only a town center, villagers and scout.  This is NOT recommended.
DE: using direct_placement with create_player_lands disables the circular land positioning, so this is usually not desirable.

Example: Create player lands made of dirt
<LAND_GENERATION>
create_player_lands {
	terrain_type DIRT
	land_percent 20
}
create_land  { Attributes } 
Game versions: All

Create a single non-player (neutral) land.
Can be assigned to a player with assign_to_player or assign_to

Example: Create a lake in the center
<LAND_GENERATION>
create_land {
	terrain_type WATER
	land_percent 10
land_position 50 50
}
terrain_type  TerrainType
Game versions: All
Arguments: 
TerrainType - terrain constant (see: Terrains) (default: GRASS)

Specify which terrain the land should have.  

Example: Create player lands made of dirt
<LAND_GENERATION>
create_player_lands {
	terrain_type DIRT
	land_percent 20
}
land_percent  %
Game versions: All
See also: land_percent (terrain)
Mutually exclusive with: number_of_tiles
Arguments:
% - number (0-100) (default: 100)
DE only: accepts floating-point values

Percentage of the total map that the land should grow to cover.
If land growth is constrained by borders or other lands, lands may be smaller than specified.
For player lands (create_player_lands) the percentage is divided equally between all players.

Example: Allocate 20% total of the map toward player lands
<LAND_GENERATION>
create_player_lands {
	terrain_type DIRT
	land_percent 20
}
number_of_tiles  Amount
Game versions: All
See also: number_of_tiles (elevation), number_of_tiles (terrain)
Mutually exclusive with: land_percent
Arguments:
Amount - number (default: land_percent 100)

Fixed number of tiles that the land should grow by.
Total size of the land is number_of_tiles in addition to the square origin specified by base_size
When using behavior_version 1, the square origin is included in the total number_of_tiles, resulting in smaller lands, unless compensated for.
For player lands (create_player_lands) each player is given the specified number of tiles.

Example: Give every player 300 tiles
<LAND_GENERATION>
create_player_lands {
	terrain_type DIRT
	number_of_tiles 300
}
base_size  Radius
Game versions: All
Arguments:
Radius - number (default: 3)

Square radius of the initially placed land origin, before any growth.
The default of 3 results in a 7x7 land origin (49 tiles total).
base_size will produce a perfect square if used with land_percent 0 or number_of_tiles 0.
Can be turned into a circle with set_circular_base.
base_size is the minimum distance that a land will be placed from the edge of the map.
Land bases are placed sequentially, so if they are large and overlap, the land placed last will be the one visible in the overlapping region.
Non-player land bases will not overlap with each other, unless...
If base_size for non-player lands is too large, the land will fail to find a valid position and will be placed at the center of the map, overlapping any other lands at the center.

Example: Create a 13x13 square of ice
<LAND_GENERATION>
create_land {
terrain_type ICE
base_size 6
number_of_tiles 0
}
set_circular_base
Game versions: DE only

The square land origin becomes a circle of the size that would be exactly inscribed by the square.
Land origins with a base_size of 3 or smaller will still be a perfect square, while larger bases will be more obviously circular.
Can be used to produce a perfect circle if combined with land_percent 0 or number_of_tiles 0.
BUG: when combined with base_elevation, the whole square will be elevated.  This can be prevented by adding land_conformity 99.

Example: Create a 12x12 circle of desert for each player
<LAND_GENERATION>
create_player_lands {
    terrain_type DESERT
    land_percent 0
    base_size 12
    set_circular_base
}
generate_mode  Mode
Game versions: DE only
Arguments:
Mode - boolean (1 or 0) (default: 0 (lands are not placed in corners))

By default lands are positioned at random in a cross-shaped area, and will never be in the corners.  Setting the generate mode to 1 will allow lands to be randomly positioned anywhere, including the corners.
No effect for create_player_lands.
No effect when using assign_to_player or assign_to for create_land, unless direct_placement is specified in <PLAYER_SETUP>.

Example: Create 4 ponds that can appear anywhere, including in the corners.
<LAND_GENERATION>
create_land { generate_mode 1 terrain_type WATER land_percent 1 }
create_land { generate_mode 1 terrain_type WATER land_percent 1 }
create_land { generate_mode 1 terrain_type WATER land_percent 1 }
create_land { generate_mode 1 terrain_type WATER land_percent 1 }
land_position  %X  %Y
Game versions: All
Arguments:
%X - number (0-100) (default: random*)
%Y - number (0-99) (default: random*) 
Note that 100 for the Y coordinate (or anything outside the map) will crash the game if your map uses <CONNECTION_GENERATION> and has a connection that needs to reach this land specifically, or if the land uses assign_to_player
*lands without land_position will have their randomly chosen origin in a cross-shaped area and will never be in the corners (unless generate_mode is set to 1)
DE only: accepts floating-point values

Specify the exact origin point for a land, as a percentage of total map dimensions.
land_position 50 50 is the center of the map.
land_position 0 0 is the west corner, 100 99 is the east corner, 100 0 is the north corner, 0 99 is the south corner.
	
Ignores border restrictions
If placed outside of specified borders, the land will not grow beyond its base_size
Disabled for create_player_lands
Disabled when using assign_to_player or assign_to for create_land, unless direct_placement is specified in <PLAYER_SETUP>
Positions outside of the map can theoretically be used if the crash conditions are avoided.

Example: Create a lake in the center of the map
<LAND_GENERATION>
create_land {
terrain_type WATER
land_percent 10
land_position 50 50
}
circle_radius  %Radius  Variance
Game versions: DE only
External reference: Official DE Documentation
Arguments:
%Radius - number (1-50)
It is a percentage of map width
0 will disable circle_radius
The standard radius for unconstrained lands is around 40
Values larger than 50 will tend to force players towards the extreme edges and corners of the map
Variance - number (default: 0) 
0 is a perfect circle with no variance
20 seems to be close to the standard amount of variance when not using circle_radius
Very large values will tend to force players towards the corners of the map
Each player will vary independent of the others
Accepts floating-point values

Used in create_player_lands to position the player lands in a circle with equal distance to the center, with specified variance.
Circle radius ignores any specified borders when placing the land origins, but land growth will still be constrained by borders.
There is also a command called circle_placement which is used in the standard maps and listed in the official documentation. That command is non-functional.
If used for multiple unique create_player_lands commands, only the final radius will apply.
BUG: if used for multiple player lands while also using grouped_by_team, the additional land positions will not generate properly.
If used for create_land, it will still apply to player lands normally.
See Circle Radius Comparison in the appendix for a comparison of not using circle_radius to a radius with no variance.

Example: Place player lands in a perfect circle close to the center of the map.
<LAND_GENERATION>
create_player_lands {
terrain_type DIRT
number_of_tiles 100
circle_radius 20 0
}
left_border  %
right_border  %
top_border  %
bottom_border  %
Game versions: All
Arguments:
% - number (0-99) (default: 0)
DE only: accepts floating-point values

Specify a percentage of map width for land placement and growth to stay away from a given border.
Left is southwest; right is northeast, top is northwest; bottom is southeast

There is a hard-coded feature that makes lands look like octagons instead of squares when constrained by borders.
Borders shift the entire circle of all the player lands
You cannot have multiple rings of player lands with different borders; they will all be in the same circle
Due to rounding, the exact number of tiles that a given % value corresponds to may not be the same for each side.  
For example, to stop 2 tiles from the edge on a tiny (120x120) map, a value of 2 must be used for the top and left borders, but a value of 3 is needed for the bottom and right borders.
Negative values can be used, as long as the land origin stays inside the map.  To ensure this, do one of the following:
Specify a land_position within the map
Specify a sufficiently large base size (this may require manually scaling of base_size with map size)
BUG: asymmetric borders for player lands can cause issues when the top_border is larger than other borders (External reference: RMS Border Bugs Exposed).  Avoid this by always using another border along with top_border when creating player lands.

Example: Place all players in the top corner of the map.
<LAND_GENERATION>
create_player_lands {
	terrain_type DIRT
	land_percent 100
bottom_border 60
left_border 60
}
border_fuzziness  %BorderAdherence 
Game versions: All
Arguments:
%BorderAdherence - number (0-100) (default: 20)

Specifies the extent to which land growth respects borders and actually stops at a border.
Low values allow lands to exceed specified borders, giving ragged looking edges when land is constrained by borders.
0 causes land growth to ignore borders entirely.
100 (or any negative value) means that borders are fully respected, resulting in perfectly straight lands along borders.

Example: Central desert with very fuzzy borders
<LAND_GENERATION>
create_land {    
terrain_type DESERT
land_position 50 50
land_percent 100
left_border 40
right_border 40
top_border 40
bottom_border 40
border_fuzziness 2
}
clumping_factor  Factor
Game versions: All
See also: clumping_factor (terrain)
Arguments:
Factor - number (default: 8 - different than for terrains)
Useful range of about 0-40

The extent to which land growth prefers to clump together near existing tiles.  Moderate values (11-40) create rounder lands, while low values (0-10) create more irregular lands, and high values (40+) create lands that extend in one direction away from the origin.  Negative values create extremely snakey lands, and are generally not recommended.

Example: Create an irregularly shaped lake
<LAND_GENERATION>
create_land {    
terrain_type WATER
land_percent 10
clumping_factor 2
}
land_conformity  %
Game versions: DE only
Arguments:
% - number (-1-100)
0 is the same as not having this attribute
Any negative number behaves the same
100 causes this attribute to override the base_size unless set_circular_base is specified
Useful ranges without set_circular_base: 0~15, 25~35, 45~99, 100
Useful ranges with set_circular_base: 0~10, 20~30, 40~99, 100

Intended as a more potent version of clumping_factor, with higher values conforming more to the shape of the land origin set with base_size, and with negative numbers conforming less to it.
This attribute is currently buggy.  We have been advised to avoid using it.
Appears to take the tile count of the land, and apply some math to it and then set a new "radius" for the land.  With circles the radius is roughly 1/2 what it should be at any given tile count; it’s much closer to what it should be with squares.  Lands tend to not have any tiles, or very few, outside the “radius” above ~35 conformity.
base_elevation  Height
Game versions: UP/HD/DE
External reference: UserPatch Reference
Requires: <ELEVATION_GENERATION> section (can be empty)
Arguments:
Height - number (1-16) (default: 0 - not elevated)
In UP/HD elevations higher than 7 should not be used, because objects will fail to render properly.
In DE, elevations higher than 7 can be used, but may cause terrain rendering issues for certain screen resolutions, especially if you go higher than about 16.
Negative values maximally elevate a land (not recommended due to rendering issues)

Elevate the entire land to the specified height.  
In HD/DE this will not work for lands with a water terrain_type 
Up to a height of 9 the surrounding terrains will contain the slope, with even higher values, the remaining elevation occurs within the confines of the land.

Example: Create a palm desert land with elevation 2.
<LAND_GENERATION>
create_land {
	terrain_type PALM_DESERT
	number_of_tiles 128
	base_elevation 2
}
<ELEVATION_GENERATION>
assign_to_player  PlayerNumber
Game versions: All
Mutually exclusive with: assign_to
Arguments:
PlayerNumber - number 1-8 (default: not assigned to any players)

Assign a land created with create_land to one specific player, allowing you to place starting objects on that land for that player.
Refers to lobby order -  the first person in the lobby is player 1, even if they are not blue.
If you want to support 8 players, you must individually assign lands to all 8 players.
Lands assigned to players who are not playing will not be created.
All lands belonging to players will be in a circle and land_position will be ignored, unless direct_placement is specified in <PLAYER_SETUP>
assign_to_player 0 will make the land gaia's player land (not recommended!)
negative values will create the land without assigning it to anyone.

Example: Assign a desert land to player 1
<LAND_GENERATION>
create_land {
	terrain_type DESERT
	land_percent 3
	assign_to_player 1
}
assign_to  AssignTarget  Number  Mode  Flags
Game versions: UP/DE
Mutually exclusive with: assign_to_player
External reference: UserPatch Reference
Arguments:
AssignTarget - AssignTargetConstant (default: not assigned to any players)
Options are AT_PLAYER, AT_COLOR, AT_TEAM
Number - varies depending on the AssignTarget
AT_PLAYER (1-8) - player number (refers to lobby order)
AT_COLOR (1-8) - player color
AT_TEAM (-10, -4,-3,-2,-1,0,1,2,3,4) - team number (refers to lobby order, not the number chosen by the team).  Gives the land to a player from the specified team.
0 is for un-teamed players
negative values target a player NOT on the specified team
-10 gives the land to any player
Teams containing only 1 player do not count as teams
Mode - number (-1, 0)
0 is for random selection (only matters for AT_TEAM)
-1 is for ordered selection (based on lobby order) (only matters for AT_TEAM)
Flags - number (0-3)
0: no flags
1: reset players who have already been assigned before starting
2: do not remember assigning this player
3: apply the effects of both 1 and 2

A more powerful version of assign_to_player.  Assign a land created with create_land to one specific player, allowing you to place starting objects on that land for that player.
If you want to support 8 players, you must individually assign lands for all players.
Lands assigned to players who are not playing will not be created.
All lands belonging to players will be in a circle and land_position will be ignored, unless direct_placement is specified in <PLAYER_SETUP>
In DE and WK the AssignTargetConstants are predefined, but in vanilla UP they must be manually defined first.

Example: Assign a new land at the map center to a random player on team 1.
<PLAYER_SETUP>
direct_placement
<LAND_GENERATION>
create_land {
	terrain_type DIRT
	number_of_tiles 128
	land_position 50 50
	assign_to AT_TEAM 1 0 0
}
zone  ZoneNumber
Game versions: All
Mutually exclusive with: set_zone_by_team / set_zone_randomly
Arguments:
ZoneNumber - number

Set a numeric zone.
Lands sharing the same zone can grow to touch each other.  If two lands have different zones, and other_zone_avoidance_distance is specified, land growth will avoid touching the other zone.
Do not specify any zone if you want each player to be on their own island.
By default lands from create_player_lands are each in their own unique zone (PlayerNumber - 10), while lands created with create_land all share the same zone (-10).
BUG (AoC/UP/HD): zone 99 will crash the game.  This bug is fixed in DE.

Example: All players are on the same continent, the rest of the map is water.
<LAND_GENERATION>
base_terrain WATER
create_player_lands {
	terrain_type DIRT
	land_percent 60
zone 1
}
set_zone_by_team
Game versions: All
Mutually exclusive with: zone / set_zone_randomly

For create_player_lands.  Assigns the same zone to all members of the same team.
Lands sharing the same zone can grow to touch each other.  If two lands have different zones, and other_zone_avoidance_distance is specified, land growth will avoid touching the other zone.
If used with create_land, it will assign the land to the same zone as the team of player 1, even if the land is a non-player land or is the assigned land for a member of a different team.  (This is not recommended!)
Team zones correspond to (TeamNumber - 9), so team 1 is in zone -8.

Example: Team Islands
<LAND_GENERATION>
base_terrain WATER
create_player_lands {
	terrain_type DIRT
	land_percent 80
set_zone_by_team
other_zone_avoidance_distance 10
left_border 10 right_border 10 top_border 10 bottom_border 10
}
set_zone_randomly
Game versions: All
Mutually exclusive with: zone / set_zone_by_team 

Lands with this attribute will randomly share zones with other lands.  Lands sharing the same zone can grow to touch each other.  If two lands have different zones, and other_zone_avoidance_distance is specified, land growth will avoid touching the other zone.  Specifically the land gets a random zone in the range -8 to (PlayerCount - 9).  This means:
The land(s) will never share a zone with a land that is given a positive numeric zone or is a non-player land without a zone assigned.
The land(s) may share a zone with a land that has set_zone_randomly or that has set_zone_by_team, or that has a manually specified zone in the correct range.
A non-player land with set_zone_randomly will never share a zone with player 1, if player 1 is using their default zone of -9.


Example: Archipelago-styled map where players might be on the same island with allies, enemies or nobody.
<LAND_GENERATION>
base_terrain WATER
create_player_lands {
	terrain_type DIRT
	land_percent 80
set_zone_randomly
other_zone_avoidance_distance 10
left_border 10 right_border 10 top_border 10 bottom_border 10
}
other_zone_avoidance_distance  Tiles
Game versions: All
Arguments:
Tiles - number (default: 0) 

Number of tiles away from a land with a different zone to stop land growth.  Used to create river maps and island maps.
To keep two lands separated, both lands must have this attribute.
When different values are used for two lands, the smaller one applies.
This attribute also keeps randomly positioned land origins/bases the specified distance apart (regardless of zone), but can be overridden by min_placement_distance.
Land origins/bases may end up closer together or even touching if land_position is specified, or if used for player lands when there are too many players crammed on too small of a map.
Example:  A rivers map where all players are separated by water, and there is a neutral island in the center.
<LAND_GENERATION>
base_terrain WATER
create_player_lands {
terrain_type GRASS
	land_percent 100
other_zone_avoidance_distance 10
}
create_land {
terrain_type DIRT
land_percent 100
land_position 50 50
zone 1
other_zone_avoidance_distance 10
}
min_placement_distance  Tiles
Game versions: All
Arguments:
Tiles - number (default: value of other_zone_avoidance_distance (default: 0)) 

Number of tiles to stay away from the origins of previously created lands when randomly selecting an origin for this land.
If min_placement_distance is not specified, land origins will be positioned such that there is at least other_zone_avoidance_distance worth of space between the edges of the square origins.
min_placement_distance uses the center of the origins, so for a large base_size, may end up closer than an equivalent other_zone_avoidance_distance.
If too large of a value is specified and the land cannot find a valid position, it will be placed in the center, regardless of other lands already in or near the center.
No effect when land_position is specified.
No effect on player lands, unless direct_placement is active in DE

Example: Create three deserts that have their origins at least 25 tiles from the other deserts.
<LAND_GENERATION>
create_land {
	terrain_type DESERT
	land_percent 1
min_placement_distance 25
}
create_land {
	terrain_type DESERT
	land_percent 1
min_placement_distance 25
}
create_land {
	terrain_type DESERT
	land_percent 1
min_placement_distance 25
}
land_id  Identifier
Game versions: All
Arguments:
Identifier - number (default: no id)

Assign a numeric label to a land, which can later be used to place objects specifically on that land with place_on_specific_land_id.  Unrelated to any zone numbers.
Multiple lands can have the same ID.  In this case, the objects will be placed on all of them.
Must be used after assign_to_player / assign_to since they will reset the ID.
Can theoretically be used for create_player_lands, but will disable the ability to use set_place_for_every_player for object placement.  This has some application when creating "fake" player lands to generate forests or ponds between players.
Note that objects may be placed on surrounding terrain rather than the land itself, if the surrounding terrain is something the object can be placed on.
land_id -9 assigns the land to be the player land of gaia (not recommended!)

Example: Create a tiny snowy island and place a gold mine on it.
<LAND_GENERATION>
base_terrain WATER
create_player_lands {
	terrain_type DIRT
	land_percent 0
}
create_land {
	terrain_type SNOW
	land_percent 0
land_id 13
land_position 50 50
}
<OBJECTS_GENERATION>
create_object GOLD {
place_on_specific_land_id 13
}

<ELEVATION_GENERATION>
Optional section used to place hills on your map.
Elevation avoids the origins of player lands by about 9 tiles.
If base_elevation was specified for any lands, you must include this section, even if it is empty.
Elevation provides a combat bonus to higher units, and a debuff to lower units.
Hill positions are noticeably biased towards being placed in the south.  In DE, you should always use enable_balanced_elevation to reduce this bias.
create_elevation  MaxHeight  { Attributes } 
Game versions: All
Arguments:
MaxHeight - number (1-16) (default: 0 - not elevated)

Create one or more hills of random height, up to the given height.
When creating a single hill, this hill will always attempt to reach the height specified.
Hills with a small number of base tiles are not able to reach as high.
HD/DE: If terrain has already been elevated with a land's base_elevation, new hills will be relative to that height.
UP: Hills always use an absolute height, even if a terrain has already been elevated with a land's base_elevation
Pre-DE: maximum is 7.
Higher elevations towards 16 may cause unwanted behavior such as TC projectiles firing in a different way.

Example: Create one hill on grassy terrain.
<ELEVATION_GENERATION>
create_elevation 7 {
base_terrain GRASS
number_of_tiles 600
}
base_terrain  TerrainType
Game versions: All
See also: base_terrain (land), base_terrain (terrain)
Arguments: 
TerrainType - terrain constant (see: Terrains) (default: GRASS)

Terrain on which the hill(s) should generate.  If you have multiple terrains you want hills on, then you need multiple create_elevation commands.
Note that you only need to consider terrains from <LAND_GENERATION>, as <TERRAIN_GENERATION> occurs after elevation has already been placed.

Example: Create one hill on water terrain.
<ELEVATION_GENERATION>
create_elevation 7 {
base_terrain WATER
number_of_tiles 600
}
base_layer  TerrainType
Game versions: DE only
See also: base_layer (land), base_layer (terrain)
Arguments: 
TerrainType - terrain constant (see: Terrains) (default: any)

Use this attribute in addition to base_terrain if (and only if) you specified a layer for the map base terrain at the beginning of <LAND_GENERATION>.

Example: Initially fill the map with dirt3, and layer snow on top of that.  Then elevate that terrain.
<LAND_GENERATION>
base_terrain DIRT3
base_layer SNOW
<ELEVATION_GENERATION>
create_elevation 7 {
base_terrain DIRT3
base_layer SNOW
number_of_tiles 9320
number_of_clumps 20
}
number_of_tiles  Amount
Game versions: All
See also: number_of_tiles (land), number_of_tiles (terrain)
Arguments:
Amount - number (default: about 120 on tiny maps)

Total base tile count allocated to this create_elevation command.  If number_of_clumps is specified, this value is divided equally among the clumps.

Example: Create one hill on grassy terrain.
<ELEVATION_GENERATION>
create_elevation 7 {
base_terrain GRASS
number_of_tiles 600
}
number_of_clumps  Amount
Game versions: All
See also: number_of_clumps (terrain)
Arguments:
Amount - number (default: 1)

Number of individual hills to create.  If clumps are adjacent, the hills may merge.

Example: Create 4 hills of 100 tiles each.
<ELEVATION_GENERATION>
create_elevation 3 {
base_terrain GRASS
number_of_tiles 400
number_of_clumps 4
}
set_scale_by_size
Game versions: All
See also: set_scale_by_size (terrain)
Mutually exclusive with: set_scale_by_groups

Scales number_of_tiles to the map size.  Unscaled value refers to a 100x100 map (see: Map Sizes for the scaling table)
BUG (AoC/UP/HD): the behavior of set_scale_by_size and set_scale_by_groups is inverted with each attribute scaling elevation as the other one should.  This bug is fixed in DE.
If you see a script scaling by both size and groups, only the final attribute will apply!
If you want to scale elevation by both groups and size, you must do so manually using Conditionals.

Example: Create 4 hills which become larger on larger maps.  On a small map this will be 4 clumps with a total of 400*2.1 = 840 tiles.
<ELEVATION_GENERATION>
create_elevation 3 {
base_terrain GRASS
number_of_tiles 400
number_of_clumps 4
set_scale_by_size
}
set_scale_by_groups
Game versions: All
See also: set_scale_by_groups (terrain)
Mutually exclusive with: set_scale_by_size

Scales number_of_clumps to the map size.  Unscaled value refers to a 100x100 map (see: Map Sizes for the scaling table)
BUG (AoC/UP/HD): the behavior of set_scale_by_size and set_scale_by_groups is inverted with each attribute scaling elevation as the other one should.  This bug is fixed in DE.
If you see a script scaling by both size and groups, only the final attribute will apply!
Unlike for terrains, for elevation this attribute does NOT increase the total tile count.
If you want to scale elevation by both groups and size, you must do so manually using Conditionals.

Example: Create 400 tiles worth of hills, with the number of hills scaling to map size.  On a small map this will be 4x2.1 = 8 clumps and a total of 400 tiles.
<ELEVATION_GENERATION>
create_elevation 4 {
base_terrain GRASS
number_of_tiles 400
number_of_clumps 4
set_scale_by_groups
}
spacing  Amount
Game versions: All
Arguments:
Amount - number (1+) (default: 1 - no spacing)

Number of tiles between each elevation level.  Numbers larger than 1 will produce rings of flat terrain on each level of a hill.  

Example: Create one large large hill with increased spacing.
<ELEVATION_GENERATION>
create_elevation 7 {
base_terrain GRASS
number_of_tiles 3000
spacing 4
}
enable_balanced_elevation
Game versions: DE only

Removes the bias of hill placement towards the bottom (south) of the map.  Default is disabled, so you should always include this attribute!
Elevation will still be slightly biased towards the south, even with this attribute.
See Balanced Elevation Comparison in the Appendix for a comparison with and without this attribute.

Example: Spread a large number of hills fairly across the map.  Remove enable_balanced_elevation to see the difference.
<ELEVATION_GENERATION>
create_elevation 7 {
base_terrain GRASS
number_of_tiles 9320
number_of_clumps 9320
enable_balanced_elevation
}
<TERRAIN_GENERATION>
create_terrain DESERT {
base_terrain GRASS
land_percent 100
number_of_clumps 9320
height_limits 1 7
}

<CLIFF_GENERATION>
Optional section to include rocky impassible cliffs.
External guide: All about Cliffs
Simply typing the section header will generate default cliffs, so do not include it if you do not want cliffs!  There are no create-commands in this section.
Cliffs avoid the origins of all lands by 22 tiles, and will not be placed on water terrains.  They also avoid any slopes.
Cliffs create a terrain under themselves.  This is terrain 16, and looks like the normal grass.  This terrain turns into the map's base_terrain prior to <OBJECTS_GENERATION> but can be replaced during <TERRAIN_GENERATION>
If you want <CONNECTION_GENERATION> to avoid cliffs, you must have it avoid passing through the map's base terrain and not terrain 16.
Cliffs provide a combat bonus to units shooting from the top of a cliff.
cliff_type  CliffType
Game versions: DE only
Arguments:
CliffType - cliff type constant (see: Cliff Types) (default: gray granite cliffs)

Choose the color of the cliffs to match the theme of your map.
Currently the following are available:
CT_GRANITE
CT_DESERT
CT_SNOW
CT_MARBLE
CT_LIMESTONE

Example: Make the cliffs brown to match dirt and desert terrains:
<CLIFF_GENERATION>
cliff_type CT_DESERT
min_number_of_cliffs  Amount
max_number_of_cliffs  Amount
Game versions: All
Arguments:
Amount - number (default: min 3, max 8)
Make sure min does not exceed max.

Set the minimum and maximum number of distinct cliffs to create.  The actual number of cliffs is chosen at random from between min (inclusive) and max (exclusive).  Does not scale with map size, so you must do so manually using Conditionals.

Example: Create 5-7 cliffs on your map.
<CLIFF_GENERATION>
min_number_of_cliffs 5
max_number_of_cliffs 8
min_length_of_cliff  Length
max_length_of_cliff  Length
Game versions: All
Arguments:
Length - number (3+) (default: min 5, max 9)
Make sure min does not exceed max, otherwise the game will crash.

Cliff lengths are chosen at random from between min and max (inclusive).  The unit is NOT tiles, but rather "cliff segments".
Length 3 is 12 tiles, 4 is 15 tiles, 5 is 18 tiles, etc.
Minimum must be at least 3 for cliffs to appear at all.
Cliffs may end up shorter than expected if they run out of space.

Example: Create exactly 10 cliffs with lengths 12-18 tiles
<CLIFF_GENERATION>
min_number_of_cliffs 10
max_number_of_cliffs 10
min_length_of_cliff 3
max_length_of_cliff 5
cliff_curliness  %
Game versions: All
Arguments:
% - number (0-100) (default: 36)

The chance that a cliff changes direction at each segment.  Use low values for straight cliffs and high values for curly cliffs.

Example: Create cliffs that are more curly than usual.
<CLIFF_GENERATION>
min_number_of_cliffs 10
max_number_of_cliffs 10
min_length_of_cliff 10
max_length_of_cliff 10
cliff_curliness 50
min_distance_cliffs  Distance
Game versions: All
Arguments:
Distance - number (default: 2)

Minimum distance in "cliff units" between separate cliffs.
0 is 0 tiles, 1 is 3 tiles, 2 is 6 tiles, etc.

Example: Fill the map with cliffs that stay only 3 tiles from other cliffs.
<CLIFF_GENERATION>
min_number_of_cliffs 9999
max_number_of_cliffs 9999
min_distance_cliffs 1
min_terrain_distance  Distance
Game versions: All
Arguments:
Distance - number (default: 2)

Minimum distance in "cliff units" that cliffs will avoid water terrains by.
0 is 0 tiles, 1 is 3 tiles, 2 is 6 tiles, etc.
Note that this only considers terrains from <LAND_GENERATION>, as <TERRAIN_GENERATION> occurs after cliffs have already been placed.

Example: Fill the map with cliffs that stay only 3 tiles from water and 0 tiles from each other.
<LAND_GENERATION>
base_terrain WATER
create_player_lands {
terrain_type GRASS
	land_percent 100
other_zone_avoidance_distance 10
}
<CLIFF_GENERATION>
min_number_of_cliffs 9999
max_number_of_cliffs 9999
min_distance_cliffs 0
min_terrain_distance 1

<TERRAIN_GENERATION>
Replace terrains with other terrains.  Often used to place clumps of forest and to make the map look nice by mixing terrains for visual diversity.  Terrain generation occurs after lands, elevation and cliffs, but before connections.  Terrains are generated sequentially in the order they appear in the script.  Terrain positions cannot be directly specified.
color_correction  ColorCorrectionType
Game versions: DE only
External reference: Official DE Documentation
Arguments:
ColorCorrectionType - color correction constant (see: Season Types) (default: no color correction)

Specify a color correction type to apply on your map.
Not visible if the "Map Lighting" setting is disabled.
Water-specific color correction is controlled by water_definition.
on UP, use weather_type instead.

Example: Desert-themed lighting
<TERRAIN_GENERATION>
color_correction CC_DESERT
create_terrain  TerrainType  { Attributes }
Game versions: All
Arguments:
TerrainType - terrain constant (see: Terrains) (default: GRASS)

Create a clump of terrain.  The exact behavior is dependent on the attributes specified.

Example: Create a large clump of forest terrain on grass terrain
<TERRAIN_GENERATION>
create_terrain FOREST {
base_terrain GRASS
land_percent 10
}
base_terrain  TerrainType
Game versions: All
See also: base_terrain (land), base_terrain (elevation)
Arguments:
TerrainType - terrain constant (see: Terrains) (default: GRASS)

Specify the base terrain on which you want to place your new terrain.
BUG (DE): Does not default to GRASS, so make sure to specify the base terrain.

Example: Create a large clump of forest terrain on grass terrain, then create water on the forest
<TERRAIN_GENERATION>
create_terrain FOREST {
base_terrain GRASS
land_percent 10
}
create_terrain WATER {
    base_terrain FOREST
}
base_layer  TerrainType
Game versions: DE only
See also: base_layer (land), base_layer (elevation),
Arguments:
TerrainType - terrain constant (see: Terrains) (default: none)

Specify a layered terrain on which you want to place your new terrain.
If used together with base_terrain, the new terrain will be placed only where both the base and the layer apply.

Example: Layer desert on grass, and then place water on the layered desert.
<TERRAIN_GENERATION>
create_terrain DESERT {
base_terrain GRASS
land_percent 10
terrain_mask 1
}
create_terrain WATER {
base_layer DESERT
}
beach_terrain  TerrainType
Game versions: DE only
Arguments:
TerrainType - terrain constant (see: Terrains) (default: BEACH)

Specify a terrain that should be placed where the current terrain borders water.
If a non-beach terrain is specified, players will not be able to build docks on this coastline
If a water terrain is specified, it will fully replace the terrain specified in create_terrain, so this is NOT recommended. 
BUG: beach_terrain does not work when a <CONNECTION_GENERATION> section is present

Example: Create a dirt island with beaches that have vegetation.
<LAND_GENERATION>
base_terrain WATER
<TERRAIN_GENERATION>
create_terrain DIRT {
number_of_tiles 500
spacing_to_other_terrain_types
base_terrain WATER
beach_terrain DLC_BEACH2
}
terrain_mask  Layer
Game versions: DE only
External reference: Official DE Documentation
Arguments:
Layer - number (1,2) (default: 0 - no masking)
1 - new terrain is masked over the base terrain and inherits its properties
2 - new terrain is masked under the base terrain and provides new properties

Enables terrain masking/layering for the terrain being created.  Terrain inherits all properties, placement restrictions, automatic objects (such as trees for forest terrains), minimap color, etc. from the terrain underneath (ie. base_terrain when masking over, or create_terrain when masking under)
Terrain masking is a great way to blend terrains in a realistic and visually appealing manner.
Masking layers 1 and 2 have different visual masking patterns.
Terrain will have animated water if ANY of the component terrains are water.
Legacy terrains that are already a blend of two texture files cannot be visually masked.  They will contribute fully to the appearance of the final terrain.  These terrains are:
GRASS_SNOW, DIRT_SNOW, [dirt snow foundation], DLC_MOORLAND, DLC_JUNGLELEAVES, [road snow], [road fungus], DLC_DRYROAD, DLC_JUNGLEROAD, DLC_ROADGRAVEL
There are also some special cases with beach terrains, which may not always mask as expected.  (potentially a bug)

Example: Snow is masked on top of grass.  Will produce grass decoration objects.
<TERRAIN_GENERATION>
create_terrain SNOW
{
  base_terrain GRASS
  land_percent 50
  terrain_mask 1
}
Example2: Snow is masked underneath grass.  Would produce snow decoration objects, if there were any in the game.
<TERRAIN_GENERATION>
create_terrain SNOW {
base_terrain GRASS
land_percent 50
terrain_mask 2 
}
spacing_to_other_terrain_types  Distance
Game versions: All
Arguments:
Distance - number (default: 0)

Minimum distance that this terrain will stay away from other terrain types.  
Only considers existing terrains at the time of generation - terrains generated later will need their own spacing.
Terrains will not stay away from the same terrain type created previously.  This requires the use of an intermediate placeholder terrain.
Also affects the distance that the terrain will stay away from cliffs (because cliffs generate their own terrain underneath them - terrain 16)
When used with set_flat_terrain_only it also affects the distance that the terrain will stay away from slopes.

Example: Create a lake, and then fill the rest of the map with a forest which stays 10 tiles away from the water.
<TERRAIN_GENERATION>
create_terrain WATER {
base_terrain GRASS
land_percent 10
}
create_terrain FOREST {
base_terrain GRASS
spacing_to_other_terrain_types 10
land_percent 100
}
spacing_to_specific_terrain  TerrainType  Distance
Game versions: DE only
Arguments:
TerrainType - terrain constant (see: Terrains)
Distance - number (default: 0)

Minimum distance that this terrain will stay away from a specific terrain.
Can be used multiple times to avoid multiple terrain types.
Only considers existing terrains at the time of generation - terrains generated later will need their own spacing.
Cannot be used to avoid the terrain currently being placed.  Doing this will prevent the terrain from being placed at all.
spacing_to_other_terrain_types takes precedence if larger.

Example: Generate forest that stays away from various terrains.
<TERRAIN_GENERATION>
create_terrain FOREST {
    base_terrain GRASS
    land_percent 20
    number_of_clumps 30
    spacing_to_specific_terrain WATER 15
    spacing_to_specific_terrain SHALLOW 8
    spacing_to_specific_terrain ICE 6
    spacing_to_specific_terrain DESERT 3
}
set_flat_terrain_only
Game versions: All
Requires: spacing_to_other terrain_types > 0

The terrain will avoid sloped tiles by the distance specified in spacing_to_other_terrain_types
Only works when a distance of at least 1 has been specified.

Example: Create a hill where the bottom and top are desert, but the slope is grass
<ELEVATION_GENERATION>
create_elevation 7 {
base_terrain GRASS
number_of_tiles 3000
number_of_clumps 1
}
<TERRAIN_GENERATION>
create_terrain DESERT {
base_terrain GRASS
land_percent 100
number_of_clumps 9320
spacing_to_other_terrain_types 1
set_flat_terrain_only
}
land_percent  %
Game versions: All
See also: land_percent (land), 
Mutually exclusive with: number_of_tiles
Arguments:
% - number (1-100) (default: number_of_tiles)

Percentage of the total map allocated to this create_terrain command.  If number_of_clumps is specified, this value is divided equally among the clumps.
Terrain will only be replaced where the appropriate base_terrain or base_layer is present, and will only replace the specified number of individual clumps, so it will not necessarily fill 100% of the map if set to 100.

Example: Create a desert that covers 50% of the map
<TERRAIN_GENERATION>
create_terrain DESERT {
base_terrain GRASS
land_percent 50
}
number_of_tiles  Amount
Game versions: All
See also: number_of_tiles (land),  number_of_tiles (elevation)
Mutually exclusive with: land_percent
Arguments:
Amount - number (default:122 tiles on a tiny map)

Total tile count allocated to this create_terrain command.  If number_of_clumps is specified, this value is divided equally among the clumps.

Example: Create a 500-tile lake
<TERRAIN_GENERATION>
create_terrain WATER {
base_terrain GRASS
number_of_tiles 500
set_avoid_player_start_areas
}
number_of_clumps  Amount
Game versions: All
See also: number_of_clumps (terrain)
Arguments:
Amount - number (default: 1)
A maximum of 9320 should be used when also specifying set_scale_by_groups

Number of individual terrain patches to create.
If clumps are larger than expected (or total count is lower than expected), several adjacent clumps have merged.

Example: Create 40 forest clumps on grass terrain.
<TERRAIN_GENERATION>
create_terrain FOREST {
base_terrain GRASS
land_percent 20
number_of_clumps 40
}
clumping_factor  Factor
Game versions: All
See also: clumping_factor (land)
Arguments:
Factor - number (default: 20 - different than for lands)
Useful range of about 0 - 25

The extent to which terrain tiles prefer to be together next to other tiles of the same clump.  Moderate values (5-25) create rounder terrain patches, while low values (0-5) create more irregular terrain patches.  Negative values create extremely snakey terrains.

Example: Create a regularly-shaped bamboo forest
<TERRAIN_GENERATION>
create_terrain BAMBOO {
base_terrain GRASS
number_of_tiles 500
clumping_factor 20
}
set_scale_by_size
Game versions: All
See also: set_scale_by_size (elevation)
Mutually exclusive with: set_scale_by_groups

Scales number_of_tiles to the map size.  Unscaled value refers to a 100x100 map (see: Map Sizes for the scaling table)
If you see a script scaling by both size and groups, only the final attribute will apply!
If you want to scale by both groups and size, use set_scale_by_groups instead.

Example: Create 4 lakes which become larger on larger maps.  On a small map this will be 4 clumps with a total of 400*2.1 = 840 tiles.
<TERRAIN_GENERATION>
create_terrain WATER {
base_terrain GRASS
number_of_clumps 4
number_of_tiles 400
set_scale_by_size
}
set_scale_by_groups
Game versions: All
See also: set_scale_by_groups (elevation)
Mutually exclusive with: set_scale_by_size

Scales number_of_clumps to the map size.  Unscaled value refers to a 100x100 map (see: Map Sizes for the scaling table)
If you see a script scaling by both size and groups, only the final attribute will apply!
When used with number_of_tiles, the total tiles are also scaled to map size as well (but only for terrains, not for elevation).

Example: Create 400 tiles worth of lakes, with the number of lakes AND the total number of tiles scaling to map size.  On a small map this will be 4x2.1 = 8 clumps with a total of 400*2.1 = 840 tiles.
<TERRAIN_GENERATION>
create_terrain WATER {
base_terrain GRASS
number_of_clumps 4
number_of_tiles 400
set_scale_by_groups
}
set_avoid_player_start_areas  Distance
Game versions: All
Arguments:
Distance - number (default: 0 - no avoidance)
Defaults to 13, if you specify the argument but omit the distance.
This argument can ONLY be specified in DE

The terrain will avoid the origins of player lands by the specified number of tiles (with some variance).
Useful to prevent forests or water terrain from being directly under the town center.
In DE the distance can be adjusted.

Example: Forest Nothing with small clearings
<TERRAIN_GENERATION>
create_terrain FOREST {
base_terrain GRASS
land_percent 100
number_of_clumps 999
set_avoid_player_start_areas 12
}
height_limits  Min  Max
Game versions: All
Arguments:
Min - number (default: none)
Max - number (default: none)

The terrain will only be placed on tiles of height between min and max (inclusive).
For most purposes, values between 0-7 are useful.  0 being the standard non-elevated height and 7 being the max height that can be produced by create_elevation

Example: Create a hill and place desert terrain only on the slopes
<ELEVATION_GENERATION>
create_elevation 7 {
base_terrain GRASS
number_of_tiles 3000
number_of_clumps 1
}
<TERRAIN_GENERATION>
create_terrain DESERT {
base_terrain GRASS
land_percent 100
number_of_clumps 9320
height_limits 1 6
}

<CONNECTION_GENERATION>
Optional section to replace terrains with other terrains, specifically along a path between the origins of lands.  Can be used to create roads between players, shallows across rivers, and to ensure that forests do not completely separate players.
You can only specify whole systems of connections, not individual connections.  
Connections are processed in order.
If the connection between two locations is not possible, that connection will not be produced at all.
accumulate_connections
Game versions: DE only

Can be used to revert a DE-specific behavior change where all connections are based on the terrain prior to connection generation, and replacing terrain created by earlier connections is impossible.
Using this allows you to replace terrains created in previous connections.

Example: Create a wide gap through a forest and then run a road through the created gap.
<LAND_GENERATION>
base_terrain FOREST
create_player_lands {
terrain_type FOREST
other_zone_avoidance_distance 10
}
<CONNECTION_GENERATION>
accumulate_connections
create_connect_all_lands {
replace_terrain FOREST LEAVES
terrain_size FOREST 10 0
}
create_connect_all_lands {
replace_terrain LEAVES ROAD
terrain_size LEAVES 1 0
}
create_connect_all_players_land  { Attributes }
Game versions: All

Connections will be generated between the origins of all player lands, and all lands assigned to players.
Connections may pass through neutral lands if the cost is favorable.

Example: connect all players with dirt terrain
<LAND_GENERATION>
create_player_lands {
terrain_type DESERT
number_of_tiles 100
}
<CONNECTION_GENERATION>
create_connect_all_players_land {
default_terrain_replacement DIRT
}
create_connect_teams_lands  { Attributes }
Game versions: All

Connections will be generated between the origins of player lands belonging to members of the same team.
Connections may pass through neutral or enemy lands if the cost is favorable.
By default, players are on their own team in the scenario editor, so keep this in mind when testing in the scenario editor.  
You can use the diplomacy tab to simulate team setups.

Example: connect team members with a road
<LAND_GENERATION>
create_player_lands {
terrain_type DESERT
number_of_tiles 100
}
<CONNECTION_GENERATION>
create_connect_teams_lands {
replace_terrain DESERT ROAD
replace_terrain GRASS ROAD
}
create_connect_all_lands  { Attributes }
Game versions: All

Connections will be generated between the origins of all lands.

Example: interconnect all player islands and neutral islands.
<LAND_GENERATION>
base_terrain WATER
create_player_lands {
terrain_type DESERT
number_of_tiles 100
}
create_land {
terrain_type FOREST
number_of_tiles 100
land_position 99 1
}
create_land {
terrain_type PINE_FOREST
number_of_tiles 100
land_position 50 50
}
<CONNECTION_GENERATION>
create_connect_all_lands {
replace_terrain WATER SHALLOW
}
create_connect_same_land_zones  { Attributes }
Game versions: All

Behaves identically to create_connect_all_lands 

Example: see create_connect_all_lands 
create_connect_land_zones  ZoneNumber1  ZoneNumber2  { Attributes }
Game versions: DE only
Arguments:
ZoneNumber1 - numeric zone ID
ZoneNumber2 - numeric zone ID

Generate connections between all lands belonging to the zones listed.
By default lands from create_player_lands are each in their own unique zone (PlayerNumber - 10), while lands created with create_land all share the same zone (-10).

Example: connect a lake, forest and desert to each other
create_land {
    terrain_type FOREST
    land_percent 5
    zone 1
}
create_land {
    terrain_type DESERT
    land_percent 5
    zone 1
}
create_land {
    terrain_type WATER
    land_percent 5
    zone 50
}
<CONNECTION_GENERATION>
create_connect_land_zones 1 50 {
default_terrain_replacement ICE 
}
Example2: connect player 2 and player 4
<LAND_GENERATION>
create_player_lands {
    terrain_type DESERT
    land_percent 5
}
<CONNECTION_GENERATION>
create_connect_land_zones -6 -8 {
    default_terrain_replacement ROAD
}
create_connect_to_nonplayer_land  { Attributes }
Game versions: DE only
External reference: Official DE Documentation

Connect all player lands to all neutral lands, but do not directly generate connections between individual players.
BUG: create_connect_to_nonplayer_land blocks all future connection generation
BUG: It also blocks all team connection generation (except those involving player 1), when used after create_connect_teams_lands

Example: connect players to a central desert, but not directly to each other
<LAND_GENERATION>
create_player_lands {
terrain_type DIRT2
number_of_tiles 100
}
create_land {
terrain_type DESERT
number_of_tiles 500
land_position 50 50
}
<CONNECTION_GENERATION>
create_connect_to_nonplayer_land {
replace_terrain GRASS ROAD2
}
default_terrain_replacement  TerrainType
Game versions: All
Arguments:
TerrainType - terrain constant (see: Terrains)

Replace ALL terrain in the connection with the specified terrain.
Useful for debugging purposes to quickly visualize all connection paths.
Overrides any previously specified replace_terrain attributes; does not override future attributes.

Example: Replace all connecting terrain with road, but replace water with shallows instead.
<LAND_GENERATION>
base_terrain WATER
create_player_lands {
land_percent 100
other_zone_avoidance_distance 10
}
<CONNECTION_GENERATION>
create_connect_all_players_land {
default_terrain_replacement ROAD
replace_terrain WATER SHALLOW
}
Example 2: Replace everything with ice to see which routes the connections are taking.
<CONNECTION_GENERATION>
create_connect_all_lands {
default_terrain_replacement ICE
}
replace_terrain  TerrainTypeOld  TerrainTypeNew
Game versions: All
Arguments:
TerrainTypeOld - terrain constant (see: Terrains)
TerrainTypeNew - terrain constant (see: Terrains)

If the specified terrain is part of the connection, replace it with the new terrain specified.
This attribute can, and should, be used multiple times for different terrains.
A terrain can be replaced with itself.
Connections can pass through terrains even if they are not specified.
DE: The old terrain refers to the terrain that was present at the beginning of <CONNECTION_GENERATION> - even if that terrain has already been replaced by a previous command or attribute.  This behavior can be disabled by using accumulate_connections.

Example: replace several terrains in a connection
<CONNECTION_GENERATION>
create_connect_all_players_land {
replace_terrain GRASS DIRT2
replace_terrain FOREST LEAVES
replace_terrain SNOW_FOREST GRASS_SNOW
replace_terrain DIRT DIRT3
replace_terrain WATER SHALLOW
}
terrain_cost  TerrainType  Cost
Game versions: All
Arguments:
TerrainType - terrain constant (see: Terrains)
Cost - number (0-4294967296) (default 1)
0 (or any negative value) means that the connection CANNOT pass through the specified terrain at all, so 1 is the "lowest" cost
For most usual applications a cost range of 1-15 is sufficient
DE only: accepts floating-point values

The cost of having the connection run through the specified terrain. 
This attribute can be used multiple times for different terrains.
If all costs are equal, the connections will be straight lines.
If some costs are higher, the algorithm will prefer going though lower cost routes, even if they are longer than the more direct route.
A cost of 0 will prevent the connection generation from running through that terrain.  If a land origin is on such a terrain, or such a terrain MUST be crossed, then the connections to that land will not be generated at all.  This can be used to manipulate connections to only connect certain lands and not others.
Doing this excessively can slow down the map generation time.

Example: generate connections that prefer going through grass and generally avoid forests and deeper water
<CONNECTION_GENERATION>
create_connect_all_players_land {
replace_terrain GRASS ROAD
replace_terrain FOREST LEAVES
replace_terrain WATER SHALLOW
replace_terrain MED_WATER SHALLOW
replace_terrain DEEP_WATER SHALLOW
terrain_cost GRASS 1
terrain_cost FOREST 7
terrain_cost WATER 7
terrain_cost MED_WATER 12
terrain_cost DEEP_WATER 15
}
terrain_size  TerrainType  Radius  Variance
Game versions: All
Arguments:
TerrainType - terrain constant (see: Terrains)
Radius - number (default: 1)
Given that a Ludicrously-sized map is 480 tiles wide, 961 would be enough to cover the entire map in all situations.
Variance - number (default: 0) 

When a connection passes through a tile of the specified terrain, the area within radius +/- variance will be subject to replace_terrain / default_terrain_replacement and terrains will be replaced accordingly.
This attribute can be used multiple times for different terrains.
A radius of 0 will still replace a single-tile width path.
Variance is randomly selected for each tile crossed.
If variance is larger than radius, it can reduce the radius to a negative value, in which case no terrain will be replaced around these specific locations.

Example: Connect players with a variable ragged-looking road, and with shallows that are slightly wider.
<CONNECTION_GENERATION>
create_connect_all_players_land {
replace_terrain GRASS ROAD
replace_terrain WATER SHALLOW
terrain_size GRASS 1 1
terrain_size WATER 3 1
}

<OBJECTS_GENERATION>
Place buildings, units, resources, animals, straggler trees, decoration, etc.  Objects are placed in order.  Normally, only 1 object can be placed per tile.  If an object cannot find a valid position, it will not generate at all.  So you should place the most important objects first.  There are a few unusual cases:
Creating the object VILLAGER without specifying the amount will give each civilization their correct number of starting villagers.
In DE this has changed and everyone gets 3 villagers to start, with the extra ones being spawned by the town center (to prevent Chinese from being too strong on nomad starts).
The object SCOUT will give an eagle to mesoamerican civilizations and a scout to all other civilizations.
Walls have some special behavior (see: Walls)
create_actor_area  X  Y  Identifier  Radius
Game versions: DE only
See also: actor_area
Arguments:
X - number (x-coordinate in tiles; see Map Sizes)
Y - number (y-coordinate in tiles; see Map Sizes)
Identifier - number
Radius - number (square radius in tiles)

Create an actor area at the given location (rather than being associated with a specific object), with the ID and radius specified.
These actor areas are created before any create_object commands are handled, regardless of their position in the script.
Useful for making certain objects avoid certain positions or areas of the map
You can also specify coordinates outside of the map, which can be useful with a sufficiently large radius to avoid the map edges
Note that the X and Y coordinates are in tiles, NOT % of map width.  They must be manually scaled to map size.  See Map Sizes for the side length on each map size.
Multiple actor areas can share the same identifier.
create_actor_area will crash the game if no lands are generated on the map.  This should not be an issue on completed maps, since you always have lands.

Example: Create an actor area that prevents relics from spawning near the center of the map
<OBJECTS_GENERATION>
if TINY_MAP    create_actor_area 60 60 1234 30
elseif SMALL_MAP create_actor_area 72 72 1234 36
elseif MEDIUM_MAP create_actor_area 84 84 1234 42
elseif LARGE_MAP create_actor_area 100 100 1234 50
elseif HUGE_MAP create_actor_area 110 110 1234 55
elseif GIGANTIC_MAP create_actor_area 120 120 1234 60
elseif LUDIKRIS_MAP create_actor_area 240 240 1234 120
endif
create_object RELIC {
    number_of_objects 500
    set_gaia_object_only
    avoid_actor_area 1234
}
create_object_group  GroupName  {
add_object  ObjectType  % }
Game versions: DE only
Arguments: 
GroupName - text
ANY characters are valid; convention is to use uppercase letters and underscores
ObjectType - object constant (see: Objects)
% - number (0-99)

List a selection of objects with probabilities.  When the chosen constant name is used in your script, an object will be chosen from the group at random, using the specified probabilities.
If a group of objects is placed, each one will be individually randomized.
If used with set_place_for_every_player, the group will be randomized each time, so a group generally should not contain objects with different resource amounts or different gameplay effects.
BUG:  The % currently doesn't work; all objects in the group are equally likely regardless of what number you specify.
You can duplicate entries for animals you want to have more frequently as a workaround

Example: Create a pool of all cow variations and then generate clusters of mixed cow variants.
<OBJECTS_GENERATION>
create_object_group HERDABLE_A {
    add_object DLC_COW 25
    add_object DLC_COW_B 25
    add_object DLC_COW_C 25
    add_object DLC_COW_D 25
}
create_object HERDABLE_A { 
    number_of_objects 6
    number_of_groups 24
}
create_object  ObjectType  { Attributes }
Game versions: All
Arguments:
ObjectType - object constant (see: Objects)

Place the specified object, according to the chosen attributes.

Example: Give all players a town center.
<OBJECTS_GENERATION>
create_object TOWN_CENTER {
set_place_for_every_player
max_distance_to_players 0
}
number_of_objects  Amount
Game versions: All
Arguments:
Amount - number (default: 1)
A maximum of 9320 should be used when also specifying set_scaling_to_map_size

Number of objects to create.  

Example: Place 10 individual gold mines on the map.
<OBJECTS_GENERATION>
create_object GOLD {
number_of_objects 10
}
number_of_groups  Amount
Game versions: All
Arguments:
Amount - number (default: individual objects - no groups)
A maximum of 9320 should be used when also specifying set_scaling_to_map_size

Place the specified number of groups, which each consist of the number of individual objects chosen in number_of_objects
Total objects = number_of_objects x number_of_groups

Example: Place 20 groups of each 5 boars.
<OBJECTS_GENERATION>
create_object BOAR {
number_of_objects 5
number_of_groups 20
}
group_variance  Amount
Game versions: All
Arguments:
Amount - number (default: 0)

The number_of_objects is randomly varied by up to the amount specified, with maximum variance in the positive direction being reduced by 1.
A minimum of 1 object will always be generated, even if the variance would make the count 0 or negative.
Note that each group varies independently, so this is not suitable for ensuring fair player starting resources.  Consider using Random Code for such cases.

Example: Create 10 patches with each 2-7 forage bushes.
<OBJECTS_GENERATION>
create_object FORAGE {
    number_of_objects 5
    number_of_groups 10
    group_variance 3
    set_tight_grouping
}
group_placement_radius  Radius
Game versions: All
Arguments: 
Radius - number (default: 3 = a 7x7 area)

Specify the number of tiles out from the central tile that objects belonging to the same group may spawn.
Activates grouping behavior.
Useful for keeping gold/stone/berries from forming long lines.
If the number_of_objects exceeds the available number of tiles, then a perfect square worth of objects will be filled.
If used with a group of objects that have set_loose_grouping and set_circular_placement, the area will be a circle instead of a square.

Example: Give each player forage bushes that must stay in a 3x3 area.
<OBJECTS_GENERATION>
create_object FORAGE {
number_of_objects 7
set_tight_grouping
group_placement_radius 1
set_gaia_object_only
set_place_for_every_player
min_distance_to_players 7
max_distance_to_players 8
}
set_tight_grouping
Game versions: All
Mutually exclusive with: set_loose_grouping

Objects belonging to the same group must be in adjacent tiles.  Commonly used for berries, gold and stone.
Activates grouping behavior.
Objects that are larger than one tile and cannot overlap (most buildings), will not be placed when using tight grouping.
NOTE: most constraints on object placement (ex. avoid_forest_zone, min_distance_to_map_edge, min_distance_group_placement, avoid_actor_area) apply only to the center of the group, not the individual group members.  Use set_loose_grouping if you want constraints to apply to group members individually.

Example: Far player stone.
<OBJECTS_GENERATION>
create_object STONE {
number_of_objects 4
group_placement_radius 2  
set_tight_grouping
set_gaia_object_only
set_place_for_every_player
min_distance_to_players 20
max_distance_to_players 27
}
set_loose_grouping
Game versions: All
Mutually exclusive with: set_tight_grouping

Objects belonging to the same group can be placed anywhere within the confines of group_placement_radius
Activates grouping behavior.
Loose grouping is the default type of grouping, so you can omit this attribute if you specify group_placement_radius
Commonly used for sheep and deer.
When used with set_circular_placement, the group_placement_radius becomes round.
NOTE: most constraints on object placement (ex. avoid_forest_zone, min_distance_to_map_edge, min_distance_group_placement, avoid_actor_area) apply to each group member individually.  However, the game doesn't check if there is enough room for the whole group to spawn when choosing a location for the group, so this can cause issues where some group members fail to spawn.  For important objects with many constraints on placement, consider using set_tight_grouping instead.

Example: Give players a group of 7 deer.
<OBJECTS_GENERATION>
create_object DEER {
number_of_objects 7
number_of_groups 1
group_placement_radius 5
set_loose_grouping
set_gaia_object_only
set_place_for_every_player
min_distance_to_players 14
max_distance_to_players 22
}
min_connected_tiles  Amount
Game versions: DE only
Requires: objects being placed in groups
Arguments:
Amount - number (default: 0)

Prevents grouped objects from being placed in an area with fewer tiles than the specified amount.  Intended to be used to keep objects off tiny islands and out of tiny forest clearings.
BUG: Objects will be extremely biased towards being placed in the top left of the map, making this attribute useless for the intended purpose.  (Use max_distance_to_other_zones or avoid_forest_zone instead). 

Example: Create many groups of sheep that avoid small forest clearings and only appear in the top half of the map.
<LAND_GENERATION>
base_terrain  BAMBOO
create_player_lands {
    land_percent 50
    border_fuzziness 1
    left_border 25    right_border 25    top_border 25    bottom_border 25
    zone 1
}
<OBJECTS_GENERATION>
create_object SHEEP {
    number_of_objects 4
    set_tight_grouping
    number_of_groups 150
    min_connected_tiles 80
}
resource_delta  Amount
Game versions: UP/DE
External reference: UserPatch Reference
Arguments:
Amount - number (default: 0)
In UP, resource amount will overflow past 32767
In DE, resource amount will overflow past 2147483647 (but will become inaccurate before then)
Negative values can be used to reduce the resources

Modify the amount of food/wood/gold/stone in an object.
Does not work for farms.
Does not appear when testing a map from the scenario editor.
You can give food to wolves.  However, if a villager runs into and kills a wolf, they will automatically gather the food (instead of doing whatever you sent them to do) - so this is not great for gameplay.

Example: Create gold piles that have 100 less gold in them and stone mines with 100 more stone.
<OBJECTS_GENERATION>
create_object GOLD {
number_of_objects 7
resource_delta -100
}
create_object STONE {
number_of_objects 7
	resource_delta 100
}
second_object  ObjectType
Game versions: DE only
Arguments:
ObjectType - object constant (see: Objects)

Specify ANY object to be placed on top of the main object.
If you are placing multiple objects, each will get the specified second object.
In the official maps, it used to place villagers on top of farms for empire wars.
second_object can be used to bypass terrain restrictions by using an invisible placeholder object as the main object.
For off-grid placeholders, any dead unit can be used, especially dead heroes that are without graphics in DE (for example, ID 647).
For on-grid placeholders, try the terrain blocker (ID 1613) or the dead fish trap (ID 278), or a berry bush with zero food (using resource_delta). (DO NOT USE object 1291, as a recent update made it so that this object will now permanently convert player sheep to gaia).
Alternatively, terrain restrictions of an object can be changed with effect_amount or removed entirely with ignore_terrain_restrictions

Example: Players start with a cow underneath their town center.
<OBJECTS_GENERATION>
create_object TOWN_CENTER {
set_place_for_every_player
max_distance_to_players 0
second_object DLC_COW
}
set_scaling_to_map_size
Game versions: All
Mutually exclusive with: set_scaling_to_player_number

Scales number_of_groups to the map size.  Unscaled value refers to a 100x100 map (see: Map Sizes for the scaling table)
If no grouping is present, scaling applies to number_of_objects instead.

Example: Create clumps of 10 gold and scale the number of groups to map size.
<OBJECTS_GENERATION>
create_object GOLD {
number_of_objects 10
number_of_groups 3
set_scaling_to_map_size
set_tight_grouping
}
set_scaling_to_player_number
Game versions: All
Mutually exclusive with: set_scaling_to_map_size

Scales number_of_groups to player count. This means x2 for a 2-player game and x8 for an 8-player game.
If no grouping is present, scaling applies to number_of_objects instead.

Example: Scale the number of relics by the number of players
create_object RELIC {
number_of_objects 2
set_scaling_to_player_number
}
set_place_for_every_player
Game versions: All
Mutually exclusive with: place_on_specific_land_id

Place the object(s) as a personal object for each player (actually for each player land).  Objects that cannot be owned by players (boar, gold, trees, etc.) also require set_gaia_object_only to be placed for every player.
Only works for player lands or lands assigned to players.  Disabled by land_id
Objects will only be placed where they are not separated from the origin of their land by a terrain they are restricted on, unless ignore_terrain_restrictions is used.
This means that on islands your resources will only end up on your own island
It also means that player gold mines on acropolis can only be placed on the hilltops, because gold is restricted from the rock terrain.
Water objects (docks/boats) CAN be placed if the player land is made of a dirt terrain type.
Terrain restrictions can be bypassed by using a placeholder and second_object or modified with effect_amount or removed with ignore_terrain_restrictions
Even though road terrains are restricted for resources, they do not form a separation the way other terrains do.
If avoid_other_land_zones is specified, the object will only be placed on tiles belonging to this land.

Example: Give every player their starting villagers.
create_object VILLAGER {
set_place_for_every_player
min_distance_to_players 6
max_distance_to_players 7
}
place_on_specific_land_id  Identifier
Game versions: All
Mutually exclusive with: set_place_for_every_player
Arguments: 
Identifier - number

Place the object(s) on each land of the specified identifier.  IDs are set in <LAND_GENERATION> by using the land_id attribute.
Objects will only be placed where they are not separated from the origin of their land by a terrain they are restricted on, unless ignore_terrain_restrictions is used.
Even though road terrains are restricted for resources, they do not form a separation the way other terrains do.
If avoid_other_land_zones is specified, the object will only be placed on tiles belonging to this land.
If multiple lands have the same ID, the object(s) will be placed on all relevant lands.

Example: Create a tiny snowy land and place a gold mine on it.
<LAND_GENERATION>
base_terrain WATER
create_player_lands {
	terrain_type DIRT
	land_percent 0
}
create_land {
terrain_type SNOW
land_percent 0
land_id 13
land_position 50 50
}
<OBJECTS_GENERATION>
create_object GOLD {
place_on_specific_land_id 13
find_closest
}
avoid_other_land_zones  Distance
Game versions: DE only
Requires: set_place_for_every_player or place_on_specific_land_id
Arguments: 
Distance - number (default: no avoidance)

An object will only be placed on tiles belonging to the land that it is referenced to, and will avoid the edges of that land by the specified distance.
If this command is NOT specified, then objects may be placed outside of their referenced land.
Even if 0 or a negative value is specified, this attribute will still force objects to stay on the land, so do not use it at all if you want objects to be placed beyond the borders of the land.

Example: Place gold on a specific desert land, while preventing it from being close to the edges of the land.
create_land {
    terrain_type DESERT 
    land_percent 10
    land_id 1
}
<OBJECTS_GENERATION>
create_object GOLD { 
    place_on_specific_land_id 1
    set_gaia_object_only
    number_of_objects 999
    avoid_other_land_zones 4
}
generate_for_first_land_only
Game versions: DE only
Requires: set_place_for_every_player or place_on_specific_land_id

If there are multiple create_player_lands commands or multiple lands sharing a land_id, this object will only be placed on the first applicable land, instead of on all of them.

Example: Generate two lands for each player and give each player a house on both of them but a king only on one of them.
<LAND_GENERATION>
base_terrain WATER
create_player_lands {
    land_percent 10
}
create_player_lands {
    land_percent 10
}
<OBJECTS_GENERATION>
create_object HOUSE {
    set_place_for_every_player
}
create_object KING {
    set_place_for_every_player
    generate_for_first_land_only
}
set_gaia_object_only
Game versions: All

Use with set_place_for_every_player to place gaia (neutral) objects on a per-player basis.  Must be used when placing player's gold/stone/berries/deer/boar.
Can be used for controllable objects (for example, sheep)
Units and buildings will permanently join the player who first finds them, unless set_gaia_unconvertible is also specified.
Gaia building architectural style can be changed with set_gaia_civilization

Example: Give every player four gaia sheep close to their starting town. 
<OBJECTS_GENERATION>
create_object SHEEP {
number_of_objects 4
set_loose_grouping
set_gaia_object_only
set_place_for_every_player
min_distance_to_players 7
max_distance_to_players 8
}
set_gaia_unconvertible
Game versions: DE only
Requires: set_gaia_object_only
Mutually exclusive with: set_building_captureable

Use with any gaia object to make that object unrescuable by players and hostile towards them.
Must be used after set_gaia_object_only
Note that gaia military units will act as if they were on defensive stance - attacking anything that enters their search radius and retreating if you run away.
Does not work when testing from the scenario editor.
Unrescuable status does not apply to second_object
Certain objects are always convertible (ie. monuments) or buggy (town centers, gates).
Gaia markets lose functionality, and cannot be traded with.
Use object 1646 to give gaia an indestructible market for players to trade with.
Villagers will repair gaia buildings, rather than attack them.

Example: Decorate the map with unrescuable gaia pyramids.
<OBJECTS_GENERATION>
create_object PYRAMID {
number_of_objects 3
set_gaia_object_only
set_gaia_unconvertible
make_indestructible
}
set_building_capturable
Game versions: DE only
Mutually exclusive with: set_gaia_unconverible

Used to make a building switch control to whoever most recently has units nearby.
Has no effect on units or other non-building objects.
Can be used for buildings that start under gaia control or under player control.
Capturable buildings cannot be deleted.
Capturable buildings can be destroyed (unless make_indestructible is used).

Example: Place an outpost on the map that will convert to the control of whoever is currently nearby.
<OBJECTS_GENERATION>
create_object OUTPOST {
    set_gaia_object_only
    make_indestructible
    set_building_capturable
}
make_indestructible
Game versions: DE only

Make a building indestructible.  The building receives 9999 HP, 1000/1000 armor, and cannot be attacked, damaged or deleted.
Has no effect on units or other non-building objects.
Can be used to make neutral gaia markets, docks, or whole cities that cannot be attacked.

Example: Make the starting town center indestructible.  (Note that this will mean that players cannot be defeated)
create_object TOWN_CENTER {
set_place_for_every_player
max_distance_to_players 0
make_indestructible
}
min_distance_to_players  Distance
max_distance_to_players  Distance
Game versions: All
Arguments:
Distance - number (default: no limits)
If max is negative, no limits apply
If min exceeds max, no objects are placed

Minimum and maximum distance (in tiles) from the origin of player lands, that the object can be placed.
It is not necessary to specify both attributes.
Distances are a square, not a circle, unless set_circular_placement is specified.
If the objects are grouped, distance refers to the center of the group, not the individual group members.
When used with place_on_specific_land_id, distances refer to that specific land.
When used without set_place_for_every_player or place_on_specific_land_id, maximum distance has no effect.
BUG (DE): When used with set_place_for_every_player or place_on_specific_land_id, minimum distance applies to ALL lands, not just player lands (or the specific ID).  If your map has too many non-player lands to effectively use min_distance_to_players, an alternative is to create an actor_area of the desired radius (or several of different radii) on the player lands and then have the objects avoid that actor area.FIXED in April 2025!
BUG:  If distances are very constrained (ie. min=max), objects are noticeably biased towards being placed in the west (ie. starting villagers).
BUG (pre-DE): minimum distance ALWAYS applies to ALL lands.

Example: Place the starting scout at a distance of 7-9 tiles.
<OBJECTS_GENERATION>
create_object SCOUT {
set_place_for_every_player
min_distance_to_players 7
max_distance_to_players 9
}
set_circular_placement
Game versions: DE only

Changes min_distance_to_players and max_distance_to_players to use the circular (Euclidean) distance, rather than a square radius.  This prevents resources on the diagonal from being very far away.
This probably should be used for most player objects to improve resource spawns, unless walls are present (since walls are traditionally square).
Additionally, if used for a group of objects with set_loose_grouping, the area of group_placement_radius will be a circle instead of a square.

Example: Use circular placement on the distances for player sheep spawns.
<OBJECTS_GENERATION>
create_object SHEEP {
number_of_objects 2
number_of_groups 2
set_gaia_object_only
set_place_for_every_player
min_distance_to_players 18
max_distance_to_players 23
set_circular_placement
}
terrain_to_place_on  TerrainType
Game versions: All
Arguments:
TerrainType - terrain constant (see: Terrains) (default: any valid terrain)

The object(s) will only be placed on the specified terrain.

Example: Place decorative rocks on a central desert.
<LAND_GENERATION>
create_land {
terrain_type DESERT
number_of_tiles 500
land_position 50 50
}
<OBJECTS_GENERATION>
create_object ROCK {
number_of_objects 300
terrain_to_place_on DESERT
}
layer_to_place_on  TerrainType
Game versions: DE only
Arguments:
TerrainType - terrain constant (see: Terrains) (default: any layer)

The object(s) will only be placed on the specified layering terrain.
Works for terrain_mask 1, but not when set to 2.  In that case you must use terrain_to_place_on instead, because the layer has become the main terrain.
If used together with terrain_to_place_on, the object(s) will be placed only where both the base terrain and the layer apply.

Example: Place rocks on a small patch of layered snow within a larger desert area.
<LAND_GENERATION>
create_land {
terrain_type DESERT
number_of_tiles 500
land_position 50 50
}
<TERRAIN_GENERATION>
create_terrain SNOW {
    base_terrain DESERT
    number_of_tiles 20
    terrain_mask 1
}
<OBJECTS_GENERATION>
create_object ROCK {
number_of_objects 300
layer_to_place_on DESERT
}
ignore_terrain_restrictions
Game versions: DE only
Requires: set_place_for_every_player or place_on_specific_land_id

Objects can be placed on terrains they are normally restricted from, and these terrains no longer constitute a border on their placement.  Must be used with set_place_for_every_player or set_place_on_specific_land_id.
Can be used in combination with terrain_to_place_on
You can instead modify ATTR_TERRAIN_ID with effect_amount to change the terrain restrictions of any object, or use second_object with a placeholder.

Example: Place salmon on the land near each player's town center.  (Fish are can normally only be placed on water terrains)
create_object SALMON {
number_of_objects 4
set_place_for_every_player
min_distance_to_players 3
set_gaia_object_only
find_closest
ignore_terrain_restrictions
}
max_distance_to_other_zones  Distance
Game versions: All
Arguments:
Distance - number (default: 0)

Minimum (NOT maximum) distance, in tiles, that objects will stay away from terrains that they are restricted from being placed on.
Useful for keeping resources away from coastlines, or deep fish away from beaches.
If the objects are grouped, distance refers to the center of the group, not the individual members.
Does not apply to road terrains, even though resources cannot be placed on them.
Useless for objects without any terrain restrictions.
For large values, some objects may not respect the specified distance all of the time.

Example: Place a central lake and then fill the map with gold that avoids being close to water.
<LAND_GENERATION>
create_land {
terrain_type WATER
number_of_tiles 500
land_position 50 50
}
<OBJECTS_GENERATION>
create_object GOLD {
number_of_groups 9000
set_gaia_object_only
max_distance_to_other_zones 5
}
place_on_forest_zone
Game versions: DE only
Mutually exclusive with: avoid_forest_zone
External reference: Official DE Documentation

Place objects only on, and directly next to, tiles with trees on them (including straggler trees and scenario editor trees).

Example: Place sheep all along the edge of forests.
<OBJECTS_GENERATION>
create_object SHEEP {
number_of_objects 99999
place_on_forest_zone
}
avoid_forest_zone  Distance
Game versions: DE only
Mutually exclusive with: place_on_forest_zone
External reference: Official DE Documentation
Arguments:
Distance - number (default: no avoidance)
Defaults to 1 if you specify the argument but omit the distance.

Objects will stay the specified number of tiles away from any trees (including straggler trees and scenario editor trees)
Used to keep resources away from forests.
Note that the forest trees themselves are being avoided, so for sparse forests (especially baobab) larger distances may be necessary.
If the objects are grouped, distance will apply to the individual group members.

Example: Fill the map with gold, except for the areas near trees.
<OBJECTS_GENERATION>
create_object GOLD {
number_of_groups 99999
avoid_forest_zone 3
}
avoid_cliff_zone  Distance
Game versions: DE only
Arguments:
Distance - number (default: no avoidance)
Defaults to 1 if you specify the argument but omit the distance.

Objects will stay the specified number of tiles away from cliffs.  Note that because of the size of the cliff objects, you need to specify at least a distance of 2 to actually create a gap between the cliffs and the object(s).
Useful for preventing inaccessible resources.
If the objects are grouped, distance will apply to the individual group members.

Example: Fill the map with stone that stays 3 tiles away from cliffs.
<CLIFF_GENERATION>
<OBJECTS_GENERATION>
create_object STONE {
number_of_groups 99999
avoid_cliff_zone 4
}
min_distance_to_map_edge  Distance
Game versions: DE only
Arguments:
Distance - number (default: 0)

Minimum distance, in tiles, that objects will stay away from the edge of the map.
If the objects are grouped, distance refers to the center of the group, not the individual members.

Example: Ensure that relics stay at least 10 tiles from the edge of the map.
<OBJECTS_GENERATION>
create_object RELIC {
set_gaia_object_only
number_of_objects 500
min_distance_to_map_edge 10
}
min_distance_group_placement  Distance
Game versions: All
Arguments:
Distance - number (default: 0)

Minimum distance, in tiles, that individual objects of the same create_object command, and ALL future objects, must stay away from each object.
Best used with small values, to keep different resources from being directly next to each other.
To scatter objects from the same command far away from each other, use temp_min_distance_group_placement 
If the objects are grouped, distance refers to the center of the group, not the individual members.

Example: Give each player two sets of forages and make them avoid each other by 4 tiles, and keep all future objects 4 tiles away.
<OBJECTS_GENERATION>
create_object FORAGE {
number_of_objects 7
number_of_groups 2
set_tight_grouping
set_place_for_every_player
set_gaia_object_only
min_distance_to_players 8
max_distance_to_players 10
min_distance_group_placement 4
}
temp_min_distance_group_placement  Distance
Game versions: All
Arguments:
Distance - number (default: 0)

Like min_distance_group_placement, but only applies to the current create_object command - future objects are unaffected.
Useful for scattering objects, for example neutral resources and relics.
Can be used together with min_distance_group_placement
If the objects are grouped, distance refers to the center of the group, not the individual members.

Example: Scatter neutral gold evenly across the map.
<OBJECTS_GENERATION>
create_object GOLD {
number_of_groups 9320
number_of_objects 4
set_gaia_object_only
set_tight_grouping
min_distance_group_placement 4
temp_min_distance_group_placement 46
}
find_closest
Game versions: DE only
Requires: set_place_for_every_player or place_on_specific_land_id
External reference: Official DE Documentation

Place the object on the closest free tile to the center of the land, taking into consideration all other constraints.
IMPORTANT: find_closest uses the circular (Euclidean) distance, while all other distance constraints (ie. min_distance_to_players) use a square distance by default.
As a result, using both find_closest and min_distance_to_players (without further constraints) will often place objects at 90° to each other because the corners of the square are further from the center than the edges.  Use set_circular_placement combined with enable_tile_shuffling to solve this issue.
Bug: When using find_closest in reference to a land origin, previously that would place the object directly on the origin (assuming no other restrictions), but now it places it one tile away.  Use max_distance_to_players 0 if you need the object right on the origin.

Example: Give each player a fishing ship on the closest free water tile.
<OBJECTS_GENERATION>
create_object FISHING_SHIP {
set_place_for_every_player
ignore_terrain_restrictions
terrain_to_place_on WATER
find_closest
}
find_closest_to_map_center
Game versions: DE only
Requires: set_place_for_every_player or place_on_specific_land_id

Place the object on the closest free tile to the center of the map, taking into consideration all other constraints.
Overridden by find_closest
Bug: When using find_closest_to_map_center for loosely grouped objects, some group members may fail to spawn if the closest free area is too small.  Detailed bug description

Example: Place a boar in the map center for each player.
<OBJECTS_GENERATION>
create_object BOAR {
set_place_for_every_player
set_gaia_object_only
find_closest_to_map_center
}
find_closest_to_map_edge
Game versions: DE only
Requires: set_place_for_every_player or place_on_specific_land_id

Place the object on the closest free tile to the edge of the map, taking into consideration all other constraints.
Overridden by find_closest and find_closest_to_map_center
Bug: When using find_closest_to_map_edge for loosely grouped objects, some group members may fail to spawn if the closest free area is too small.  Detailed bug description

Example: Place a relic on the map edge for each player.
<OBJECTS_GENERATION>
create_object RELIC {
set_place_for_every_player
set_gaia_object_only
find_closest_to_map_edge
}
enable_tile_shuffling
Game versions: DE only

Increases randomness of object positions by shuffling the list of candidate tiles rather than just using the first entry.
When using both find_closest and set_circular_placement, add this attribute to prevent objects from being in predictable positions.
Does not prevent the bias towards the west when min_distance_to_players and max_distance_to_players are close or equal.
Should NOT be used when attempting to place objects in a specific precise location (i.e. placing herdables or villagers under the town center.)

Example: Create 4 individual gold mines randomly positioned in a circle around players, with no bias towards any position.
<OBJECTS_GENERATION>
create_object GOLD {
set_place_for_every_player
set_gaia_object_only
number_of_objects 4
min_distance_to_players 12
set_circular_placement
find_closest
enable_tile_shuffling
}
require_path Deviation
Game versions: DE only
Requires: set_place_for_every_player or place_on_specific_land_id
Arguments:
Deviation - number (default: 0)
0 = indirect paths allowed
1 = only direct paths
>1 = more deviation from the direct path allowed

Objects with this attribute must have a path to the origin of their associated land.  Use this attribute to prevent player resources from being trapped in or behind forests.
No argument, or a value of 0 imposes no further restrictions beyond preventing a completely inaccessible location.
An argument of 1 means that the object must additionally have a mostly direct path to the origin.
Larger values allow paths that are less direct. Maximum effective value depends on how constricted the path is.
Walls (and gates) count as obstructing a path, so this attribute should not be used for objects outside of a player's walls on walled maps.

Example: Make sure a player boar isn't located behind nearby woodlines.
<OBJECTS_GENERATION>
create_object BOAR {
	set_place_for_every_player
	set_gaia_object_only
	require_path 1
	min_distance_to_players 16
	max_distance_to_players 22
}
force_placement
Game versions: DE only
External reference: Official DE Documentation

Allows multiple objects to be placed on the same tile at once, if necessary.  Normally, objects are placed one per tile, and if the tiles run out, no more objects are placed.  With force_placement active, when tiles run out, the remaining objects are placed on the corners of tiles, and then on top of each other.
Only works for objects that can overlap on the same tile (ie. units, but not buildings)
Disabled when using set_loose_grouping

Example: Place 50 sheep in the 1-tile radius surrounding a starting outpost.
<OBJECTS_GENERATION>
create_object OUTPOST {
set_place_for_every_player
max_distance_to_players 0
}
create_object SHEEP {
number_of_objects 50
set_place_for_every_player
max_distance_to_players 1
force_placement
}
actor_area  Identifier
Game versions: DE only
See also: create_actor_area
External reference: Official DE Documentation
Arguments:
Identifier - number (default: 0 - no actor area) 

Specifies a numerical identifier which can be referred to in future objects with avoid_actor_area or actor_area_to_place_in

Example: Spawn a wolf next to each relic.
<OBJECTS_GENERATION>
create_object RELIC {
number_of_objects 5
set_gaia_object_only
temp_min_distance_group_placement 35
actor_area 1234
}
create_object WOLF {
number_of_objects 9320
set_gaia_object_only
actor_area_to_place_in 1234
temp_min_distance_group_placement 25
}
actor_area_radius  Radius
Game versions: DE only
Requires: actor_area
External reference: Official DE Documentation
Arguments:
Radius - number (default: 1 = 3x3 area)

Used with actor_area to specify how large it should be.
If you create several objects with the same actor_area, all of them will share the radius of the first object successfully created.

Example: Give each player a mill with 7 deer in a 7-tile radius.
<OBJECTS_GENERATION>
create_object MILL {
set_place_for_every_player
min_distance_to_players 16
max_distance_to_players 20
actor_area 61
actor_area_radius 7
}
create_object DEER {
number_of_objects 7
set_place_for_every_player
set_gaia_object_only
actor_area_to_place_in 61
}
override_actor_radius_if_required
Game versions: DE only
Requires: actor_area_to_place_in

Prevents buildings from overlapping when placed in an actor_area with a radius that is too small to contain them, by expanding the valid placement area outwards.
Used in the official maps for mills in Empire Wars to ensure they are placed properly when they become folwarks for the Poles civilization.
Does not seem to work on units.

Example: Place a barracks with the default actor_area_radius of 1, and then place a house adjacent, and prevent it from overlapping the barracks.
<OBJECTS_GENERATION>
create_object BARRACKS {
    set_place_for_every_player
    find_closest
    actor_area 2
}
create_object HOUSE {
    set_place_for_every_player
    actor_area_to_place_in 2
    override_actor_radius_if_required
}
actor_area_to_place_in  Identifier
Game versions: DE only
External reference: Official DE Documentation
Arguments:
Identifier - number

Place the object only within the radius of the specified actor_area or create_actor_area
The same object can only have one actor_area_to_place_in.
Actor areas have some intricacies that can affect placement.  If you are having issues, follow these guidelines:
Different objects can be assigned to the same actor area
Do not place origin-referenced (either player or land id) objects in generic actor areas
Placing generic objects into land id-referenced actor areas always works
Placing player objects into land id-referenced actor areas always works
Only player objects should be placed into player-referenced actor areas
When placing generic objects in generic actor areas, try to have the fewest create object commands possible between the actor area creation and the object to be placed in it.
When none of the rules can be satisfied, inverse actor areas can be used as a failsafe

Example: Place a lumber camp on the nearest forest and place villagers there too.
<OBJECTS_GENERATION>
create_object LUMBER_CAMP {
set_place_for_every_player
max_distance_to_players 67
place_on_forest_zone
find_closest
actor_area 8
actor_area_radius 4
}
create_object VILLAGER {
set_place_for_every_player
number_of_objects 4
actor_area_to_place_in 8
place_on_forest_zone
find_closest
}
avoid_actor_area  Identifier
Game versions: DE only
External reference: Official DE Documentation
Arguments:
Identifier - number

The object will avoid the specified actor_area or create_actor_area
The same object can avoid multiple actor areas.
You can specify an actor_area and then avoid that same actor area within the same generate_object statement.  However, this only works with ungrouped objects, or those with set_loose_grouping 

Example: Place a barracks for empire wars but have it avoid various other objects that you already placed.
<OBJECTS_GENERATION>
create_object BARRACKS {
set_place_for_every_player
min_distance_to_players 7
max_distance_to_players 9
avoid_actor_area 94
avoid_actor_area 40
avoid_actor_area 8
avoid_actor_area 9
avoid_actor_area 99
avoid_actor_area 171
actor_area 51
actor_area_radius 5
}
avoid_all_actor_areas
Game versions: DE only
External reference: Official DE Documentation

The object will avoid being placed within ANY existing actor_area or create_actor_area

Example: Place wolves that avoid all actor areas.
<OBJECTS_GENERATION>
create_object TOWN_CENTER {
set_place_for_every_player
max_distance_to_players 0
actor_area 100
actor_area_radius 60
}
create_object WOLF {
number_of_objects 9320
temp_min_distance_group_placement 52
avoid_all_actor_areas
}
set_facet FacetNumber
Game versions: DE only
Arguments:
FacetNumber - number (default: 0 - random facet)
FacetNumber corresponds to the index - 1 of the desired frame in the sprite.
To get the first frame, pick a facet number below 0, or above the maximum for that object.

Choose which frame (of the sprite) of an object to generate.
For units, this corresponds to the angle they are facing.
For other objects, this may correspond to alternative appearances.
Facets can be cycled by using the rotate feature in the scenario editor.
Frames can be viewed using external tools such as SLX Studio.

Example: Generate 10 jungle straggler trees that all look identical and have the appearance of frame n_tree_jungle_x1_031 (a large and small palm tree)
create_object JUNGLETREE {
    number_of_objects 10
    set_facet 30
}
match_player_civ
Game versions: Star Wars Galactic Battlegrounds only!!!

Used to ensure that each faction gets their correct starting scout unit.
With the exception of this attribute, SWGB uses the same commands and attributes that are available in AoC.
Usually used for the starting scout, but also works for other units such as unique units from the fortress.


Global Syntax
There are some additional pieces of syntax that can be used across all sections.
Comments
A comment is a piece of text that is ignored by the parser, but provides helpful information to someone looking at the code, such as yourself.
Comments can be nested.  If you have a comment within a comment, the "sub comment" will not prematurely terminate the main comment, even if syntax highlighters indicate elsewise.
Make sure to always include a separator between the comment character and the comment text.  This is a common mistake, and many syntax highlighters will not properly recognize broken comments.
BUG (pre-DE): Comments within dead branches (see: Conditionals and Random Code) are NOT ignored.  For more information, see this external article: Parser Pitfalls

Examples: Working comments
/* this is a comment */
/*
this is a comment
*/
/* this is a
multi-line comment
*/
/* /* this is a nested */ comment */
Example: Broken comments
// this is NOT a comment
#this is NOT a comment
```this is NOT a comment```
/*this is NOT a comment*/
/*** this is NOT a comment ***/
/* this comment never ends
/* this comment never ends*/
/* this comment never ends */*

Including Other Files
The standard maps include shared files for the resource generation.
In AoC/UP this is found within the gamedata_x1.drs file.  You can open the drs file with any text editor and look for the relevant part.
In vanilla HD you can find the land_resources.inc file in the gamedata_x1 folder.
In DE you can find the GeneratingObjects.inc file in the gamedata_x2 folder.  Additionally you can find shared files for seasons, elevation, animals, water mixing, etc.
The file random_map.def is always included, without having to specify it.  It contains all the predefined constants.
VERY IMPORTANT:  Included rms files are NOT transferred in the lobby!  This means:
You CAN include any of the standard files that are part of the game, because other players will already have them in their directory.
You CANNOT include custom files, unless everyone in the lobby has the file.  So you can include custom files with full conversion mods, because all players will need to have the mod to be able to play in the first place.
#include_drs  Filename
Game versions: HD/DE (in AoC it is used for the built-in maps, but doesn't seem to work for custom maps)
Arguments:
Filename - name (or path and name)
Valid file extensions are: rms, rms2, inc, def
You can navigate to a parent directory with ../
If your path or filename contains spaces, you can surround it with quotation marks: "this is the/path to/example file name.rms"

Include a file located in the gamedata folder.
If you include a file somewhere else, the file path must be relative to the gamedata folder.

Example: Include the DE seasons file, so that you can use it in your own script, without having to set up your own terrains.
#include_drs F_seasons.inc

Example2: Include that classic land and water resources file from AoC.
<OBJECTS_GENERATION>
#include_drs land_and_water_resources.inc

Example3: Make a custom version of blind random.
start_random
percent_chance 20	#include_drs Arabia.rms
percent_chance 20	#include_drs Baltic.rms
percent_chance 20	#include_drs Gold_Rush.rms
percent_chance 20	#include_drs Islands.rms
percent_chance 20	#include_drs Team_Islands.rms
end_random
#includeXS  Filename
Game versions: DE only
External reference: .xs scripting in Age of Empires II: Definitive Edition, XS Scripting For Beginners
Arguments:
Filename - name (or path and name)
Valid file extensions are: xs
You can navigate to a parent directory with ../
BUG:  You cannot surround your path with quotation marks

Include an xs file, located in the xs folder.
If you include a file somewhere else, the file path must be relative to the xs folder.
The path can also be relative to the xs folder in player profile, rather than to the xs folder in the main game directory.
Unlike included rms files, included XS files DO transfer automatically to players and spectators.

Examples: XS Scripting For Beginners

Random Code
Can be used just about anywhere to add an element of randomness to your script.
start_random
percent_chance  %  Code
end_random
Game versions: All
Arguments: 
% - number (0-99)
Code - anything

Specify a piece of code that has a defined chance of being chosen.
If the total percentages add up to less than 99%, there is a chance that none of them get chosen.
If the total exceeds 99%, only the first 99% will have a chance of occurring.
Random constructs can encompass individual arguments, or even whole blocks of code.
They cannot be nested.  To achieve a non-integer chance, use a first random block to define (using #define) which additional random block to run.
BUG: if the first branch is percent_chance 0, it is still chosen occasionally.  Do not include a percent_chance 0 as the first branch.  Also note that the 100th percent is never chosen.
BUG (AoC/HD/UP): Comments in dead branches are not ignored.  Do not include any random syntax (ie. end_random) in such comments.  For more information, see this external article: Parser Pitfalls

Example:  Place 5 or 6 or 7 gold mines with 6 being the most likely.
<OBJECTS_GENERATION>
create_object GOLD {
start_random
percent_chance 30	number_of_objects 5
percent_chance 50	number_of_objects 6
percent_chance 20	number_of_objects 7
end_random
}

Example2:  Have a 10% chance of placing 5 gold mines (and a 90% of not doing so)
<OBJECTS_GENERATION>
start_random
percent_chance 10
create_object GOLD {
number_of_objects 5
}
end_random
rnd(min,max)
Game versions: UP/DE
External reference: UserPatch Reference
Arguments: 
min - number
max - number

Randomize a numeric argument between min and max (inclusive).
Make sure there are no spaces in the whole construct.
Make sure max exceeds min.
Cannot be used within math operations.

Example:  Place 5 or 6 or 7 gold piles, and randomly change the amount of gold (it will be the same amount in all of them)
<OBJECTS_GENERATION>
create_object GOLD {
number_of_objects rnd(5,7)
resource_delta rnd(-200,300)
}

Conditionals
Conditionals are pieces of code that will be executed based on whether a specified condition is fulfilled.  The game has predefined most lobby settings as conditions.  Below is the full set of conditions available.

Game modes:
DEATH_MATCH
REGICIDE
CAPTURE_THE_RELIC		(HD/DE only)
CAPTURE_RELICS		(UP only)
RANDOM_MAP		(UP/DE only)
TURBO_RANDOM_MAP		(UP/DE only) (game mode: random map + the "turbo mode" tickbox)
KING_OT_HILL		(UP/DE only) (note that KING_OF_THE_HILL is a map type, and is always true!)
WONDER_RACE		(UP/DE only)
DEFEND_WONDER		(UP/DE only)
EMPIRE_WARS		(DE only)
BATTLE_ROYALE		(DE only)
SUDDEN_DEATH		(DE only)

Map sizes (legacy):  (see also: Map Sizes for scaling and dimensions)
TINY_MAP  
SMALL_MAP
MEDIUM_MAP
LARGE_MAP		(Normal - 6 player)
HUGE_MAP		(Large - 8 player)
GIGANTIC_MAP
LUDIKRIS_MAP

Map sizes (modern):  (DE only) (see also: Map Sizes for scaling and dimensions)
MAPSIZE_MINI
MAPSIZE_TINY
MAPSIZE_SMALL
MAPSIZE_MEDIUM
MAPSIZE_NORMAL
MAPSIZE_LARGE
MAPSIZE_HUGE
MAPSIZE_GIANT
MAPSIZE_MASSIVE
MAPSIZE_ENORMOUS
MAPSIZE_COLOSSAL
MAPSIZE_INCREDIBLE
MAPSIZE_MONSTROUS
MAPSIZE_LUDICROUS

Starting resources:
HIGH_RESOURCES
MEDIUM_RESOURCES
LOW_RESOURCES		(same as default resources in AoE2; different in RoR)
DEFAULT_RESOURCES		(same as low resources)
INFINITE_RESOURCES		(DE only)
RANDOM_RESOURCES		(DE only)

Starting age:  (DE only)
DARK_AGE_START
FEUDAL_AGE_START
CASTLE_AGE_START
IMPERIAL_AGE_START
POST_IMPERIAL_AGE_START

Additional lobby settings:
FIXED_POSITIONS		(the "team together" tick box)
TURBO_MODE		(DE only)
TEAM_POSITIONS		(DE only)
FULL_TECH_TREE		(DE only)
AI_PLAYERS		(DE only) (detect if AI players are present)
SOLID_FARMS		(DE only) (the "solid farms" tick box in AoE1) 
ANTIQUITY_MODE	(DE only) (the "antiquity mode" checkbox in the lobby)

Player count:  (UP/DE only)
1_PLAYER_GAME
2_PLAYER_GAME
3_PLAYER_GAME
4_PLAYER_GAME
5_PLAYER_GAME
6_PLAYER_GAME
7_PLAYER_GAME
8_PLAYER_GAME

Team count:  (UP/DE only) (a team is only detected if at least 2 players are on the same team)
0_TEAM_GAME
1_TEAM_GAME
2_TEAM_GAME
3_TEAM_GAME
4_TEAM_GAME

Team size:  (UP/DE only) (team number refers to lobby order, not the selected team number)
TEAM0_SIZE0
TEAM0_SIZE1
TEAM0_SIZE2
TEAM0_SIZE3
TEAM0_SIZE4
TEAM0_SIZE5
TEAM0_SIZE6
TEAM0_SIZE7
TEAM0_SIZE8
TEAM1_SIZE0
TEAM1_SIZE2
TEAM1_SIZE3
TEAM1_SIZE4
TEAM1_SIZE5
TEAM1_SIZE6
TEAM1_SIZE7
TEAM1_SIZE8
TEAM2_SIZE0
TEAM2_SIZE2
TEAM2_SIZE3
TEAM2_SIZE4
TEAM2_SIZE5
TEAM2_SIZE6
TEAM3_SIZE0
TEAM3_SIZE2
TEAM3_SIZE3
TEAM3_SIZE4
TEAM4_SIZE0
TEAM4_SIZE2

Player-in-team:  (UP/DE only) (note that player and team numbers refer to lobby order, not selected number)
PLAYER1_TEAM0
PLAYER1_TEAM1
PLAYER1_TEAM2
PLAYER1_TEAM3
PLAYER1_TEAM4
PLAYER2_TEAM0
PLAYER2_TEAM1
PLAYER2_TEAM2
PLAYER2_TEAM3
PLAYER2_TEAM4
PLAYER3_TEAM0
PLAYER3_TEAM1
PLAYER3_TEAM2
PLAYER3_TEAM3
PLAYER3_TEAM4
PLAYER4_TEAM0
PLAYER4_TEAM1
PLAYER4_TEAM2
PLAYER4_TEAM3
PLAYER4_TEAM4
PLAYER5_TEAM0
PLAYER5_TEAM1
PLAYER5_TEAM2
PLAYER5_TEAM3
PLAYER5_TEAM4
PLAYER6_TEAM0
PLAYER6_TEAM1
PLAYER6_TEAM2
PLAYER6_TEAM3
PLAYER6_TEAM4
PLAYER7_TEAM0
PLAYER7_TEAM1
PLAYER7_TEAM2
PLAYER7_TEAM3
PLAYER7_TEAM4
PLAYER8_TEAM0
PLAYER8_TEAM1
PLAYER8_TEAM2
PLAYER8_TEAM3
PLAYER8_TEAM4

Game Versions:
UP_AVAILABLE		(detect UP 1.4+)
UP_EXTENSION		(detect UP 1.5)
DE_AVAILABLE		(detect DE)
DE_GAME_ROME		(detect DE running Return of Rome, ie. AOE1)
DE_GAME_AGE2		(detect DE running regular AoE2)

You can detect other game versions, as well as total conversion mods by exploiting differences in the predefined constants within random_map.def of the respective game versions.  (See example in the next section).
if  ConditionLabel  Code
elseif  ConditionLabel  Code
else
endif
Game versions: All
Arguments: 
ConditionLabel - either a predefined condition or a custom condition
Code - anything

Execute a piece of code if a condition is fulfilled, with the option of specifying alternative conditions and pieces of code to execute.
if is required and will execute the code if the condition is true, and will stop checking further conditions.
elseif is optional, and will be evaluated if the previous condition(s) were not true.  If true, no further conditions are checked.
elseif can be specified multiple times.
else is optional and will be executed if all other conditions fail.
endif is required to close a conditional 

Can be used within commands or around whole blocks of code.
Conditionals can be nested.
BUG (AoC/HD): Comments in dead branches are not ignored.  Do not include any conditional syntax in such comments.  Be especially careful with "if" since it is easy to inadvertently type it in a comment!  For more information, see this external article: Parser Pitfalls

Example:  Manually scale relic count to map size.
<OBJECTS_GENERATION>
create_object RELIC {
min_distance_to_players 25
if TINY_MAP
number_of_objects 5
temp_min_distance_group_placement 35
elseif SMALL_MAP
number_of_objects 5
temp_min_distance_group_placement 38
elseif MEDIUM_MAP
number_of_objects 5
temp_min_distance_group_placement 38
elseif LARGE_MAP
number_of_objects 7
temp_min_distance_group_placement 48
elseif HUGE_MAP
number_of_objects 8
temp_min_distance_group_placement 52
else
number_of_objects 999
temp_min_distance_group_placement 52
endif
}

Example2:  Replace the scout with a king when playing regicide.
<OBJECTS_GENERATION>
if REGICIDE    create_object KING
else    create_object SCOUT
endif
{
    set_place_for_every_player
    min_distance_to_players 7
    max_distance_to_players 9
}

Example3:  Set up a NOT conditional - place a cow when "infinite resources" is not true.
<OBJECTS_GENERATION>
if INFINITE_RESOURCES
else
create_object DLC_COW {
set_place_for_every_player
find_closest
}
endif

Example4:  Check for various game versions.
if DE_AVAILABLE
elseif DLC_TIGER /* present only in HD+DLC and in WK */    
    if UP_EXTENSION #define WOLOLOKINGDOMS
    else #define HD_DLC
    endif    
elseif DLC_COW #define HD_BASE /* present in HD base random_map.def - even though it is a DLC object */   
elseif UP_EXTENSION  
elseif UP_AVAILABLE   
else #define CONQUERORS_CD /* by process of elimination */    
endif
#define  ConditionLabel
Game versions: All
Arguments: 
ConditionLabel - text
AoC/UP - max length is 99 characters
ANY characters are valid; convention is to use uppercase letters and underscores

Define your own condition labels, to refer to at a later point.
Do not use any predefined constants.

Example:  Set up seasonal variations for the base terrain.
start_random
    percent_chance 20    #define WINTER
    percent_chance 20    #define AUTUMN
end_random
<LAND_GENERATION>
if WINTER    base_terrain SNOW
elseif    AUTUMN    base_terrain LEAVES
else    base_terrain DIRT3
endif

Constants
Everything in the game is represented internally by a numeric identifier.  A constant is a label that can be used to refer the random map parser to the right item.  Many useful objects and terrains have predefined constants (see: Constant Reference). However, many objects and terrains also lack a predefined name.  In order to use them in your script, you must first assign a constant to the numeric id.
#const  Constant  Identifier
Game versions: All
Arguments: 
Constant - text
AoC/UP - max length is 99 characters
ANY characters are valid; convention is to use uppercase letters and underscores
Identifier - number (see: Constant Reference)
 Maximum: 16777216 (2^24)

Assign a label of your choice to a numeric ID, to be able to use the terrain/object associated with that ID.
This is required to use anything that is not predefined.
Items can have multiple constants assigned to them.
You cannot re-define a predefined name to a different ID.
DE: You can use #const as a way to define a number. See Math Operations. This WILL work:
#const NUM 10 …. number_of_objects NUM
Pre-DE: You cannot use #const as a way to define a number. This will NOT work:
#const NUM 10 …. number_of_objects NUM
Constants are interpreted in context (ie. after create_object the game will interpret it as an object, while after create_terrain the game will interpret it as a terrain)
WARNING: Constants without a proper context are interpreted as syntax.  For more information, see this external article: Parser Pitfalls

Example:  Define mossy road so you can use it later.
#const ROAD_FUNGUS 39

Example2:  Define and use variable constants depending on the season.
start_random
percent_chance 30 #define WINTER
percent_chance 30 #define AUTUMN
end_random
if WINTER
#const LAND_A 32 /* snow */
#const BERRY_TYPE 59 /* berry bush */
elseif AUTUMN
#const LAND_A 5 /* leaves */
#const BERRY_TYPE 59 /* berry bush */
else
#const LAND_A 3 /* dirt 3 */
#const BERRY_TYPE 1059 /* orange bush */
endif
<LAND_GENERATION>
create_player_lands { terrain_type LAND_A }
<OBJECTS_GENERATION>
create_object BERRY_TYPE {
number_of_objects 5
set_place_for_every_player
set_gaia_object_only
find_closest
terrain_to_place_on LAND_A
}
Math Operations
Math operations were added to DE in April 2025 and are not available in earlier versions of the game. Numbers can now be saved with #const, and constants will be interpreted as their numeric value when inside a math operation.  Addition, subtraction, multiplication and division can be performed.
The following operators are known to be available: + - * / %
Operators require spaces.
Math must be contained within parentheses.
Numbers and constants must not have spaces to the bounding parentheses.
Operations are simply processed left to right.
Nesting with further parentheses is not possible.
Rounding (only) occurs once a float is passed to an attribute that only accepts integers.
0.5 rounds up.
Pre-defined constants will be interpreted as numbers if inside the parentheses, or if used where numeric inputs are expected.
Once defined with #const, the constant cannot be re-defined or changed.
rnd(min,max) cannot be used inside an operation, but it can be used with #const.
Math operations can be used almost anywhere a numeric input is accepted.
Negative numbers can be used.
Constants above 16777216 (2^24) are not stored accurately.
Dividing by 0 gives 0.  Modulo 0 also gives 0.
% (modulo) works by casting both operands to integer (basically a floor), performs the modulo operation, then casts the result back to float.
inf and -inf are natively supported and can be used to floor a value by doing something like #const VAL (5.9 % -inf) /*5 */ or #const VAL (-5.9 % -inf + 10) /*5 */

Example: basic math
<OBJECTS_GENERATION>
#const A 2
#const B 3
#const RELIC_COUNT (1 + 2)	/* 3 */
#const GOLD_COUNT (B * A)	/* 6 */
#const STONE_COUNT (GOLD_COUNT - RELIC_COUNT * 2 + 1 / 2) /* 3.5 */
#const RAND rnd(1,6)
create_object RELIC {
	set_gaia_object_only
	number_of_objects RELIC_COUNT
}
create_object GOLD {
	set_gaia_object_only
	number_of_objects (GOLD_COUNT + (5 + 2)) /* gives 8 because the (5 is not seen as a number */
}
create_object STONE {
	set_gaia_object_only
	number_of_objects (STONE_COUNT * 1.9) /* 3.5*1.8 = 6.65 rounding to 7 because number_of_objects requires an integer */
}
create_object FORAGE {
	set_gaia_object_only
	number_of_objects (SKIRMISHER - DIRT3) /* 7-3 = 4 */
}
create_object HOUSE {
	set_place_for_every_player
	number_of_objects (RAND)	/* parentheses optional here */
}
Example2: naming actor areas
<OBJECTS_GENERATION>
#const AA_CENTER 1
#const AA_CENTER_RADIUS 12
create_actor_area 50 50 AA_CENTER AA_CENTER_RADIUS
create_object RELIC { 
    set_gaia_object_only
    number_of_objects 3
    actor_area_to_place_in AA_CENTER
}
Example3: Scale both the number of tiles and number of clumps of elevation
<ELEVATION_GENERATION>
if MAPSIZE_LUDICROUS #const LENGTH 480
elseif MAPSIZE_MONSTROUS #const LENGTH 400
elseif MAPSIZE_INCREDIBLE #const LENGTH 360
elseif MAPSIZE_INCREDIBLE #const LENGTH 360
elseif MAPSIZE_INCREDIBLE #const LENGTH 360
elseif MAPSIZE_COLOSSAL	 #const LENGTH 320
elseif MAPSIZE_ENORMOUS #const LENGTH 300
elseif MAPSIZE_MASSIVE #const LENGTH 276
elseif MAPSIZE_GIANT #const LENGTH 252
elseif MAPSIZE_HUGE #const LENGTH 240
elseif MAPSIZE_LARGE #const LENGTH 220
elseif MAPSIZE_NORMAL #const LENGTH 200
elseif MAPSIZE_MEDIUM #const LENGTH 168
elseif MAPSIZE_SMALL #const LENGTH 144
elseif MAPSIZE_TINY #const LENGTH 120
elseif MAPSIZE_MINI	 #const LENGTH 80
endif
create_elevation 7 {
	base_terrain GRASS
	set_scale_by_size	/* scales tile count */
	number_of_tiles 1200
	number_of_clumps (LENGTH * 2 / 10)
	enable_balanced_elevation
}
Map Sizes
Scaling uses map area, not side length.  Scaling of elevation (set_scale_by_size / set_scale_by_groups), terrains (set_scale_by_size / set_scale_by_groups), and objects (set_scaling_to_map_size) use a 100x100 = 10000 tile reference.  This is smaller than the tiny map size.  Multiply your chosen number by the area ratio listed for a given map size to determine how many tiles/clumps/objects will be generated. 
Note there are some discrepancies regarding the naming of the sizes, particularly regarding normal, large, huge and giant (see table below).
When scaling to/by map size, the maximum number you should use is 9320, otherwise the scaling will fail on Ludicrous size.
Map dimensions can be adjusted using override_map_size, in which case any scaling will use the new map area.
As of March 2024, DE has added additional sizes.  These are accessible in the lobby and scenario editor to players who use the launch option MORE_MAP_SIZES
New rms conditionals have been added for the new sizes as well as all existing sizes to standardize the nomenclature.
Most maps will need updates if they are to fully function on the new sizes.
The legacy RMS conditionals continue to work as expected, so there is no need to update maps unless support for the new sizes is desired.

Size (in-game description)
Size (legacy)
Size (modern)
Dimensions
Area
Area ratio to 100x100
Miniature (1 player)*
-
MAPSIZE_MINI
80x80
6400
0.6
Tiny (2 player)
TINY_MAP
MAPSIZE_TINY
120x120
14400
1.4
Small (3 player)
SMALL_MAP
MAPSIZE_SMALL
144x144
20736
2.1
Medium (4 player)
MEDIUM_MAP
MAPSIZE_MEDIUM
168x168
28224
2.8
Normal (6 player)
LARGE_MAP
MAPSIZE_NORMAL
200x200
40000
4.0
Large (8 player)
HUGE_MAP
MAPSIZE_LARGE
220x220
48400
4.8
Huge
GIGANTIC_MAP
MAPSIZE_HUGE
240x240
57600
5.8
Giant*
-
MAPSIZE_GIANT
252x252
63504
6.4
Massive*
-
MAPSIZE_MASSIVE
276x276
76176
7.6
Enormous*
-
MAPSIZE_ENORMOUS
300x300
90000
9.0
Colossal*
-
MAPSIZE_COLOSSAL
320x320
102400
10.2
Incredible*
-
MAPSIZE_INCREDIBLE
360x360
129600
13.0
Monstrous*
-
MAPSIZE_MONSTROUS
400x400
160000
16.0
Ludicrous
LUDIKRIS_MAP
MAPSIZE_LUDICROUS
480x480
230400
23.0

* only selectable in game if the MORE_MAP_SIZES launch option has been used.
Walls
When placing walls with set_place_for_every_player it is not necessary to specify number_of_objects 
All that is needed is min_distance_to_players and max_distance_to_players - set both of these to the same value to get square walls.
Without max_distance_to_players walls will fail to generate
If a radius is allowed to vary, the wall will preferentially attempt to link up with forests.
BUG: If radius varies, the wall may have gaps next to vertical diagonal gates.
Gates are automatically placed on each segment.
Make sure to place at least one player object (normally the town center) first before the walls, otherwise the walls will be buggy and centered around the middle of the map.
Walls do not work properly if the players are completely separated by water.
Walls may not work properly if everyone is on the same team
Walls ignore terrain_to_place_on
BUG: walls sometimes randomly have gaps when generating in the scenario editor.  This only occurs in the scenario editor.
The main wall types are:
PALISADE_WALL
WALL, STONE_WALL
FORTIFIED_WALL 
Additional wall types are:
DLC_FORTIFIED_PALISADE_WALL (500 HP)
(City Wall - ID 320) (3200 HP)
(Aqueduct - ID 231) (1600 HP; does not take extra anti-building damage)
DLC_FENCE (only 1 HP)
(Sea Wall - ID 788) (300 HP)

Example: Place a stone wall around players with a radius of 15
create_object WALL {
	set_place_for_every_player
	min_distance_to_players 15
	max_distance_to_players 15
}

Constant Reference
All constants that are predefined by the game can be found in random_map.def
You can find that file in the same location as the standard maps.  That would be the gamedata_x2 folder for DE/HD, and within the gamedata_x1.drs file for AoC/WK.  random_map.def is automatically included in all maps, so anything that is defined there can be used in your map, without first having to define it yourself.  It includes most of the common objects and many of the terrains.
Anything not listed there must first be defined with #const before you can use it.
Advanced Genie Editor
Advanced Genie editor is a tool used to view and edit the gamedata file and to make data mods.  It is useful for random map scripting, because you can use it to view all the terrains and objects by ID and also look up their properties.
In DE, you can find it in AoE2DE\Tools_Builds
Alternatively, you can also manually download the most recent version.
A good external guide to using it can be found HERE
And a good overview of the things you can modify HERE

After setting up all your file paths properly, you should be able to load the gamedata file.  The amount of information you get can be overwhelming, so just head over to the Terrains tab or the Units tab.  The main thing that will be useful is the list on the left.  Unfortunately, in DE, the graphics will not be displayed, but in AoC/UP/HD you can see the graphics in a separate window.  Everything that you see listed is a thing that you can potentially use if you define it with #const


The Units tab
The Terrains tab

Terrains
I have created a spreadsheet detailing all the terrains, their graphics, and their names in the various scenario editors.
AoE2 Terrains Spreadsheet
If a terrain lacks a predefined constant name, you must define one yourself (with #const).
If you want to use non-standard beaches, check out this guide: Custom Beaches or use beach_terrain
You can make custom forests by upgrading trees; check out this guide: creating new forest-types using User-Patch
You can generate unused or moddable terrains.  They make great placeholders but are otherwise not useful unless you are making a data mod or total conversion which adds additional terrain graphics.  
Added ATTR_TRAIN_LOCATIONS_ENTRY_MOD and ATTR_TRAIN_LOCATIONS_TOTAL_NUM
Minimap Colors
Terrains use a limited set of colors on the minimap.  They are shown on the spreadsheet.
Grass terrains (and snow terrains since AoC patch 1.0c) are green.
Dirt terrains and road terrains are light brown.
Beach terrains and desert terrains are an even lighter beige.
Forest terrains are dark green.
Water terrains are blue, with deeper water being a darker blue.
Ice terrains are very light blue.
Farms are an olive color.

Minimap Color Design Theory
In order to design a visually appealing minimap, look carefully at any cosmetic terrain mixing.  Larger clumps of dirt or grass against a backdrop of the other color can look alright, but many small or irregularly-sized clumps may look cluttered and diminish visual clarity on the minimap.
A useful approach on maps featuring base_elevation can be to highlight elevated areas and/or slopes with a different color (see Acropolis, Gold Rush, Golden Pit).  Remember that when using terrain_mask the terrain that is underneath will be the one that provides the properties (including the minimap color) to the final terrain mixture.
Objects
Definitive Constants List - the spreadsheet may have some typos.  Check out the sub sheets for a list of animals, trees and other resources.
You can also check out this website: https://halfon.aoe2.se/
Or use Advanced Genie Editor
Note that there are multiple versions of buildings (ie. for each age) - only the default version (the one with the standard predefined constant) will actually be functional (ie. able to train units) in-game.
Note that in DE, everything with an ID originally in the 900s has been duplicated into the 1300s and you should use the new IDs instead because AIs need the 900s for object class IDs.
UserPatch Constants
You can find the full list of UserPatch-specific constants in \Reference\Scripting\UserPatchConst.rms within your UserPatch install directory or online HERE
Note that in vanilla UP, these constants must be manually defined (with #const) before use, but they are predefined in DE (in the random_map.def file) and WK.
DE adds additional constants that were not present in UP and also no longer uses some constants that were present in UP.  The lists in the following sections are based on DE.
HD and CD versions of the game do not natively support any of these (unless running UP).
Effect Constants
Effect constants are used by effect_amount and effect percent to modify various things in the gamedata.
Gaia effects will apply only to gaia, and not to player objects.
When using set_gaia_civilization, gaia effects will no longer function on objects that can be player-controlled.

SET_ATTRIBUTE   	 /* Type: Attribute Const */
ADD_ATTRIBUTE   	 /* Type: Attribute Const */
MUL_ATTRIBUTE   	 /* Type: Attribute Const */
MOD_RESOURCE   	 /* Type: ATTR_SET or ATTR_ADD */
MUL_RESOURCE   	 /* Type: ATTR_DISABLE */
SET_TECH_COST   	 /* Type: ResourceAmount const */
ADD_TECH_COST   	 /* Type: ResourceAmount const */
MOD_TECH_TIME   	 /* Type: ATTR_SET or ATTR_ADD */
ENABLE_OBJECT   	 /* Type: ATTR_DISABLE or ATTR_ENABLE, Value: 0 */
UPGRADE_UNIT   	 /* Type: UnitId, Value: 0 */
DISABLE_TECH   	 /* Type: ATTR_DISABLE, Value: TechId */
SPAWN_UNIT		/* Type: BuildingId, Item: UnitId, Value: 0 */
MODIFY_TECH   	 /* Type: ModifyTech const */
SET_PLAYER_DATA   	 /* Type: ATTR_SET */

GAIA_SET_ATTRIBUTE
GAIA_ADD_ATTRIBUTE
GAIA_MUL_ATTRIBUTE
GAIA_MOD_RESOURCE
GAIA_MUL_RESOURCE
GAIA_SET_TECH_COST
GAIA_ADD_TECH_COST
GAIA_MOD_TECH_TIME
GAIA_ENABLE_OBJECT
GAIA_UPGRADE_UNIT
GAIA_DISABLE_TECH
GAIA_SPAWN_UNIT
GAIA_MODIFY_TECH
GAIA_SET_PLAYER_DATA
Effect Type Constants
Attribute constants are used by effect_amount and effect percent to modify various things in the gamedata.

ATTR_DISABLE
ATTR_ENABLE
ATTR_FORCE
ATTR_RESEARCH
ATTR_SET
ATTR_ADD
Attribute Constants
Attribute constants are used by effect_amount and effect percent to modify various object properties in the gamedata.  See this User Generated Content Guide or UP 1.5 Effects & How to use them in Maps or check in Advanced Genie Editor for more details on what these attributes do.

ATTR_HITPOINTS
ATTR_LINE_OF_SIGHT
ATTR_GARRISON_CAPACITY
ATTR_RADIUS_1   	 /* unit size X */
ATTR_RADIUS_2   	 /* unit size Y */
ATTR_MOVE_SPEED
ATTR_ROTATE_SPEED
ATTR_ARMOR   	 /* armor type*(65536 or 256) + target value (see A.G.E.) */
ATTR_ATTACK   	 /* attack type*(65536 or 256) + target value (see A.G.E.) */
ATTR_RELOAD_TIME
ATTR_ACCURACY_PERCENT
ATTR_MAX_RANGE
ATTR_WORK_RATE
ATTR_RESOURCE_CARRY   	 /* carry capacity */
ATTR_BASE_ARMOR
ATTR_PROJECTILE_ID
ATTR_UPGRADE_GRAPHIC   	 /* graphics angle */
ATTR_PROJECTILE_INTELLIGENCE
ATTR_MIN_RANGE
ATTR_STORAGE_VALUE   	 /* population support, tree wood amount, decay time */
ATTR_BLAST_RADIUS
ATTR_SEARCH_RADIUS
ATTR_HIDDEN_DAMAGE_RESIST
ATTR_ICON_ID
ATTR_STORAGE2_VALUE
ATTR_STORAGE3_VALUE
ATTR_FOG_FLAG
ATTR_OCCLUSION_MODE
ATTR_GARRISON_TYPE
ATTR_RADIUS_3   	 /* unit size Z */
ATTR_CAN_BE_BUILT_ON
ATTR_FOUNDATION_TERRAIN
ATTR_HERO_STATUS   	 /* ADD_ATTRIBUTE append flags */
ATTR_ATTACK_DELAY   	 /* ADD_ATTRIBUTE enabled */
ATTR_TRAIN_LOCATION
ATTR_TRAIN_BUTTON
ATTR_BLAST_LEVEL
ATTR_BLAST_DEFENSE
ATTR_SHOWN_ATTACK
ATTR_SHOWN_RANGE
ATTR_SHOWN_MELEE_ARMOR
ATTR_SHOWN_PIERCE_ARMOR
ATTR_NAME_ID
ATTR_CREATE_SDESC_ID
ATTR_TERRAIN_ID
ATTR_TRAITS   	 /* ADD_ATTRIBUTE append flags */
ATTR_PIECE
ATTR_DEAD_ID
ATTR_HOTKEY_ID
ATTR_MAX_CHARGE
ATTR_RECHARGE_RATE
ATTR_CHARGE_EVENT
ATTR_CHARGE_TYPE
ATTR_COMBAT_ABILITY
ATTR_ATTACK_DISPERSION
ATTR_PROJECTILE2_ID
ATTR_BLOOD_ID
ATTR_HIT_MODE
ATTR_VANISH_MODE
ATTR_PROJECTILE_ARC
ATTR_ATTACK_GRAPHIC
ATTR_ATTACK2_GRAPHIC
ATTR_STANDING_GRAPHIC
ATTR_STANDING2_GRAPHIC
ATTR_DYING_GRAPHIC	
ATTR_UNDEAD_GRAPHIC
ATTR_WALKING_GRAPHIC
ATTR_RUNNING_GRAPHIC
ATTR_SPECIAL_GRAPHIC
ATTR_OBSTRUCTION_TYPE
ATTR_BLOCKAGE_CLASS
ATTR_SELECTION_EFFECT
ATTR_SPECIAL_ABILITY
ATTR_IDLE_ATTACK_GRAPHIC
ATTR_HERO_GLOW_GRAPHIC
ATTR_GARRISON_GRAPHIC
ATTR_CONSTRUCTION_GRAPHIC
ATTR_SNOW_GRAPHIC
ATTR_DESTRUCTION_GRAPHIC
ATTR_DESTRUCTION_RUBBLE_GRAPHIC
ATTR_RESEARCHING_GRAPHIC
ATTR_RESEARCH_COMPLETED_GRAPHIC
ATTR_DAMAGE_GRAPHIC
ATTR_SELECTION_SOUND
ATTR_SELECTION_SOUND_EVENT
ATTR_DYING_SOUND
ATTR_DYING_SOUND_EVENT
ATTR_TRAIN_SOUND
ATTR_TRAIN_SOUND_EVENT
ATTR_DAMAGE_SOUND
ATTR_DAMAGE_SOUND_EVENT
ATTR_RESOURCE_COST
ATTR_CREATION_TIME
ATTR_GARRISON_ARROWS
ATTR_FOOD_COST
ATTR_WOOD_COST
ATTR_GOLD_COST
ATTR_STONE_COST
ATTR_MAX_DUP_MISSILES
ATTR_HEALING_RATE
ATTR_REGENERATION_RATE
ATTR_POPULATION   	 /* population cost */
ATTR_MIN_CONV_MOD	/* adds to the minimum time to convert the unit */
ATTR_MAX_CONV_MOD	/* adds to the maximum time to convert the unit */
ATTR_CONV_CHANCE_MOD	/* reduces the chance to convert the unit per conversion roll */
ATTR_FORMATION_CATEGORY	/* 0: not using formation, 1: mobile, 2: body, 3: ranged, 4: long ranged, 5: protected */
ATTR_AREA_DAMAGE		/* multiplier to the percentage of blast damage the non-directly targeted units receive if positive value, fixed number damage if negative */
ATTR_DAMAGE_REFLECTION
ATTR_FRIENDLY_FIRE_DAMAGE
ATTR_REGENERATION_HP_PERCENT
ATTR_BUTTON_ICON_ID
ATTR_SHORT_TOOLTIP_ID
ATTR_EXTENDED_TOOLTIP_ID
ATTR_HOTKEY_ACTION
ATTR_CHARGE_PROJECTILE_ID
ATTR_AVAILABLE_FLAG
ATTR_DISABLED_FLAG
ATTR_ATTACK_PRIORITY
ATTR_INVULNERABILITY_LEVEL
ATTR_GARRISON_FIREPOWER
ATTR_COMMAND_SOUND	/* currently bugged, don't use it yet. */
ATTR_COMMAND_SOUND_EVENT	/* currently bugged, don't use it yet. */
ATTR_MOVE_SOUND	/* currently bugged, don't use it yet. */
ATTR_MOVE_SOUND_EVENT	/* currently bugged, don't use it yet. */
ATTR_CONSTRUCTION_SOUND
ATTR_CONSTRUCTION_SOUND_EVENT
ATTR_TRANSFORM_SOUND
ATTR_TRANSFORM_SOUND_EVENT
ATTR_RUN_PATTERN
ATTR_INTERFACE_KIND
ATTR_COMBAT_LEVEL
ATTR_INTERACTION_MODE
ATTR_MINIMAP_MODE
ATTR_TRAILING_UNIT
ATTR_TRAIL_MODE
ATTR_TRAIL_DENSITY
ATTR_PROJECTILE_GRAPHIC_DISPLACEMENT_X
ATTR_PROJECTILE_GRAPHIC_DISPLACEMENT_Y
ATTR_PROJECTILE_GRAPHIC_DISPLACEMENT_Z
ATTR_PROJECTILE_SPAWNING_AREA_WIDTH
ATTR_PROJECTILE_SPAWNING_AREA_LENGTH
ATTR_PROJECTILE_SPAWNING_AREA_RANDOMNESS
ATTR_DAMAGE_GRAPHICS_ENTRY_MOD
ATTR_DAMAGE_GRAPHICS_TOTAL_NUM
ATTR_DAMAGE_GRAPHIC_PERCENT
ATTR_DAMAGE_GRAPHIC_APPLY_MODE
ATTR_TRAIN_LOCATIONS_ENTRY_MOD
ATTR_TRAIN_LOCATIONS_TOTAL_NUM
Resource Constants
Resource constants are used by effect_amount and effect percent to modify various things in the gamedata.  Those resources that are predefined are listed below.
Other resources (see Advanced Genie Editor or the guides listed below) must be manually defined (with #const) before they can be used.

A full list of available resources can be found in resources\_common\xs\Constants.xs in your DE game directory, but most will need to be defined as an RMS constant before you can use them.
There are also several attempts to document these resources:
User Generated Content Guide
AI scripting reference
UserPatch Effects Guide

AMOUNT_FOOD
AMOUNT_WOOD
AMOUNT_STONE
AMOUNT_GOLD
AMOUNT_POPULATION_CAP
AMOUNT_POPULATION
AMOUNT_CONVERT_PRIEST
AMOUNT_CONVERT_BUILDING
AMOUNT_BONUS_POPULATION_CAP
AMOUNT_TOWN_CENTER_UNAVAILABLE
AMOUNT_STARTING_FOOD
AMOUNT_STARTING_WOOD
AMOUNT_STARTING_STONE
AMOUNT_STARTING_GOLD
AMOUNT_BUILDING_TRICKLE_FOOD
AMOUNT_BUILDING_TRICKLE_WOOD
AMOUNT_BUILDING_TRICKLE_STONE
AMOUNT_BUILDING_TRICKLE_GOLD
AMOUNT_REVEAL_ENEMY
AMOUNT_REVEAL_RELICS
AMOUNT_ELEVATION_HIGHER_BONUS
AMOUNT_ELEVATION_LOWER_BONUS
AMOUNT_MONUMENT_TRICKLE_FOOD
AMOUNT_MONUMENT_TRICKLE_WOOD
AMOUNT_MONUMENT_TRICKLE_STONE
AMOUNT_MONUMENT_TRICKLE_GOLD
AMOUNT_FOOD_GENERATION
AMOUNT_WOOD_GENERATION
AMOUNT_STONE_GENERATION
AMOUNT_GOLD_GENERATION
AMOUNT_WORKSHOP_TRICKLE_FOOD
AMOUNT_WORKSHOP_TRICKLE_WOOD
AMOUNT_WORKSHOP_TRICKLE_STONE
AMOUNT_WORKSHOP_TRICKLE_GOLD
Technology Constants
Technology constants are used by effect_amount and effect percent to modify aspects related to technologies.  No technologies have predefined constants, so you must define them first (with #const) before using them.
Use Advanced Genie Editor to view technologies and their IDs.
You can also check out this website: https://halfon.aoe2.se/
ModifyTech Constants
ModifyTech constants are used by effect_amount and effect percent to modify aspects related to technologies.

ATTR_SET_TIME
ATTR_ADD_TIME
ATTR_SET_FOOD_COST
ATTR_SET_WOOD_COST
ATTR_SET_STONE_COST
ATTR_SET_GOLD_COST
ATTR_SET_LOCATION
ATTR_SET_BUTTON
ATTR_SET_ICON
ATTR_SET_NAME
ATTR_SET_DESCRIPTION
ATTR_SET_STACKING   	 /* allow techs to be researched 256 times! */
ATTR_SET_STACKING_RESEARCH_CAP
ATTR_SET_HOTKEY
ATTR_SET_STATE
ATTR_ADD_FOOD_COST
ATTR_ADD_WOOD_COST
ATTR_ADD_STONE_COST
ATTR_ADD_GOLD_COST
Class Constants
Class constants can be used with guard_state, effect_amount and effect percent to target all variations of a unit type, for example all villagers.

There are additional classes which are not predefined.  A list can be found in resources\_common\xs\Constants.xs in your DE game directory, or by using  Advanced Genie Editor
Those must be manually defined (with #const) before they can be used.

VILLAGER_CLASS
BUILDING_CLASS
OCEAN_FISH_CLASS
SHORE_FISH_CLASS
FARM_CLASS
TREE_CLASS
TOWER_CLASS
WALL_CLASS
GATE_CLASS
KING_CLASS
LIVESTOCK_CLASS
INFANTRY_CLASS
ARCHERY_CLASS
ARCHERY_CANNON_CLASS
CAVALRY_CLASS
CAVALRY_ARCHER_CLASS
CAVALRY_CANNON_CLASS
MONASTERY_CLASS
SIEGE_WEAPON_CLASS
SCORPION_CLASS
PACKED_TREBUCHET_CLASS
UNPACKED_TREBUCHET_CLASS
PETARD_CLASS
WARSHIP_CLASS
Miscellaneous Constants
Map Types
Map type constants are used only for ai_info_map_type.  If your map is not very similar to a commonly played existing map, it is best to use CUSTOM, or to leave out ai_info_map_type entirely.
Map types are always true when checking for them with if/elseif so there is no point in doing so.
Note that KING_OF_THE_HILL refers to a map type and is always true; for the game-mode conditional, use KING_OT_HILL instead!
Non-predefined map types can be seen in this json file, although it is untested whether these work and can be recognized by an AI.

ARABIA
ARCHIPELAGO
ARENA
BALTIC
BLACK_FOREST
COASTAL
CONTINENTAL
CRATER_LAKE
FORTRESS
GHOST_LAKE
GOLD_RUSH
HIGHLAND
ISLANDS
KING_OF_THE_HILL
MEDITERRANEAN
MIGRATION
MONGOLIA
NOMAD
OASIS
RIVERS
SALT_MARSH
SCANDANAVIA
TEAM_ISLANDS
YUCATAN
STEPPE
BUDAPEST
VALLEY
ATLANTIC
LAND_OF_LAKES
LAND_NOMAD
CENOTES
GOLDEN_HILL
MEGARANDOM
MICHI
AMBUSH
CUSTOM
NILE_DELTA
MOUNTAIN_PASS
SERENGETI
SOCOTRA
KILIMANJARO
Cliff Types
Used by cliff_type.

CT_GRANITE
CT_DESERT
CT_SNOW
CT_MARBLE
CT_LIMESTONE
Season Types
Used by color_correction.
See this spreadsheet

CC_DEFAULT
CC_AUTUMN
CC_WINTER
CC_JUNGLE
CC_DESERT
CC_NIGHT
CC_EVENING
CC_SPRING
CC_SAVANNAH
CC_ARCTIC
CC_RAINFOREST
CC_SWAMP
CC_STEPPES
CC_MISTY
CC_SUMMER
CC_MURKY
CC_BRUMOUS
CC_TWILIGHT
CC_DARKNESS
Water Definitions
Used by water_definition.
See this spreadsheet

WD_DEFAULT
WD_AFTERNOON
WD_ARCTIC
WD_CALM
WD_CHOPPY
WD_DARK_NIGHT
WD_DIMMED
WD_EVENING
WD_HURRICANE
WD_MOONLIT_NIGHT
WD_MORNING
WD_MURKY
WD_NIGHT
WD_NOON
WD_OCEAN
WD_RED_TIDE
WD_STORMY
WD_SUNRISE
WD_SUNSET
WD_SWAMP
WD_TROPICAL
Assign Types
Used by assign_to.

AT_PLAYER
AT_COLOR
AT_TEAM
Player Data Constants
DATA_CIV_NAME_ID
Civilizations
Used for set_gaia_civilization.  The first number is the ID; the number in brackets is the architecture style.  Image is a screenshot from Advanced Genie Editor.  Civilization constants shown below.


CIVILIZATION_GAIA
CIVILIZATION_BRITONS
CIVILIZATION_FRANKS
CIVILIZATION_GOTHS
CIVILIZATION_TEUTONS
CIVILIZATION_JAPANESE
CIVILIZATION_CHINESE
CIVILIZATION_BYZANTINES
CIVILIZATION_PERSIANS
CIVILIZATION_SARACENS
CIVILIZATION_TURKS
CIVILIZATION_VIKINGS
CIVILIZATION_MONGOLS
CIVILIZATION_CELTS
CIVILIZATION_SPANISH
CIVILIZATION_AZTECS
CIVILIZATION_MAYA
CIVILIZATION_HUNS
CIVILIZATION_KOREANS
CIVILIZATION_ITALIANS
CIVILIZATION_HINDUSTANIS
CIVILIZATION_INCA
CIVILIZATION_MAGYARS
CIVILIZATION_SLAVS
CIVILIZATION_PORTUGUESE
CIVILIZATION_ETHIOPIANS
CIVILIZATION_MALIANS
CIVILIZATION_BERBERS
CIVILIZATION_BURMESE
CIVILIZATION_KHMER
CIVILIZATION_MALAY
CIVILIZATION_VIETNAMESE
CIVILIZATION_BULGARIANS
CIVILIZATION_TATARS
CIVILIZATION_CUMANS
CIVILIZATION_LITHUANIANS
CIVILIZATION_BURGUNDIANS
CIVILIZATION_SICILIANS
CIVILIZATION_POLES
CIVILIZATION_BOHEMIANS
CIVILIZATION_DRAVIDIANS
CIVILIZATION_BENGALIS
CIVILIZATION_GURJARAS
CIVILIZATION_ROMANS
CIVILIZATION_ARMENIANS
CIVILIZATION_GEORGIANS
CIVILIZATION_ACHAEMENIDS
CIVILIZATION_ATHENIANS
CIVILIZATION_SPARTANS
CIVILIZATION_SHU
CIVILIZATION_WU
CIVILIZATION_WEI
CIVILIZATION_JURCHENS
CIVILIZATION_KHITANS

Scripting and Testing
Standard Units and Resources
In DE, you will find the object generation contained within the GeneratingObjects.inc file, with map scripts activating specific parts of it.  However, it is much easier to look at land_resources.inc which is where the AoC objects generation was stored.  That isn't as balanced, but is much more readable.
For an example of object generation, I have parsed down and simplified GeneratingObjects.inc into a readable format, see: Simplified Standard Objects Generation

The standard starting units that you should give each player are:
1 town center at max_distance_to_players 0
Villagers (without specifying how many) at about 6 tiles away (this will automatically adjust for the civilization in AoC/UP/HD, while in DE any extra villagers will be spawned by the town center)
1 scout (will automatically be an eagle scout or camel scout when necessary)
Any game-mode specific objects 

The standard (DE) starting resources per player are:
1 group of 6 forage bushes at least 10 tiles away
1 group of 7 gold mines at least 10 tiles away
1 group of 4 gold mines at least 18 tiles away
1 group of 4 gold mines at least 21 tiles away
1 group of 5 stone mines at least 12 tiles away
1 group of 4 stone mines at least 16 tiles away
1 group of 4 sheep at around 7 tiles (if cows/water buffalo, use 1 group of 3 instead)
In tournament  maps, 1 or all of these often start under control of the player.
2 groups of 2 sheep at a shared variable min distance (14-24) away (if cows/water buffalo, use 1 group of 3, or 2+1 instead)
2 individual boar at least 16 tiles away
1 group of either 3 or 4 deer at a variable min distance (14-24) away
1 individual predator at least 34 tiles away
2 individual trees at 4-5 tiles away
3 individual trees at 6-8 tiles away

Notes:
"at least" means that find_closest is being used in combination with a minimum distance.
It is not necessary to conform to the standard starting resources, but they provide a good starting point.
Indeed, various official maps use different distributions depending on the available space and the nature of the map.
Sheep/deer/boar can also be their variants (ie. goat/ostrich/elephant for example)
If distances are randomized, it is best to randomize them in bands, so that no player gets a super far distance compared to other players.

The standard (DE) resources by map size (scattered resources) are:
5/5/5/7/8/∞/∞ relics on tiny/small/medium/large/huge/gigantic/ludicrous maps
Groups of 4 berries on large/huge/gigantic/ludicrous, at least 40 tiles from players (with a very large temp_min_distance_group_placement to ensure low density)
2/2/3/3/4/5/26 groups of 3/3/3/3/4/4/4 gold each, on tiny/small/medium/large/huge/gigantic/ludicrous maps, at least 40 tiles from players
2/2/3/3/4/∞/∞ groups of 2/2/3/4/4/4/4 stone each, on tiny/small/medium/large/huge/gigantic/ludicrous maps, at least 40 tiles from players
2 groups of 1 predator, with set_scaling_to_map_size at least 40 tiles from players
∞ shore fish, with temp_min_distance_group_placement 6
6 fish with set_scaling_to_map_size and min_distance_group_placement 4
∞ fish of a different type, with min_distance_group_placement 8
30 individual trees, with set_scaling_to_map_size
4 birds with set_scaling_to_map_size

Notes:
∞ means an excess of what will actually fit.
For scattered resources you can either specify a fixed number for each size, use set_scaling_to_map_size and/or place an excess while specifying a high temp_min_distance_group_placement to restrict the actual count.  All of these approaches can yield similar results.
For smaller maps and more important resources (ie. relics, gold and stone) the first approach is generally used because it gives the most control.
On island-style maps, extra resources are instead placed per-player to ensure the same amount on each island.
For example, on 1v1 tiny islands the relics are 2 for each player and 1 on a central island.
It is not necessary to conform to the standard starting resources, but they provide a good starting point.
Indeed, various official maps use different distributions depending on the available space and the nature of the map.
The exact values are subject to change in future DE updates.
Simplified Standard Objects Generation
The GeneratingObjects.inc file is used by many of the DE maps to generate objects.  Each map passes various inputs that activate parts of that file.
For example, #define GNR_STARTGOLD744CL activates the sections necessary to give the classic 7+4+4 starting gold.
The file is difficult to comprehend and can be especially confusing for newer scripters.  I have therefore parsed out all of the parts that are activated by 2021 Arabia and Coastal, and then merged and simplified those to give the scripts you will find below.  It provides a pretty good overview of how DE handles object generation.  The second one also shows how Empire Wars is implemented.  It is subject to change if the object generation in DE is updated.
Simple DE Objects Generation (No Empire Wars) (very simple)
Clean DE Objects Generation with Empire Wars (more complicated)
There is a project on GitHub to make a GeneratingObjects Parser; see here, here and here
Game Mode Support
The only game-mode that you absolutely must support is regicide, otherwise players will instantly lose because they lack a king.  Nomad will be more streamlined if you follow the advice here.  Death Match and Infinite Resources will be less cluttered if you take the time to remove unnecessary stuff.  Empire Wars is implemented on a per-map basis, so will play out like random map unless you manually code for the units and buildings.
Regicide
In regicide mode, lacking a King will trigger instant defeat.  Also the starting resources are 500 wood/food, 0 gold, and 150 stone.  Spies is replaced by treason.
It is also possible to use the secondary game mode tick box for regicide instead of the main regicide game mode.  In this case, starting resources are inherited from the chosen game mode and both spies and treason will be available.
Required: give each player a king.
Usually a castle and 7 additional villagers are given as well (with the castle providing the housing space for the extra villagers).
Optional: some maps give players a tower instead of a castle, while nomad maps might not give any buildings.
Optional: some maps may adjust the starting resources to be standard instead.
King of the Hill
A monument automatically spawns in the center.  In DE, controlling the monument grants a resource trickle.  This trickle can be modified by using effect_amount on the relevant constants.
Nomad
Nomad is not actually a game mode.  Nomad is any map where the player starts without a town center and must first build one with their villagers.  If you make a nomad map, you should consider these things:
Make sure to specify 1 for the isNomad flag for ai_info_map_type
Example: ai_info_map_type CUSTOM 1 0 0
This may help AIs and will prevent a visibility bug with allied male villagers (fixed in DE)
Specify nomad_resources to add the cost of a town center (275 Wood, 100 Stone) to every player's starting resources.
If you do not do this, players will first need to build a lumber camp and gather the necessary wood to afford a town center.
Do not include a scout or predators, as these would be able to kill villagers very early.
Consider adding force_nomad_treaty if you want to prevent villager fighting until everyone has built their town center. 
Death Match
Players start with 20000 wood/food, 10000 gold, 5000 stone.  Typically played in post-imperial.
Remove berries, sheep, deer, boar, wolves, straggler trees and shore fish, since players will not have time to gather from these resources, and they just get in the way.
Sudden Death
Players cannot construct new town centers (exception: the first one for nomad starts) and are defeated if they lose their town center.
Optional: Put some flags or something around the town center to remind people how important it is.
Infinite Resources (DE only)
This is a resource setting rather than a game mode.  Players will have infinite resources.
Remove all resources except where required for the visual appeal of the map.
Do not remove relics, because some civilizations use them for their bonus (ie. Lithuanians).
Empire Wars (DE only)
Empire Wars is a new game mode in DE.  On Empire Wars, villagers will start harvesting the nearest resource. Huns begin with no houses and extra resources to compensate.  These are the only hardcoded changes.

The goal of Empire Wars is to provide a working feudal age base with an economic population of 28, but you must do so manually.  Check out Simplified Standard Objects Generation in the Appendix for a consolidated Empire Wars implementation.
The standard Empire Wars start includes the following:
1 town center
1 scout slightly further away than usual
A total of 28 villagers distributed across various resources
On water-heavy maps, some of the villagers may instead be fishing ships
2 farms around the town center with 1 villager on each
1 mill next to the primary berries
4 villagers next to the primary berries
1 mining camp next to the primary gold
4 villagers next to the primary gold
3 lumber camps on the closest forests
4/4/4 villagers by the lumber camps
1 sheep/cow under the TC
6 villagers idle under the TC
1 blacksmith
6 houses, forming a pseudo-wall
1 barracks
4 sheep or 3 cows close to the players
No further sheep/cows and no boar
No straggler trees around the town center
Reduced straggler trees on the map in general
Battle Royale (DE only)
Battle Royale is a new game mode in DE, with several hardcoded changes.  The map gradually constricts, destroying any objects and replacing terrains with a corruption terrain.  Gaia buildings can repeatedly switch control to any player within their line of sight, if the current owner is not within line of sight (includes gaia).  Players always start with zero stone, regardless of the resource level set in the lobby.  Town centers contain a button to pack them into a cart for relocating.
The official Battle Royale maps are custom designed for this game mode.  They use the new trade workshop (ID 1647) to generate resources for players who control them.  A resource trickle (ID 1654) is also given to players, along with a few hero units to start with.  The maps are covered in "camps" - collections of gaia buildings that can be captured.  Powerful camps (especially castles) are guarded by numerous unconvertible (see set_gaia_unconvertible) gaia units.  
Consider disabling the following units and buildings or including the file BR_conditions.inc which contains these changes:
<PLAYER_SETUP>
#const SPIES 408
#const FLEMISH_REVOLUTION 755
#const FIRST_CRUSADE 756
#const DONJON_ENABLER 775
#const TRADE_COG_ENABLER 180
#const FISH_TRAP_ENABLER 357

effect_amount DISABLE_TECH SPIES ATTR_DISABLE 408
effect_amount DISABLE_TECH FLEMISH_REVOLUTION ATTR_DISABLE 755
effect_amount DISABLE_TECH FIRST_CRUSADE ATTR_DISABLE 756
effect_amount DISABLE_TECH DONJON_ENABLER ATTR_DISABLE 775
effect_amount DISABLE_TECH TRADE_COG_ENABLER ATTR_DISABLE 180
effect_amount DISABLE_TECH FISH_TRAP_ENABLER ATTR_DISABLE 357
effect_amount ENABLE_OBJECT FISHING_SHIP ATTR_DISABLE 0
effect_amount MOD_RESOURCE AMOUNT_FOOD_GENERATION ATTR_ADD 15
effect_amount MOD_RESOURCE AMOUNT_WOOD_GENERATION ATTR_ADD 15
effect_amount MOD_RESOURCE AMOUNT_GOLD_GENERATION ATTR_ADD 15
Antiquity Mode (DE only)
A lobby setting that can be toggled to allow trade to generate wood.  On the official maps it is also used to generate oysters as a water-based gold source.  You can check for the ANTIQUITY_MODE conditional and generate oysters if it is active.
AI Support
AIs will be able to play better on maps that are more standard, and which offer plenty of space, and good access to resources.  Very few AIs can effectively migrate bases to new islands or manage fleets across multiple isolated bodies of water.

This guide by AI scripter marathon16 covers more things to consider: How to make your RMS script more AI-friendly
Note that some portions of the AI scripting community are (still) on UP/WK, not on DE.
Testing
Scenario Editor
You can generate maps in the scenario editor (UP/HD/DE).  Custom maps are shown in the map list.  You do not need to restart the game; just save changes to your script and hit "generate map" to observe the changes.  You can specify a specific seed to debug said seed or to observe the exact effect of changing some part of your script.  The usual process of random map scripting involves having both the map script and the scenario editor open, and repeatedly generating your script as you work on it.
By default, players will be unteamed in the scenario editor, but if you set up teams in the diplomacy tab, you can test team maps (UP/DE only)
You can test the object generation for other game modes such as Empire Wars by selecting secondary game modes from the victory tab.

Testing in the scenario editor has some limitations and bugs:
set_gaia_civilization resource_delta set_gaia_unconvertible all do not work when testing from the editor.  This also applies to many things you might change with effect_amount and effect_percent.
Bug: Walls may sometimes have gaps in them or fail to generate entirely.  This is a legacy issue exclusive to the scenario editor, so don't be worried if you see gaps.
BUG (DE): Water animation (3D water and beach waves) sometimes persists across repeated generations.  Disable animated water in the options to avoid this visual distraction.  This issue is exclusive to the scenario editor, so you can test in single player if you are modifying the water animation.
Single Player
Alternatively, you can test in single-player.  This may be necessary for testing specific game modes and/or lobby settings.  It may be beneficial to set visibility to "All Visible" or to use the marco and polo cheats.
When in game, you can bring up the menu and hit "restart" - this will regenerate the map from the same seed, but will use any changes to your script that you have saved.  If you want to test a different seed, you need to start a new match.
Debugging Tips
You do not need to reboot AoE2 to see changes in your map script.  Simply save changes in the file and generate the map again.
Both the scenario editor and single player offer the opportunity to repeatedly generate using the same map seed and then make changes until a particular buggy generation no longer occurs. 
An incomplete comment (one that opens but doesn't close) can quickly be used to disable large parts of your script.
Random code may influence other bits of random code in unrelated areas when using the same seed; ie. commenting out a random block at the end of your script may change which random branch is chosen at a different (earlier) point in your script.
Generating a large excess with number_of_objects can be used to visualize all possible spawn locations for that object.
Using height_limits with terrain of a different minimap color can help visualize on the minimap where elevation is being generated. 
default_terrain_replacement can be used to visualize which paths connections are taking.
You can view the map in CaptureAge while testing from the scenario editor or single player.
Adding EDITOR to the launch options will launch the game directly into the scenario editor (DE only)
Adding KEEP_MODS_AFTER_CRASH to the launch options can be helpful if your game crashes occasionally while testing your map.
Loading Times
The actual parser is not particularly fast and it will still go through everything in the file, including comments and logical branches that are not chosen.  Maps that are over 1 MB in file size will take several seconds to parse, during which the game will appear to stop responding.
This is not a concern for most maps.  Only extremely large maps such as MegaRandom (380 KB) or Dire Straits (1700 KB) cause any noticeable delay. 
If your map is considerably smaller, but still very slow to load, it may be due to having many cases of actor_area_to_place_in or computationally difficult connection generation.  Also keep in mind that the first time any textures and sprites are loaded into memory takes (significantly) longer than subsequent generations (noticeable only on DE, where the textures and sprites are larger).
Lobby transfer time is perhaps the most significant consideration.  Files over 1 MB in file size may take over a min to transfer to other players in the lobby (tested in DE).
Publishing a Map
If you are just making a map for friends, you just could send them the file and have them manually place it in their game directory.  For any other cases, it makes sense to upload your map as a mod.
Definitive Edition
DE does not use the Steam Workshop.  You will need a Microsoft account.  If you don't have an account, create one on https://account.microsoft.com/
You can browse mods at https://www.ageofempires.com/mods/ 
However, subscribing in your browser downloads nothing.  To actually get a mod, you must subscribe to it in-game using the mod manager.
You can also use https://mods.aoe2.se/ to browse and download mods without using the official site.

(NOT RECOMMENDED) To publish your own map as a mod using the in-game mod manager:
Navigate to C:\Users\<username>\Games\Age of Empires 2 DE\<numericID>\mods\local
There create a folder with the name of the your mod
Then create sub-folders to mirror the main game directory
The final result should look like this:
C:\Users\Zetnus\Games\Age of Empires 2 DE\76561198019184368\mods\local\Zetnus HyperRandom\resources\_common\random-map-scripts
Put your map(s) in that random-map-scripts folder
Sign in to your Microsoft account by clicking on your name in the main menu
In game, navigate to the "My mods" tab, within "Mods"
Click on "Publish Mod"
Choose a title and make sure the correct folder is selected
Choose an image (it must be a png or jpg)
Add a description.  If the text turns red, that means DE's incompetent chat filter doesn't like something you wrote.  You can either try and fix it, or just leave the description blank for now.
You cannot edit changelongs later, so double check your spelling there!
Hit "Publish Now"
Once it is uploaded, a web browser window will open showing your mod.
Edit the description using on the website and re-add all the profane obscenities that the chat filter didn't like, and/or to add more images.

To update your mod:
Place the new files in the relevant folder (in mods\local)
Navigate to "My Mods" in-game
Click on "Update Mod"
Follow the steps as above.
Updates should be pushed out to players automatically (when they restart the game?)

(RECOMMENDED) To publish your own map as a mod using the website:
Follow the same steps as above, but do not start the game.
Right click in windows explorer and choose new > Compressed (zipped) Folder.
Rename the resulting empty .zip file with the name of your mod.
Copy the contents of your mod folder into the renamed zip file.
Check the contents of your zip; if you see a folder with the same name as your zip, this will NOT work.  Move the contents of that part up one level.
Wrong ✘: Zetnus HyperRandom.zip\Zetnus HyperRandom\resources\_common\random-map-scripts
Correct ✔: Zetnus HyperRandom.zip\resources\_common\random-map-scripts
Upload your mod to https://www.ageofempires.com/mods/create/
To update your mod using the website, follow exactly the same steps except that you will need to go to https://www.ageofempires.com/mods/mine/ and choose the relevant mod and click on "edit"

To check if your mod works:
Subscribe to the mod using the mod browser in game.
Go to the Installed Mods tab and disable the local version of your mod.
In the Installed Mods tab, if the subscribed version of your mod has a red exclamation mark, it will not work.  Check if you messed up your folder names.
If your mod has custom map icons, you will need to restart the game (after enabling the mod) before the icons are visible in the lobby.
HD Edition (2013)
The HD Edition uses the Steam Workshop.  The process is fundamentally similar to using the in-game mod manager in DE.  Follow this guide:
How to Publish/Update Workshop Items
Voobly
Step-by-step guide for uploading a mod
Game Mod Guide
AoE2map
https://aoe2map.net/
This is an external site that has been used by the RMS community to upload map scripts, in the pre-DE era.  Just make an account, everything is very self-explanatory.
Age of Kings Heaven
Age of Kings Heaven - The Blacksmith :: Random Maps
This is a very old site, where you can find a trove of older map scripts.  You'll need to register an account before you can upload to the blacksmith.  Note that the file size limit for screenshots is very low (by modern standards).  Also note that the blacksmith is curated - this means that any uploads will need to be approved by staff before they are visible.  This may take up to 1-2 weeks if people are busy.  So be patient.
Full Map Screenshots
In the CD version of the game (including UP and WK), you can take a screenshot of the entire map, using CTRL+F12
This was broken with the new rendering engine in HD, and has not been reimplemented for DE.  However, DE officially supports CaptureAge, which is your best option to take full map screenshots in DE.

Alternatively, there are several implementations that attempt to mimic the behavior, but they rely on using an external program to take a bunch of screenshots and then stitch them together.  See external guide: AoE2 DE Full-Map Screenshot Guide and this site: AoE Full Map Capture by coltenney

If your map is backwards-compatible, you can take screenshots in UP or WK.  But if you have used a lot of new terrains/objects/features, it may not be worth the effort to make it backwards-compatible.
You can always just screenshot the minimap too.
CaptureAge
CaptureAge · Home
CaptureAge is a casting program for Age of Empires.  It was originally developed for use on Voobly.  The basic DE version is available to the public for free.  CaptureAge allows for zooming out all the way, and you can then use a snipping tool to take a screenshot of the whole map.
Capture Age can be launched when using "test" from the scenario editor, or when playing a game with cheats enabled. Alternatively, Capture Age can be used to view recorded games.
The shortcut ALT+o can be used to hide the user interface and move the minimap to the corner or to hide it entirely.
Map Icons

Map icons are the images that appear on the map selection screen in DE.
Take a look at resources\_common\wpfg\resources\mapicons or widgetui\textures\menu\mapicons for reference.
The game will rescale your image into an appropriately-sized square.  The corners should be transparent.
The simple way is to provide a .png file of the same name as your map script, in the same folder as your map script.  No .json file needed.
Map icons require restarting the game to appear after enabling a map mod.

It is also possible to make a .json file of the same name as one of your maps, and then reference the image(s), which can be in a different folder, or be a different file format.
Example .json file:
{
	"custommaps" : [{
        	"name" : "Green Arabia",
        	"iconRef" : "IconGreenArabia"
	}],
	"UserMaterials": [{
    		"Material": "IconGreenArabia",
    		"FileName": "Green Arabia.dds"
	}]
}
Map Icons Made Easy (video) 20 min video covering everything you might want to know about making map icons
Updating an Old Map for DE
Theoretically, an old map script should run on DE without having to change anything, however there are a few things to look out for.
Elevation Scaling
There was a legacy bug where set_scale_by_size and set_scale_by_groups for elevation had their behavior inverted.  This bug has been fixed in DE.  Additionally, it was not previously known that set_scale_by_size and set_scale_by_groups are mutually exclusive, since the standard maps usually use both attributes.  As a result, elevation scaling will behave differently in DE than it would have pre-DE.  A map can be made compatible with both DE and pre-DE by using a simple conditional, or if you only need your map to run on DE, all you need to do is swap the attributes.

Example: adjust elevation scaling according to game version.
if DE_AVAILABLE	set_scale_by_size
else	set_scale_by_groups	/* this is bugged and and actually scales by size in pre-DE */
endif
Base Terrain Default
base_terrain (terrain) was changed in DE such that it no longer uses grass as the default if no base terrain is specified.  Some legacy maps will be missing forests and need to be updated by adding the following to any affected create_terrain commands:
base_terrain GRASS
Additive Connections
In DE connections act on the terrain that existed before connection generation, and connections cannot replace each other by default.  To use the legacy (pre-DE) behavior where connections can replace each other, activate accumulate_connections
This only matters if you have multiple connections being generated sequentially (which is uncommon).
UserPatch Effects
Most UserPatch effects are supported in DE, as of January 2021.  However, terrain_state and weather_type are not implemented in DE.  Weather is cosmetic only and can be modified in DE using color_correction, while terrain restrictions can be modified with effect_amount.  Neither feature was commonly used in UP map scripts.
A few UP effects may function differently in DE, so double check to make sure everything works as expected.  Specifically look at any units with modified attack or armor values.
Also some effects have been depreciated or replaced such as ENABLE_TECH.
WololoKingdoms Terrains
If your map was made for WK and defines terrains using #const, you will need to redo these definitions, since WK moved various terrain IDs when compared to AoC/HD/DE. See Special Note for WololoKingdoms
Minor Stuff 
min_distance_to_players no longer applies to ALL lands anymore.
Certain unused objects in the gamedata lack graphics in DE (such as the beta berserk)  
All object IDs in the 900s have been duplicated into the 1300s because the 900s are also used for object class IDs.  Use the new IDs for the relevant objects (most notably the elephant). 
Only matters if you are manually defining using #const
base_elevation cannot be used for water lands (unlike in UP, where it can)
Beach terrains are no longer restricted terrains for placing boars, but still for deer.  Terrain restrictions can be modified with effect_amount
comments in dead logical branches are now properly ignored, so if your map was relying on a buggy comment, you will need to fix that.
New Things to Consider Adding
enable_balanced_elevation in every create_elevation command
set_circular_placement for all player objects unless using a walled (square) start
avoid_forest_zone and avoid_cliff_zone to prevent stuck resources
terrain_mask when doing cosmetic terrain mixing (because it looks nice)
color_correction (instead of weather_type from UP)
force_nomad_treaty on nomad maps
behavior_version to use the new land generation behavior (make sure to adjust the land sizes accordingly)
Adding a custom distance to set_avoid_player_start_areas if you want forests to stay further from players
Empire Wars support
override_map_size on water maps to make them slightly larger
support for the additional map sizes
require_path to prevent trapped player resources

Links and Resources
Videos
TheMadCADer has a bunch of videos that are well worth watching; here is a link to the playlist
Official Documentation
DE RMS Feature Documentation by Forgotten Empires; has screenshots and examples, but has not been updated since the DE launch.
.xs scripting in Age of Empires II: Definitive Edition by Forgotten Empires, but probably does not include more recent additions.
UserPatch Scripting Reference and RMS #Const Updates - both very useful for anything added by UP.
AgeII HD Script Reference official, but has some typos (and is ultimately just a copy of the UP reference)
Random Map Scripting Guide (RMSG) by Ensemble Studios (the same one you can find in your game directory).  (very outdated)
General Guides
AoE2DE UGC Guide has guides on xs scripting, scenario triggers, and game data attributes
AOE2 Random Map Scripting Part 1 – The Basics by Thomas Harris
AOE2 Random Map Scripting Part 2 – Arabia by Thomas Harris
UP 1.5 Effects & How to use them in Maps helps to understand the capabilities of UP
XS Scripting For Beginners everything you need to know about XS scripting
Random Map Syntax very concise, but not fully up-to-date
A Guide for Creating Maps by HenkDeSuperNerd; unfinished, but goes into good detail
Random Map Scripting Links and FAQ forum thread that is also a precursor to this guide
 Alchemy-AOE-Published-Specifications an attempt to codify the specifications for what constitutes a competitive map.
Specific Guides
MadLands Utility generate a bunch of fixed land positions using Excel, and also manage map packs more easily
Error-Handling with actor areas debugging map generations using actor areas
Dire Straits & creating random RM maps an exercise in precomputing maps
Parser Pitfalls keep the RMS parser from misbehaving
Land generation in Age of Empires II a detailed look at land generation
creating new forest-types using User-Patch upgrade forests with UP
All About Cliffs more than you ever wanted to know about cliffs
Custom Beaches use the new beach terrains in your map
Weather Effects with UserPatch 1.5
Unequal Player Starts and Unequal Player Starts - part 2 create asymmetric starts
Random Map Advanced Skills (in Chinese)
AoE2Map Snippets a collection of useful bits of code (many for UP effects)
Modifying Starting Resources (specifically for custom UP regicide) 
Everything is Regicide with with UserPatch 1.5 combine regicide with other game modes
https://eso-community.net/viewtopic.php?p=436182 XS scripting
https://aok.heavengames.com/cgi-bin/forums/display.cgi?action=ct&f=4,44731,,30 XS scripting
https://www.hawkaoe.net/bbs/thread-147206-1-1.html XS scripting
Example Scripts
You can also open up any existing map script and take a look.  A lot can be learned by modifying an existing map and observing the effects of your changes. 
The original Random Map Scripting Guide (RMSG) by Ensemble Studios (the same one you can find in your game directory) contains a commented version of Coastal.
The classic AoC versions of the official maps can be found in this mod, and are much more simple to read than the new DE versions of the official maps.  Do NOT start out with modern tournament versions of maps, (especially not from Arabia or any of the Red Bull Wololo maps).
The ES maps (Ensemble Studios custom maps) are also good choices to look at.  They are found in this mod and this one.
In the Appendix you will find Simplified Standard Objects Generation with a parsed down version of the DE objects generation.  
Reference\Scripting\Examples within your UserPatch install directory contains three scripts to showcase the functionality of Userpatch 1.5
Syntax Highlighting
Getting an RMS syntax highlighter for your text editor of choice will help you spot typos and generally improve the scripting experience.  The community has syntax highlighters for numerous text editors, most of which have not been updated since DE was released in 2019.
Notepad++
RMS syntax for Notepad++ - updated 2025
VIsual Studio Code
AoE2 RMS Check - updated 2020
AoE2 XS Scripting (not RMS) - updated 2025
Vim
vim-aoe2-rms - updated 2019
IntelliJ
RMS plugin - updated 2018
Sublime Text
AoE2 Random Map Scripting - updated 2017
Word
RMS Creator - updated 2014
PSPad
RMS Toolkit - updated 2006
Miscellaneous Utilities
Image to rms - a fun utility to turn an image into a map script
Mod Directory - browse and download DE mods without using the official site 
RMS in Racket and the Documentation

Appendix
DE Update Changelogs 
Updates/changes/fixes/bugs (relevant to map scripting) from all DE updates are listed here for easy reference.

December 2025 Update
Chickens and hares now have 75 food instead of 65
Added 9 new random maps (Crownwood, Dorothea Quarry, Glacis, Hengehold, Loch Ness, Rampart, Stonefront, Thames, Vulpine)
Added eyecandy (stonehenge, nessie, RoyalAlbertHall - no associated object)

Chronicles: Alexander the Great Update (October 2025)
Added pre-defined constants for all the color corrections and water color corrections.
Added constants for the civilizations.
Added pre-constants for animals and terrains from the prevision update.
Added new DLC content, including 3 new civilizations (Macedonians, Thracians, Puru) and the following objects that might be useful for map scripting:
Peacocks (2537) as an un-pushable hunt source with 85 food.
Owls (2490) as a bird.
Beached whales (2457) as scenery.
Greek Commander Tent Dropsite (2405) as a universal resource drop off point.
Added walkable black terrain (129), where pathfinding isn't buggy.
Allowed modifying the following unit attributes by Effect Amount, Modify Attribute trigger effect and technologies in data with the IDs: 
Train Locations Entry Mod (158) – allows to specify the index of the Train Location structure to be modified or queried from the Train Locations array for the associated attributes (Train Location ID, Button ID, Train Time, Hotkey ID). Defaults to 0, otherwise has the same behavior as the Damage Sprite index attribute.
Train Locations Total Num (159) – allows to obtain or resize the length of the Train Location array. When resizing to a larger size, will duplicate the values for the last entry. Otherwise has the same behavior as the Damage Sprite number attribute.
Units no longer have a single train location, but a list of train locations. 
To change the train location of a unit, you now have to give the index of the list entry that you want to change. 
To remove a train location, you set the list size smaller than it originally is (and possibly have to edit the remaining entries as well if it's not the last entry that you want to remove).
To add a new train location, you set the list size one higher than it originally is and then edit the (new) last entry.
You can also use the "multiply attribute" operation on the Entry Mod attribute to insert/delete an entry at a specific index.  For example if you have 5 entries and you want to delete the 3rd one, you use "multiply attribute" on entry mod with -3 and that specific element will be gone.
Insert entry: mul with 0, 1, 2, …
Delete entry: mul with -1, -2, -3, ... (or "Divide" with 0, 1, 2, ... in Scenario Triggers)
So no need to resize and repopulate the rest of the list.
In a similar way, you can use mul attribute with 32767 to always insert an entry at the tail, even when you don't know the current size of the array, and automatically set the index marker to newly made element.
This works for both Damage Sprites modding and Train Locations modding.
The changes do not impact any maps, as the default train location index is 0, which is equivalent to the behavior it had before where you don't call specific train location indexes.

Summer 2025 Update
Constants no longer get rounded to integer values when used in math operations.
The % (integer modulo) math operation will no longer crash the game when used with a floating-point value between -1 and 1 as the right operand. 
Using this operation with 0 as the right operand will now return the left operand rounded towards zero (truncated).
Fixed an issue where the land and amphibious placeholder objects couldn’t be placed on unbuildable land terrains.
Fixed an issue which caused gaia units to not be affected by effect_amount commands if set_gaia_civilization was used in the script.
Allowed use of float-format values in land generation commands: land_position, land_percent, left_border, right_border, top_border, bottom_border, circle_radius.
Added KEEP_MODS_AFTER_CRASH launch parameter to keep the mods enabled if the previous session has crashed.
The map icon is now shown on the loading screen.  This does not work by default with custom map icons, but it might be possible to mod the loadingscreen xaml to make it work?
Random map seed is now displayed in the Objectives screen in single player and finished multiplayer games.
New commands and attributes:
set_circular_base - land origins can be circular now!
avoid_other_land_zones - keep objects confined to a specific land!
water_definition - specify color correction and wave style for 3D water
create_object_group & add_object - create a pool of objects from which to choose individuals from.
land_conformity
Accepts one integer parameter with values from -100 to 100. The higher the value, the more the additional tiles set by land_percent or number_of_tiles conform to the base_size of the land, therefore not creating huge deviations from the original shape. Negative values actively discourage the behavior.
Currently buggy; avoid using since it may get changed.
create_connect_land_zones - generate connections between lands with specific zones.
generate_mode - allow randomly placed lands to generate anywhere, including in the corners.
spacing_to_specific_terrain - avoid specific terrains during terrain generation.
The patch notes say you are limited to using this 4 times, but this is NOT true.
New terrains:
Grass, Flowers 1 (122)
Grass, Flowers 2 (123)
Snow (Soft) (124)
Snow (Soft), Light (125)
Snow (Soft), Strong (126)
Ice (Soft) (127)
Ice, Navigable (26) was given a unique terrain texture.
New animals:
Added a new type of huntable animal which holds 35 gold and can be gathered without dropping the resources:
Red Fox (1955)
Arctic Fox (1958)
Added new small unpushable huntable animals:
Hare (2098, 2099)
Arctic Hare (2100)
Added a new herdable animal:
Llama B (white variation) (1963)
Added a new predator animal:
Arctic Wolf (1965)
Animal changes:
Wild Chicken
HP changed from 5 → 3
Crocodile
Receives +5 charge attack with 30 seconds recharge
Running speed changed from 1.05 → 0.885
Snow Leopard and Jaguar
Running speed changed from 1.05 → 1.19
Dire Wolf
No longer buggy
HP 50
Attack 4
Regeneration rate 10
Rabid Wolf
No longer buggy
HP changed from 30 → 20
Attack changed from 5 → 3
Deals lasting damage to its targets (-15 HP/min for 20 seconds)
Receives black glow particle for visual distinction
Komodo Dragon
Deals lasting damage to its targets (-6 HP/min for 15 seconds)
Running speed changed from 1.05 → 0.885
Brown Bear
HP changed from 25 → 30
Polar Bear
HP changed from 25 → 30
Attack changed from 3 → 4
Food from animals killed by Military or Buildings no longer spoils and can now be gathered by Villagers.
Animals, terrains, trees, oysters, placeholder objects for random maps, and some eye candy objects which were added in previous patches, are now available in Return of Rome.
Allowed researching economy technologies in Lumber and Mining Camps and Mule Carts when the buildings are owned by civilizations that don’t have access to them (for example when players start with a Mule Cart or convert it from Armenian or Georgian players).
The ES maps have been reworked into official maps (except for Sherwood Heroes & The Unknown, both of which are removed).  Old versions are available in this mod, or this mod.
Added several new maps: Aquarena, Sardis, Stranded, Mired, Border Dispute, Chaos Pit, Murkwood, Forest Breach (special map)
Significantly reworked the following maps: Bogland, Cenotes, Kilimanjaro, Mongolia, Mountain Pass, Oasis.
New attributes:
#const ATTR_SPECIAL_ABILITY 81
#const ATTR_IDLE_ATTACK_GRAPHIC 82
#const ATTR_HERO_GLOW_GRAPHIC 83
#const ATTR_GARRISON_GRAPHIC 84
#const ATTR_CONSTRUCTION_GRAPHIC 85
#const ATTR_SNOW_GRAPHIC 86
#const ATTR_DESTRUCTION_GRAPHIC 87
#const ATTR_DESTRUCTION_RUBBLE_GRAPHIC 88
#const ATTR_RESEARCHING_GRAPHIC 89
#const ATTR_RESEARCH_COMPLETED_GRAPHIC 90
#const ATTR_DAMAGE_GRAPHIC 91
#const ATTR_SELECTION_SOUND 92
#const ATTR_SELECTION_SOUND_EVENT 93
#const ATTR_DYING_SOUND 94
#const ATTR_DYING_SOUND_EVENT 95
#const ATTR_TRAIN_SOUND 96
#const ATTR_TRAIN_SOUND_EVENT 97
#const ATTR_DAMAGE_SOUND 98
#const ATTR_DAMAGE_SOUND_EVENT 99
#const ATTR_COMMAND_SOUND 132
#const ATTR_COMMAND_SOUND_EVENT 133
#const ATTR_MOVE_SOUND 134
#const ATTR_MOVE_SOUND_EVENT 135
#const ATTR_CONSTRUCTION_SOUND 136
#const ATTR_CONSTRUCTION_SOUND_EVENT 137
#const ATTR_TRANSFORM_SOUND 138
#const ATTR_TRANSFORM_SOUND_EVENT 139
#const ATTR_RUN_PATTERN 140
#const ATTR_INTERFACE_KIND 141
#const ATTR_COMBAT_LEVEL 142
#const ATTR_INTERACTION_MODE 143
#const ATTR_MINIMAP_MODE 144
#const ATTR_TRAILING_UNIT 145
#const ATTR_TRAIL_MODE 146
#const ATTR_TRAIL_DENSITY 147
#const ATTR_PROJECTILE_GRAPHIC_DISPLACEMENT_X 148
#const ATTR_PROJECTILE_GRAPHIC_DISPLACEMENT_Y 149
#const ATTR_PROJECTILE_GRAPHIC_DISPLACEMENT_Z 150
#const ATTR_PROJECTILE_SPAWNING_AREA_WIDTH 151
#const ATTR_PROJECTILE_SPAWNING_AREA_LENGTH 152
#const ATTR_PROJECTILE_SPAWNING_AREA_RANDOMNESS 153
#const ATTR_DAMAGE_GRAPHICS_ENTRY_MOD 154
#const ATTR_DAMAGE_GRAPHICS_TOTAL_NUM 155
#const ATTR_DAMAGE_GRAPHIC_PERCENT 156
#const ATTR_DAMAGE_GRAPHIC_APPLY_MODE 157
It is worth noting that when assigning sound_event attributes, the new bitCastToFloat function now has to be called (in xs)
For damage sprites, ATTR_DAMAGE_GRAPHICS_ENTRY_MOD works as a position marker.  You can change it to an index within the current array of damage sprites. Defaults to the last element.
When modifying ATTR_DAMAGE_GRAPHIC, ATTR_DAMAGE_GRAPHIC_PERCENT or ATTR_DAMAGE_GRAPHIC_APPLY_MODE, the element at the current marker index will be modified.
When used with MUL_ATTRIBUTE, ATTR_DAMAGE_GRAPHICS_ENTRY_MOD will perform insertion or deletion of an entry at the index specified (edited)
values 0-254 will insert a new empty entry at that index
values -1--255 will delete an entry at that index
ATTR_DAMAGE_GRAPHICS_TOTAL_NUM resizes the array, inserting empty entries if larger and (if reducing size below current position) setting the marker at max valid index 

The Three Kingdoms Update (April 2025)
Math operations to use #const to store numbers and perform simple calculations.
New attribute for objects: require_path.
min_distance_to_players no longer applies a minimum distance to all lands.
create_elevation can now go up to 16.
enable_tile_shuffling is now actually useful to prevent predictable resource spawns in cases where find_closest is being used with set_circular_placement.
The following commands can currently directly accept floating-point values:
terrain_cost
guard_state
effect_amount
effect_percent
New objects. Notably the following:
Huntable chickens (unpushable) with 65 food: WILD_CHICKEN_A, WILD_CHICKEN_B, WILD_CHICKEN_C
Herdable chickens with 65 food: CHICKEN_A, CHICKEN_B, CHICKEN_C
ARGALI as a new standard huntable with 140 food.
New predators: BLACK_BEAR, POLAR_BEAR, ARABIAN_WOLF
New wild animals (no food): WILD_HORSE_B, WILD_HORSE_C, WILD_HORSE_D, WILD_HORSE_E, WILD_MONKEY, WILD_PENGUIN
New trees: LUSH_BAMBOO_TREE, ASIAN_PINE_TREE, PEACH_BLOSSOM_TREE, WILLOW_TREE, ASIAN_MAPLE_GREEN_TREE, ASIAN_MAPLE_AUTUMN_TREE
Felled trees: FELLED_TREE, FELLED_TREE_BAOBAB, FELLED_TREE_BAMBOO, FELLED_TREE_LUSH_BAMBOO
New permanent stumps: BAMBOO_STUMP, BAOBAB_STUMP, LUSH_BAMBOO_STUMP
New constants for existing objects: FIRE_TOWER, CRUSADER_KNIGHT
Idle villagers for use with Empire Wars: idle male villager 1875, idle female villager 1876
New temporary map revealers: Small (4 LOS) 1872, Medium (10 LOS) 1873, Large (20 LOS) 1874
Dedicated placeholder objects:
On-grid generic 1543
On-grid land 1544
On-grid amphibious 1545
On-grid naval 1546
On-grid water 1547
Off-grid generic 1902
Off-grid land 1905
Off-grid amphibious 1909
Off-grid naval 1912
Off-grid water 1921
New terrains: PALM_GRASS_FOREST (existing, but now has a const), LUSH_BAMBOO_FOREST, YELLOW_SHALLOW_WATER, YELLOW_SHALLOW, YELLOW_DEEP_WATER, several pasture terrains
New cliff type (limestone cliffs).
New color correction types.
New attributes: ATTR_OBSTRUCTION_TYPE, ATTR_BLOCKAGE_CLASS, ATTR_SELECTION_EFFECT, ATTR_ATTACK2_GRAPHIC, ATTR_DAMAGE_REFLECTION, ATTR_FRIENDLY_FIRE_DAMAGE, ATTR_REGENERATION_HP_PERCENT, ATTR_BUTTON_ICON_ID, ATTR_SHORT_TOOLTIP_ID, ATTR_EXTENDED_TOOLTIP_ID, ATTR_HOTKEY_ACTION, ATTR_CHARGE_PROJECTILE_ID, ATTR_AVAILABLE_FLAG, ATTR_DISABLED_FLAG, ATTR_ATTACK_PRIORITY, ATTR_INVULNERABILITY_LEVEL, ATTR_GARRISON_FIREPOWER
Two new official random maps, and the code for Nomad, Black Forest and Arena has been rewritten. New included files used by the more recently updated maps.
Added "quickstart" (9 villager) versions of the most popular maps.

Battle for Greece Update (October 2024)
Added many new objects for the new DLC:
3 new civilizations (unranked and single player only) with a unique antiquity tech tree that significantly overhauls water gameplay in particular.  2 new architecture styles.
OYSTERS as a gold source that can be placed on water and amphibious terrains and can be gathered from by villagers and fishing ships.  This is the only new object which has a predefined constant.
The Mouflon (id 2340) as a new deer-equivalent.
A large number of new decorative gaia objects.
Added the ANTIQUITY_MODE conditional, which checks for the antiquity mode lobby setting that enables trading for wood. Many of the official maps have been updated to check for this conditional to decide whether to generate oysters.
Added the CT_MARBLE to get marble cliffs using cliff_type.
Full Tech Mode technology attribute flag 26 added, which restricts the tech to trigger only when the Antiquity Mode lobby flag is active.
Type technology attribute flags 32 and 33 added, the options are now as follows:
0: Normal technologies
2: Shows research progress in the age up bar
32: Building specific upgrade, will only apply the effects to the building it is researched in, and can be researched at multiple instances of the research location separately
33: Repeatable technology, can be researched as long as it is available, even if already researched
Technology cost deduction type flag 2 added, this will only remove a local resource stored on an individual building (paired with Type flag 32)
Added object Store Mode type 16, which stores the resource as a local resource in that individual copy of the object (used for individual building upgrades)
Technology effect types 200 and 201 added, with the following effects:
200: Set attribute value for the local building where the tech applying this effect was researched from
201: Add/subtract from an attribute for the local building where the tech applying this effect was researched from
Additional effects added to the unit Aura Task (Task type 155). These are parameters for the “Search Wait Time” field, with the following effects:
116: Increase melee armor of nearby objects
117: Increase pierce armor of nearby objects
113: Increases conversion resistance of nearby objects
Linked Techs describe techs that are associated in some way. They are defined in linkedTechs,json. There are three types:
Mutually Exclusive Techs – when one tech is researched, the other linked techs will be disabled
Toggleable Techs – allows you to “enable” one tech in a group of technologies
Cycle Techs – cycle through a list of techs, applies effects of selected tech and disables the others
Eras were added to eras.json. Eras allow defining overrides for a civilization. You can override age icons, tech descriptions, and which techs are available in full tech mode. You add the specified era as an option within civilizations.json.
New “speed charge” attack task added, as task 133. For this to work, the unit’s “Special Ability” field must be set to 3. This task uses the following parameters:
Work Value 1: Minimum distance from the target for the speed up to start
Work Value 2: Maximum distance from the target for the speed to start
Work Range: Multiplier on the unit speed while charging
Work Flag 2: This must be set to 2001 for the task to work
April 2024 Update
All scouting units can now use the Auto Scout functionality instead of just the starting one.
Fixed an exploit where one could avoid cracked terrain bonus damage by constructing and deleting a farm before constructing a building on the cracked terrain.
Empire Wars Only: Huns now start without both the -100 wood penalty and the pre-generated houses.
Added eleven new maps that have been created for the Red Bull Wololo: El Reinado tournament

Victors and Vanquished Update (March 2024)
Map sizes reworked.  New conditionals were added to match the in-game names but the legacy conditionals still work as well.
The names of in-game map size options now display their base dimension.
Changed the name of the map size with 240 tiles dimension from Giant to Huge.
Added MORE_MAP_SIZES launch parameter to unlock new map sizes in Editor and Lobbies: Miniature [80], Giant [252], Massive [276], Enormous [300], Colossal [320], Incredible [360], Monstrous [400]. Note that most standard random maps may not correctly support the new map sizes yet.
The game can now boot directly into the Scenario Editor if the EDITOR launch parameter is specified. This can be combined with other parameters (e.g. EDITOR LAUNCH_GAME_VARIANT=AOE1).
The game will no longer crash when clicking on certain gaia objects (neutral market, granary etc.) while having the extended unit stats option enabled. (unlisted update)
Resources tracking player stats (such as P1 Kills, Razed by P3, etc.) now support Gaia, and have been relocated to the 300-499 range.
The x256tech script has been updated to its final version, and a variant called x9tech is now available.

The Mountain Royals Update (October 2023)
cliff_type - Added the new cliff_type parameter for cliff generation, which allows selecting the type of the cliffs to be used on the map. Available options: CT_GRANITE (default setting), CT_DESERT, CT_SNOW.
Units and other objects (such as resources) are now able to be placed under the TC without the need for placeholder objects.
Added second variations (different rotations) to all 3 Pavilions.
Added smaller Bridge A/B pieces, allowing more control over the bridge shape.
New DLC objects
Note that giving a fortified church to players via the map script will not let them research or train anything there.
Armenians get a free relic with their first fortified church.  On maps with 0 relics (ex. forest nothing), relic spawn can be turned off by disabling tech 957 in the map script.  Otherwise Armenians can get an easy relic win.
Value of Resource 270 now determines the repair cost of siege weapons and ships.
Value of Resource 271 now determines the repair cost of buildings.
Value of Resource 272 now allows modifying the damage received by own units when attacked from higher elevation.
Value of Resource 273 now allows modifying the damage received by own units when attacked from lower elevation.
Allowed military units to have conversion ability if they have conversion tasks and the value of resource 279 for the player is higher than 0. The conversion button will appear on the 15th button ID in the command panel; the hotkey can be modified in Military Units hotkey group. The conversion range of military units is controlled by Work Range value in their conversion tasks plus the value of resource 280. Value of Resource 281 determines the conversion success chance per conversion round. Value of Resource 282 determines the faith recharge rate after a successful conversion.
Units can now be spawned garrisoned if at the moment of spawning the value of resource 283 for the player is higher than 0.
Allowed military units to heal other units similar to Monks if they have heal tasks.
Added new Combat Ability attribute flag 64 which allows the unit with power up tasks to power up itself (receiving power up from the units set in the power up tasks). If the unit has several power up tasks, all except the first task need to have Auto Search attribute set to 1.
Allowed making objects with solid obstruction (for example buildings) passable by setting their Unit Size Z attribute to 0.

June Update (2023)
Added a new flag 4 for Blast Attack Level attribute which can disable friendly damage for ranged units with blast attack.
Undocumented updates at some point prior to June 2023:
zone 99 no longer crashes the game
color_correction works again
create_actor_area now no longer has the limitations where it only worked with player objects belonging to player 1
actor areas with a radius of 0 can now be correctly placed in if set_tight_grouping is used.  

Return of Rome Update (May 2023)
Romans civilization available with purchase of Return of Rome DLC.
DE_GAME_ROME and DE_GAME_AGE2 to check for AoE1 vs AoE2.
SOLID_FARMS to check for the lobby option of the same name in AoE1.
New regional unit: Dromon (anti-building siege warship).
Previously existing Centurion and Legionary units have been renamed into Imperial Centurion and Imperial Legionary.
The area healing effect (used by Caravanserai and Stronghold unique technology) no longer stacks from several effect-providing buildings next to each other.
nomad_resources parameter now reimburses the Town Center’s cost (with the cost bonuses taken into account) instead of always adding 275 wood and 100 stone to the starting resources.
GAZELLE (id 1796)  – a new prey animal unit (like a deer)
The behavior of predator animal class units is now controlled by Combat Level attribute: 1: boar-like, 4: wolf-like.
Added new attributes to control previously hardcoded properties:
ATTR_MIN_CONV_MOD (adds to the minimum time to convert the unit).
ATTR_MAX_CONV_MOD (adds to the maximum time to convert the unit).
ATTR_CONV_CHANCE_MOD (reduces the chance to convert the unit per conversion roll).
ATTR_FORMATION_CATEGORY (0: not using formation, 1: mobile, 2: body, 3: ranged, 4: long ranged, 5: protected).
Formation Spacing (controls the spacing between units when in formation).
ATTR_AREA_DAMAGE (multiplier to the percentage of blast damage the non-directly targeted units receive if positive value, fixed number damage if negative).
Removed Blast Attack Level attribute flags 4, 8, 16, 32 as their functionality is now handled by the new Blast Damage attribute.
Allowed modifying several more unit attributes by Effect Amount, Modify Attribute trigger effect and technologies in data. Check tooltips in Advanced Genie Editor for more information about them. 
ATTR_CAN_BE_BUILT_ON (see AGE).
ATTR_FOUNDATION_TERRAIN (see AGE).
Graphic IDs ATTR_ATTACK_GRAPHIC, ATTR_STANDING_GRAPHIC, ATTR_STANDING2_GRAPHIC, ATTR_DYING_GRAPHIC, ATTR_UNDEAD_GRAPHIC, ATTR_WALKING_GRAPHIC, ATTR_RUNNING_GRAPHIC, ATTR_SPECIAL_GRAPHIC.
ENABLE_TECH and GAIA_ENABLE_TECH used by Effect Amount (ID 7, -8 for gaia) has been replaced by SPAWN_UNIT and GAIA_SPAWN_UNIT, which functions similarly to the data version of this effect type. MODIFY_TECH can now be used instead of ENABLE_TECH.
MODIFY_TECH effect is now able to ATTR_SET_STATE of technology. It can be used to disable, enable, force enable or research the specified technology ID.
ATTR_RESEARCH added.
Relic-requiring technologies are no longer hardcoded to IDs 699-703 (used by the Lithuanian cavalry attack bonus). To receive this functionality a technology needs to have its first cost type set to Relics Captured.
The unit cost addition (multiplying the cost attributes by -1) or removal (multiplying the cost attributes by -2) can now be used by technology effects in data.
Data mods are now better supported, including these changes which relate to rms:
It is now possible to define custom random map pools through maps.json in data mods.
Mod-specific loading symbols can now be defined for random maps in the string 8739.
It is now possible to include widgetui/morematerials.json in a non-data mod which will add material definitions on top of the original materials.json file.
The ice beach terrain (ID 37) now uses a unique texture.  Ice shallows and solid ice still share a texture.

April Update (2023)
override_map_size - adjust the map size to anything in the range 36-480.  
This is used by the following official maps to make them one size larger: Archipelago, Islands, Migration, Team Islands, Fortress, Budapest, Pacific Islands, and Sandbank 
generate_for_first_land_only - used on the official double and triple TC maps to only generate one king.
set_facet - to manually pick a frame/rotation/appearance for an object.
It is now possible to update all your created mods in-game if you have more than 50 mods.

August Update (2022)
Added the new set_building_capturable RMS parameter, in order to enable Battle Royale building behavior (allowing the building to be captured many times) in other game modes (without having to upgrade from a monument).
New Red Bull Wololo tournament maps added (Shoals and Morass).
Removed reaction distance modifier for predator animals depending on difficulty and made it so that predator animals always find villagers within 6 tiles and other units within 4 tiles. Easiest difficulty on scenarios and campaigns will still use 4 tiles.
Importing Local Mods doesn’t break Subscribed Mods anymore.
XS files now transfer correctly on either Subscribed or Local Mods (but still don't work for spectators).

April Update (2022)
beach_terrain - place custom beaches in create_terrain commands when the created terrain borders water.
set_circular_placement - changes min_distance_to_players and max_distance_to_players to use the circular (Euclidean) distance, rather than a square radius.
min_distance_to_map_edge - keeps objects away from the edge of the map.
find_closest_to_map_center - place the object on the closest free tile to the center of the map.
find_closest_to_map_edge - place the object on the closest free tile to the edge of the map.
ATTR_SET_STACKING_RESEARCH_CAP - Set a limit on the number of times techs can be stacked when ATTR_SET_STACKING is active.
ATTR_FOG_FLAG - set the fog visibility of an object.  0 Not visible, 1 Always visible, 2 Visible if alive, 3 Inverted visibility, 4 Check doppelganger
Added 1 new terrain - palm forest on grass
Added new DLC objects 
ATTR_GARRISON_TYPE has new flags: 16: livestock, 32: siege units, 64: ships
Added ATTR_SET_HOTKEY, ATTR_STORAGE2_VALUE, ATTR_STORAGE3_VALUE, ATTR_OCCLUSION_MODE, ATTR_RADIUS_3, ATTR_MAX_CHARGE, ATTR_RECHARGE_RATE, ATTR_CHARGE_EVENT, ATTR_COMBAT_ABILITY, ATTR_ATTACK_DISPERSION, ATTR_PROJECTILE2_ID, ATTR_BLOOD_ID, ATTR_HIT_MODE, ATTR_VANISH_MODE, ATTR_PROJECTILE_ARC, ATTR_POPULATION
ATTR_CHARGE_TYPE new options: 3: charge area attack, 4: agility
ATTR_COMBAT_ABILITY new attribute to control several combat unit properties: 1: ignore melee and pierce armors of the targeted unit, 2: resist armor-ignoring attacks, 4: damage the targeted unit’s armor (Obuch ability), 8: attack ground ability, 16: bulk volley release (siege units, kipchaks)
ATTR_TRAITS has new flags: 8: transformable unit, 16: scout unit
ATTR_PIECE controls the constructable building ID for units with trait flag 4, transform unit ID for units with trait flag 8
Added new flag 128 for ATTR_BLAST_LEVEL attribute which limits the blast attack area of the unit to the direction it is facing when attacking
enable_tile_shuffling added for create_object
It is no longer necessary to first record a game in order to open it with CaptureAge
force_nomad_treaty no longer causes recorded games to go out of sync
Khmer no dropsite farmers bonus is now controlled by resource 96
The amount of Town Centers which are allowed to be constructed before they are enabled by technology is now controlled by Early Town Center Limit resource (ID 218)
Starting scout unit ID is now controlled by resource 263
Added new resources which can enable secondary incomes (wood, food, stone) from trade and relics

January Update (2022)
ignore_terrain_restrictions - allow objects to be placed on terrains they normally cannot be placed on. 
make_indestructible - make a building unable to be attacked
ATTR_ATTACK and ATTR_ARMOR now require multiplying the attack/armor class by 65536 instead of 256

November Update (2021)
force_nomad_treaty - adds a treaty that lasts 5 min or until every player has completed a town center.
override_actor_radius_if_required - used to allow folwarks to spawn adjacent to berries in Empire Wars even though they are larger than mills
Added a search box to the map selection screen.
The map selection screen now allows you to press a letter to jump between maps that start with that letter.
Arabia is now based on the King of the Desert tournament version (and is now a very complicated script to look at)
Mod thumbnail images can now be in both PNG and JPG formats.
Secondary game modes (King of the Hill, Regicide, Empire Wars) can now be selected from the victory tab in the scenario editor.  (useful for testing)
Show simple tooltips for units enabled by effect_amount, which don’t usually show tooltips (e.g. when enabling sheep to be trained in a mill, a tooltip can now show the cost of the unit).
Fixed a rare crash in the Scenario Editor when repeatedly generating maps with specific characteristics.

October Update (2021)
Feitoria and Trade Workshop productivity now use separate sets of resources (205-208 and 242-245, respectively)
The constants for the Trade Workshop resource trickle are now pre-defined
More maps from the Red Bull Wololo tournament are now officially part of the game
The min_connected_tiles parameter now properly works for all players when using behavior_version 2.  But it is still buggy overall.

Dawn of the Dukes Update (August 2021)
Added create_actor_area to create actor areas without creating a (placeholder) object
Added 2 new terrains
Mud terrain is now brown on the minimap (was green)
"Fixed a performance issue that occurred during the first few seconds of gameplay on many Random Map Scripts"
A new color_correction (night) is available
New objects (units, heroes, buildings) from the DLC are added
Arabia terrain and objects generation overhauled

July Update (2021)
min_connected_tiles and accumulate_connections added
Implemented guard_state from UP
ATTR_SET_NAME ATTR_SET_DESCRIPTION ATTR_SET_STACKING added
Red Bull Wololo maps added and their Empire Wars standards adopted
Custom map icons are now possible by just including a png of the same name in the same folder as your map!
Direct placement maps no longer break random placement maps in the scenario editor!
set_avoid_player_start_areas now allows using a distance parameter
Fixed a bug where maximum value in rnd(min,max) was exclusive if min was 0
actor_area_to_place_in no longer disables max_distance_to_players
force_placement in small actor areas no longer produces excess objects
place_on_forest_zone now correctly places buildings larger than 1×1 tiles
Packing a Town Center in Battle Royale now works correctly and no longer causes a crash.  Also, packed town centers can no longer be unpacked on obstructions
Fishing Ships now automatically start working in Empire Wars
Laming straggler trees is no longer possible unless a villager actually begins construction
Dolphin can no longer be built on
Tatar sheep, Chinese and Mayan villager, and Inca llama spawn bonuses now work correctly on nomad starts in Castle age or higher
Sea Walls now generate Sea Gates
Scripts using many actor areas will load (slightly) faster
Fixed an issue that caused scripts using a small actor_area to occasionally fail to spawn the desired number of objects.
The hero status attribute now controls hero glow. Hero glow now appears for units with full hero status (1) or with the new hero glow flag (64).
Added a new Hero Status flag (128) which can invert properties of other Hero Status flags assigned to the unit (except flag 1).
The Regeneration Rate attribute now affects units with hero regeneration. The rates from both regenerations sum with each other.
The tech modification trigger effects added in our November Update, including Change Technology Name, Change Technology Description, and Enable/Disable Technology Stacking can now be used with the MODIFY_TECH effect in effect_amount.
April Update (May 2021)
ATTR_BLAST_DEFENSE ATTR_HOTKEY_ID ATTR_REGENERATION_RATE added
Added new flags for Hero Status attribute to control hero properties individually:
2: cannot be converted
4: auto-healing
8: default defensive stance
16: protected formation
32: safe delete confirmation
The flags can be combined with each other, or flag 1 can be used to enable full hero status.
The Regeneration Rate attribute now determines the number of hit points a given unit regenerates in a minute. The Regeneration task in the unit data is no longer required. The Regeneration Rate attribute has no effect for units with Hero Status flag 1 (full hero status) or 2 (auto-healing), which regenerate at the fixed 30 hit points/min rate.
Scenario editor should no longer crash when reducing the map size.

March Update (2021)
Scenario editor black terrain crashes fixed (other occasional crashes still occur)
effect_percent fixed

Lords of the West Update (January 2020)
Scenario Editor STILL broken - use the singleplayer to test instead
effect_amount fully implemented - please report any bugs you discover.
effect_percent implemented - But is bugged in that it rounds too early
In King of the Hill games, resource generation via Monuments is now enabled by default.
It can supposedly be turned off by using effect_amount to disable technology 729, but I have not been able to confirm this.
You can now remove the monument resources object (1639) from all of your maps, because it is no longer necessary.
#includeXS has been added to load .xs scripts for random maps. Official documentation: .xs scripting in Age of Empires II: Definitive Edition; community documentation: XS Scripting For Beginners
Many new constants were defined, including all the relevant effect constants, and constants for feudal/castle/imperial -age versions of buildings (see: Constant Reference)
Two new civilizations added, along with the associated units and objects (see: Objects)
Great Fish (Marlin) can no longer be deleted by Dock foundations

Anniversary Update (Nov 2020)
Empire Wars standard villager distribution changed (less on farms), and sheep removed
behavior_version command added
Conditionals for starting age added
Scenario Editor broken - use the singleplayer to test instead
Battle Royale game mode implemented, along with one new terrain.

August 2020 Update
The map seeds from recorded games can now be used to generate the same map in the Scenario Editor.

May 2020 Update
The number_of_tiles and land_percent commands no longer create larger lands than intended. (This affected a few standard maps, such as Arena.)

April 2020 Update
Maps using resource_delta will now accurately display HP bars over resources.
Increased the limit of objects and lands that can be generated through RMS from 99 to 100,000.
Added enable_balanced_elevation command to improve hill generation in Random Map Scripts.
Added effect_amount to modify resource values (such a starting resource) through RMS.
February 2020 Update
Capture the Relic: The game will no longer spawn a second Monastery if the map has already spawned one for a player.
Capture the Relic: Fixed an issue where Monasteries could spawn into the map with a “more on-fire than intended” amount of health.
Regicide: Will now properly adjust resource numbers based on whether the host chooses Low, Standard, or High resources. (Infinite is still infinite.)
assign_to command has been added. This can be used to assign a land to a player, color, or team in combination with direct_placement.
The Random Map game mode can now be detected using the RANDOM_MAP identifier.
One big change for the modding community is the ability for users to publish their mods as Unlisted: An Unlisted mod is not publicly available for users to find and download. It will, however, download automatically when a user joins a lobby where the mod is being run.
January 2020 Update
King of the Hill: The monument now generates resources for the controlling player.
Sudden Death can now be used as an identifier for custom RMS scripts.
Random maps can now place buildings on terrains without terrain restrictions.
Random maps now generate the correct Gate types for all Wall types.
Capture the Relic: Custom Nomad scripts will now allow the player to build a Monastery if the map doesn’t start with one.
Testing Random Map Scripts in the scenario editor now works correctly when teams are set using diplomacy settings.
A new command avoid_cliff_zone has been added to help prevent objects from appearing too close to cliffs. The distance can be set by using the same format as the avoid_forest_zone command.
Fixed an issue where setting land_percent to 100 would occasionally fail to generate land on all available tiles. (For example, this would sometimes result in random patches of water on Highland.)
The command, set_scaling_to_player_number, now works correctly when a map is generated in the scenario editor.
The command, circle_radius, now supports a secondary value to define the variance of the circle. For example, circle_radius 20 1 would create a circle with radius 20 and variance 1.
The file random_map.def now includes several new terrain constants:
ICYSHORE
DLC_WETROCKBEACH
DLC_GRAVELBEACH
DLC_WETBEACH
DLC_REEDSBEACH
MEDITERRANEAN_FOREST
CYPRESS_TREE
ITALIAN_PINETREE
OLIVE_TREE
AoC Color Palette

Magic Numbers
A few noteworthy numbers.

9320 - the maximum number of objects/clumps that can be scaled to map size without breaking for ludicrous map size.

32768 = 2^15 - the maximum unit HP.
Also the maximum amount of resources per node (pre-DE)
Also the maximum value that can be used in effect_amount (pre-DE).

16777216 = 2^24 - the maximum value that can be accurately stored with #const in DE.

2147483647 = 2^31 - the maximum amount of resources per node in DE (with resource_delta).

4294967296 = 2^32 - the maximum terrain_cost that seems to change connection behavior.

-949671966 - a number that gives a highly regular pattern for clumping_factor (lands) due to unknown (algorithmic) reasons.
DE Constant Translations
The lead random map scripter at Forgotten Empires is Czech, consequently some of the constants used might not make sense to an English speaker.  Below are the main shared constants used by the standard maps (and defined in F_seasons.inc so that they can vary for each season.)
HERDABLE_A: close sheep or other convertible animals
HERDABLE_B: further sheep or other convertible animals
LURABLE_A: Boar or similar animal that can be lured
LURABLE_B: Boar or similar animal that can be lured
HUNTABLE: Deer or other passive huntable animals
PREDATOR_A: wolf or aggressive animal
PREDATOR_B: wolf or aggressive animal
BIRDS_A: a hawk or other type of bird
BIRDS_B: a hawk or other type of bird
MELKARYBA: small fish, ie. shore fish or box turtles
FISH_A: a type of standard fish (225 food)
FISH_B: a type of standard fish (225 food)
KERICEK: berry or fruit bushes
VODA: water 
MELCINA: shallows
CESTA: path/road
WOODIES: primary forest
WOODIES_B: secondary forest
WOODIES_C: tertiary forest
LAYER_A: main terrain
LAYER_B: secondary terrain (used for patches)
LAYER_C: tertiary terrain (used for patches)
LAYER_E: further land terrains
LAYER_F: further land terrains
STRAGGLER: individual tree
BLANKOBJECT: invisible placeholder used to help spread out resource generation
Evil Fog Terrain Texture Specifications
This information concerns the evil fog terrain (ID 69) texture, added in DE for Battle Royale. The information below is from the developer StepS.  It is not relevant for random map scripting, but could be useful if you wish to make a terrain texture mod.
there are several thresholds for alpha
maximum opaqueness is 0.75 (192/256) that is the dark background
maximum alpha for the cracks is <0.5 (127/256) that are filled with blood
meaning, 128-192 are interpreted as something that does not need to be filled with blood, yet still needs red fog treatment
0-127 meaning it is filled with blood
I have a tool that converts a grayscale DDS into this with configurable white threshold
where white is background, black foreground
(in the process everything becomes opacity levels of black)
basically you have two levels, the background in the 128-192 alpha range and  the foreground in 0-127
white_to_corruption_alpha.exe
testtexture.dds
it supports only the dds in that format and no mipmaps
you can specify white threshold, that means values of white after a certain maximum will be flattened to the max of the "background" range
basically white level of 255 (default threshold) means it will become 192, aka the background
while anything below 255 will be divided by 2, to become part of the 0-127 alpha, aka the blood
if the threshold is set at lower values that means higher whites are all flattened to 192
If someone wants to reimplement this conversion it's really simple. Basically do something like this on every pixel in the DDS
a = r < threshold ? r / 2 : 192;
r = 0;
g = 0;
b = 0;
you can experiment with spreading the bg across the 128-192 range too
Temporary Map Location
In AoC and HD, maps are transferred from the host to the client and end up in the main random maps folder within your game directory.  The advantage of this is that you can easily find any custom map you ever played on.  The disadvantage is that you will get a desync if your map has the same name but is different from the host's version.

In DE, maps are instead transferred to AppData\Local\Temp\AOE2DE_Temp\resources\_common\random-map-scripts where they are only stored until you exit the game.
String Dump from the exe
This information may or may not give some insight into how the random map generator code actually works internally:
String dump from the exe
Non-Functional Syntax
These things were discovered by searching the non-localized-key-value-strings-utf8.txt file in HD/DE.  None of these appear to do anything, based on what is currently known.  If you discover anything, please let me know!
#undefine
#include
min_distance
max_distance
set_position
percent_of_land
Balanced Elevation Comparison

Courtesy of T-West
Circle Radius Comparison

Courtesy of T-West
Special Note for WololoKingdoms HD
Some of the existing terrains are changed.  The predefined constants have been updated, but if you are defining manually (with #const), you will need to address it manually yourself.  See also WololoKingdoms Terrain Conversions
Terrain 11 (formerly dirt2) is now mangrove shallows, but you can use terrain 27 (foundation dirt) to get the same look.
Terrain 38 (formerly snow road) is now cracked dirt, but terrain 33 is now snow road, so you can use that.
Terrain 33 (formerly snow dirt) is now snow road but you can use terrain 36 (foundation snow) to get the same look.
Terrain 20 (formerly oak forest) is now mangrove forest, but you can use terrain 10 (forest) to get the same look.
Terrain 16 (formerly cliff grass) is now baobab forest, but you can use terrain 0 (grass) for the same look, or pick a new terrain of your choice.
Terrain 41 (formerly buggy and unused) is now acacia forest.
Zipped Random Maps (UP Only)
UserPatch 1.5 allows players to create ZR maps.  These are zip files containing an rms, as well as potentially a scenario (scx) and/or custom terrain textures (in the slp format).  This allows you to create "Real World"-style maps for UserPatch.  The scenario takes the place of the land generation section and can be used to place terrains and objects as well.  The rms then acts on the scenario.  This is only supported on the UserPatch.
UP ZipRmsFiles Documentation
(from \Reference\Scripting\ZipRmsFiles.txt within your UserPatch install directory)

;--------------------------------------
; Zip Random Map Script Notes
;--------------------------------------
To create a valid zip-rms (ZR) file, please note the following:
- you must include 1 valid rms text file
- you can include 1 scx file if this will be a Real World Map
- you can include any terrain override slps between 15000.slp and 15049.slp
- add all of these files into a zip file with no compression (store)
- there should be no folder paths for files within the zip file structure
- name the zip file "ZR@YourMapName.rms" (change extension from .zip to .rms)
- the ZR@ prefix is required for the game to load a zip-rms file
- place the new rms file into your Random folder (or Script.RM for expansions)
- select it from the Custom map list and play the game as usual

To generate the rms zip with the 7zip command line tool, 7z.exe:
- 7z.exe a -mx0 -tzip "ZR@YourMapNameHere.rms" your-map.rms your-map.scx 15000.slp 15002.slp

;--------------------------------------
; Custom Real World Map Notes
;--------------------------------------
To create a real world map zip-rms, please note the following:
- the rms file should not have <LAND_GENERATION> unless direct_placement is used
- the direct_placement system is provided by default for all custom real world maps
- if direct_placement is used, please see below for <LAND_GENERATION> details
- the scx file should have 1 town-center per player to set starting positions
- you can only generate the rms part of ZR@ maps in the scenario editor
- for King of the Hill, you can place a gaia monument on the scx map
- trees and other gaia objects like gold can be placed on the scx map
- other than town-centers, no player objects should be placed on the scx map
- players are placed randomly if the Team Together option is unchecked
- players are placed sequentially (first is random) with Team Together checked
- you must use Team Together if less than 8 starting positions are defined

To have proper team placement for 1v1, 2v2, 3v3, or 4v4 games:
- enable Team Together to place players sequentially (first location is random)
- alternate team numbers on the setup screen: 1, 2, 1, 2, 1, 2, 1, 2
- to support all team setups, place players in the scx like this:

__3__
_5_7_
1___2
_8_6_
__4__

;--------------------------------------
; Direct Placement Notes
;--------------------------------------
To use direct_placement in the rms of a real world map:
- include a <LAND_GENERATION> section in your rms file
- do not include a town-center for each player in your scx file
- under <LAND_GENERATION>, add this: base_terrain REAL_TERRAIN
- use assign_to_player and land_position to place each player with create_land
- use X_PLAYER_GAME consts like 8_PLAYER_GAME with "if" to adjust the layout

#const REAL_TERRAIN -1

<PLAYER_SETUP>
    direct_placement
    ai_info_map_type BLACK_FOREST 0 0 0

<LAND_GENERATION>
    base_terrain REAL_TERRAIN

if 2_PLAYER_GAME
    create_land
    {
   	 land_percent 2
   	 base_size 6
   	 assign_to_player 1
   	 land_position 25 25 /* toward the left of the map */
    }
    create_land
    {
   	 land_percent 2
   	 base_size 6
   	 assign_to_player 2
   	 land_position 75 75 /* toward the right of the map */
    }
endif
Screenshot of how to create a Zipped RMS

Link to the full-sized image

Miscellaneous Links
Additional outdated links can be found archived in this post
Older Lists and Spreadsheets
Will be missing info on DE
Terrain Reference Sheet
Terrain Names Spreadsheet
Definitive Constants List
Advanced Constant Numbers List
Complete Constant Lists
Older Guides
Dated, and may no longer be accurate
New RMS Stuff a temporary doc that I made to cover all the things that were new in DE
Checking your map Long version Short version
RMS Step by Step Tutorial - archived here and copied here 
How Connection Generation Really Works (archived)
RMS Mountain Making Tips
Random Map Scripting Q & A by: Dr. Greg Street (ES_Deathshrimp), Conquerors Lead Designer - archived part 1 and part 2
More undocumented RM scripting commands
New RMS Guide (outdated)
Updated New RMS Guide (outdated, but still relevant for HD/UP1.4)

Terrain Replacement Example Image
Using repeated terrain replacement to get rid of small terrain patches:


RMS Effects in detail
This is a planned new chapter that will go into detail about the usage of effect_amount and effect_percent in modifying all of the possible attributes, and provide examples.  For now, take a look at: Attributes - AoE2DE UGC Guide

WORK IN PROGRESS

ATTR_CREATE_SDESC_ID
[desired string ID] - 20000 to get the value you need

ATTR_ATTACK
ATTR_ARMOR
256*class ID of the armor/attack you want to change
