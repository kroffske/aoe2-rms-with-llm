A Comprehensive Guide to Age of Empires II Random Map Scripting

Introduction: The Art and Science of Random Map Scripting

Random Map Scripting, or RMS, is the powerful, text-based system at the heart of Age of Empires II's infinite replayability. It is the engine that generates the iconic, varied landscapes for maps like Arabia, Black Forest, and Coastal. Unlike the in-game Scenario Editor, which creates static, handcrafted experiences, RMS provides a set of instructions for the game to construct a unique, procedurally generated map every time it is loaded. Mastering RMS is to move from painting a single scene to designing the machinery that can paint infinite landscapes—it's the difference between making a map and becoming a mapsmith. This guide serves as a comprehensive manual for the serious modder, walking you through every stage of the process, from initial setup to advanced techniques for creating dynamic and competitive battlegrounds.

A Random Map Script is a plain text file with a .rms extension, created and edited in a simple text editor like Notepad. Its purpose is to direct the game's map generation engine through a sequential process of creating landmasses, sculpting elevation, painting terrain, and finally, populating the world with players, resources, and wildlife. Every line of code in an RMS file is a command that shapes the final outcome, giving you precise control over the rules that govern the randomness.

The core philosophy of RMS creation is an iterative cycle of scripting, generating, and testing. A map scripter writes or modifies a piece of code, saves the file, generates the map in the game's Scenario Editor to see the results, and then returns to the script to make further adjustments. This tight feedback loop is fundamental to the craft, allowing for rapid experimentation and refinement.

This guide is structured to build your knowledge progressively. We will begin by establishing a proper development environment, move through the core workflow of testing your first map, and then deconstruct the anatomy of an RMS file. From there, we will master each stage of generation—land, elevation, terrain, and objects—before exploring the advanced logic that can make your maps truly dynamic. By the end, you will be prepared to tackle any creative challenge and share your creations with the world.


--------------------------------------------------------------------------------


1. Setting Up Your Development Environment

Before writing a single line of code, establishing a properly configured development environment is crucial for an efficient and frustration-free scripting process. This section covers the essential first steps every map scripter must take, from locating the correct game folders to choosing the right tools for the job.

Critical File Locations

The game reads map scripts from two primary locations. It is vital to work within the correct directory to ensure your custom maps are detected by the game. For the Steam version of Age of Empires II: Definitive Edition, these paths are:

* Official Scripts: AoE2DE\resources\_common\drs\gamedata_x2 This folder contains the .rms files for all official maps. It is an invaluable resource for studying professional scripts, but you should never edit these files directly. Doing so can corrupt your game installation. Always make a copy and move it to your custom scripts folder to work on.
* Custom Scripts: AoE2DE\resources\_common\random-map-scripts This is the designated folder for all user-created maps. Any .rms file placed here will be recognized by the game and appear in the map selection dropdown.

Creating Your First Script File

To begin, simply create a new text file using an application like Notepad. When you save it, ensure you change the file extension from .txt to .rms. For example, a file named my_first_map.txt should be saved as my_first_map.rms. Once saved, move this file into the random-map-scripts folder detailed above. The game will now be able to find and generate your map.

Essential Tools

While any text editor will work, using a more advanced editor is highly recommended. Tools like Notepad++ or Visual Studio Code offer a feature called syntax highlighting, which colors different parts of your code based on their function. This is invaluable for spotting typos, understanding script structure at a glance, and dramatically improving the overall scripting experience. Community-made syntax highlighters are available for most popular editors.

With your environment configured and your first file created, you are now ready to see it in action. The next step is to launch the game and learn the practical workflow for testing your script.


--------------------------------------------------------------------------------


2. The Scripting Workflow: Generating and Testing Your First Map

The in-game Scenario Editor is the primary tool for testing and debugging a Random Map Script. The core of RMS development is a rapid feedback loop of writing code, generating the map, observing the result, and refining the script. Mastering this workflow is fundamental to efficient map creation.

Generating a Map in the Scenario Editor

Follow these steps to generate your custom map for the first time:

1. Launch Age of Empires II: DE.
2. Navigate to Single Player -> Editors.
3. In the Scenario Editor, click Map in the top menu bar.
4. In the Map window, check the Random Map checkbox.
5. Find and select your script file from the Random Map Location dropdown menu. It will appear with the filename you gave it (e.g., my_first_map).
6. Select a Map Size for testing. Tiny is recommended for initial tests as it generates the fastest.
7. Click the Generate button.

The game will now execute your .rms file and display the resulting map. If your file is empty, it will likely generate nothing or a default map.

The Iterative Testing Process

One of the most powerful aspects of this workflow is that you do not need to restart the game to see your changes. After editing and saving your .rms file in your text editor, you can simply return to the Scenario Editor and click Generate again. The game will re-read the script and produce a new map reflecting your latest modifications. This allows for quick, iterative development.

Using a Fixed Map Seed for Debugging

When generating a random map, the game uses a "seed" number to initialize its random number generator. By default, a new seed is used each time, resulting in a different layout. However, for debugging, it is crucial to isolate variables.

By checking the "Seed Map" box in the Map window, you can lock the seed value. This forces the game to generate the exact same "random" map every time you click Generate. Using a fixed seed is non-negotiable for serious debugging. It eliminates randomness as a variable, allowing you to see the direct, unambiguous impact of your code changes. If you alter a spacing value and a gold mine moves, you'll know your code did it, not a different roll of the dice.

Now that the fundamental workflow of scripting and testing is established, we can begin to explore the actual components and syntax that make up an RMS file.


--------------------------------------------------------------------------------


3. The Anatomy of an RMS File: Core Structure and Syntax

Every Random Map Script follows a specific structure and syntax that the game's parser can understand. The generation process is sequential, with the script being read from top to bottom. This section deconstructs a script into its essential components, providing the foundational knowledge needed to read and write your own maps.

Primary Generation Sections

An RMS file is organized into distinct sections, each enclosed in angled brackets (e.g., <LAND_GENERATION>). Each section is responsible for a specific stage of the map's creation, and they are typically executed in this order:

* <PLAYER_SETUP>: Defines player configuration, team layouts, and other global map rules before any generation begins. This is where you set game-wide parameters like nomad_resources or grouped_by_team.
* <LAND_GENERATION>: Creates the foundational landmasses and bodies of water. This section forms the basic canvas of the map.
* <ELEVATION_GENERATION>: Adds hills, mountains, and other height variations to the previously generated land.
* <TERRAIN_GENERATION>: Places patches of specific terrains, such as forests, deserts, beaches, and patches of dirt or grass.
* <CONNECTION_GENERATION>: Creates guaranteed paths or roads between different parts of the map, such as connecting allied players.
* <OBJECTS_GENERATION>: Populates the map with all interactive elements, including player Town Centers, units, resources (gold, stone, food), relics, and decorative eye-candy.

Basic Command Syntax

Within each section, you write commands that instruct the game on what to generate. The syntax follows a simple pattern:

command { attribute argument }

* Commands are the primary actions, like create_land or create_object.
* Attributes are properties that modify the command, such as terrain_type or number_of_objects.
* Arguments are the specific values assigned to attributes, like DIRT or 10.

Curly brackets {} are essential for defining the scope of a command, enclosing all of its attributes. Whitespace and newlines are flexible, allowing you to format the code for readability.

Constants and Comments

To make scripts more readable and manageable, RMS supports constants and comments.

* Constants: The game recognizes objects and terrains by numeric IDs. Using #const or #define allows you to assign a human-readable name to these numbers. For example, #const DIRT2 11 lets you use the word DIRT2 in your script instead of remembering the number 11.
* Comments: You can leave notes for yourself or others within the script that the game will ignore. Comments are enclosed in /* and */. This is a critical tool for explaining complex code or temporarily disabling parts of a script for debugging.

With this structural understanding, we can proceed to the first and most critical step in creating a world: defining its fundamental geography in the <LAND_GENERATION> section.


--------------------------------------------------------------------------------


4. Mastering Land Generation: Crafting Your Canvas (<LAND_GENERATION>)

The <LAND_GENERATION> section is the most critical first step in map creation. It defines the fundamental geography of the world—the continents, islands, and oceans upon which everything else will be built. Every command here shapes the macro-strategic feel of the map.

The base_terrain Command

The first and most important command in this section is base_terrain. This command sets the "canvas" of the map, defining the default terrain that covers the entire area before any specific landmasses are added. A single change to this command can completely transform a map's identity. Changing a script from base_terrain WATER to base_terrain DESERT instantly flips the concept from an islands map to a land-based desert map.

Placing Land: create_player_lands vs. create_land

Once the canvas is set, you use commands to generate land on top of it. There are two primary commands for this, each with a distinct purpose.

Command	Purpose	Key Use Case
create_player_lands	Generates a dedicated landmass for each player in the game.	Creating the starting continents or islands where players will begin.
create_land	Generates a single, neutral landmass not tied to any specific player.	Creating shared central islands, neutral continents, or decorative land features.

Key Attributes for Controlling Land Generation

You can control the shape, size, and position of these lands with a powerful set of attributes:

* terrain_type: Defines the terrain of the land being created (e.g., DIRT, GRASS). This will be placed on top of the base_terrain.
* land_percent vs. number_of_tiles: These attributes control the size of the land. land_percent defines the size as a percentage of the total map area, which scales well with different map sizes. number_of_tiles sets a fixed size, offering more precise control but requiring manual adjustments for different map sizes.
* land_position: Places the center of a landmass at specific X/Y coordinates on the map, giving you explicit positional control.
* circle_radius: Used in create_player_lands, this attribute controls how far player starting lands are from the map's center. A smaller radius creates a tighter, more aggressive map, while a larger one spreads players out. This is the key attribute responsible for the distinct circular or ring-like placement of Town Centers seen in modern competitive maps—a stark contrast to the older, more rectangular layouts, as shown in T-West's analysis.
* zone and other_zone_avoidance_distance: The zone attribute assigns a landmass to a numbered group. Lands in the same zone are allowed to merge and grow together, forming a single continent. By placing lands in different zones and setting an other_zone_avoidance_distance, you can ensure they remain separate. This is useful for creating distinct islands or keeping player lands from touching a central feature.
* base_elevation: This powerful attribute sets an entire landmass to a specific height level. You can use it to create elevated plateaus that are naturally defensible or sunken basins that are vulnerable.

Once the foundational lands are defined and positioned, the map has its core shape. The next step is to add topographical and textural detail, giving the world its unique character and strategic depth.


--------------------------------------------------------------------------------


5. Sculpting the World: Elevation and Terrains (<ELEVATION_GENERATION> & <TERRAIN_GENERATION>)

After defining the basic landmasses, the world is still flat and visually monotonous. This section covers the two key processes—elevation generation and terrain generation—that sculpt the landscape, add texture, and introduce strategic features like hills and forests.

Deconstructing <ELEVATION_GENERATION>

This section is dedicated to adding verticality to your map.

* The primary command is create_elevation. The first argument sets the maximum height of the hills (e.g., create_elevation 7 creates hills up to 7 tiles high).
* In Definitive Edition, it is critical to include the enable_balanced_elevation command. The original game engine has a significant southern bias, causing hills to cluster unfairly in the bottom half of the map, a well-documented issue that impacted competitive play for years. This command corrects that bias, ensuring a far more balanced and strategically fair distribution of elevation across the entire map.
* Just like in other sections, you must specify the base_terrain you are adding hills to. If your players are on GRASS land, you must target GRASS to place hills there.

Analyzing <TERRAIN_GENERATION> for Surface Features

This section is where you "paint" features onto your base lands. Pay close attention here, as this is where many new scripts fail.

* The workhorse command is create_terrain, which is used to place patches of features like FOREST, PALM_DESERT, or BEACH.
* Precise control is achieved through a variety of attributes:
  * base_terrain: Again, this is essential. It specifies the underlying terrain on which you are placing the new feature. To place a forest on a dirt landmass, you must specify base_terrain DIRT. This is a classic rookie mistake.
  * number_of_clumps and land_percent: These attributes work together to control the distribution and total area of the new terrain. number_of_clumps determines how many separate patches are created, while land_percent defines the total percentage of the base_terrain they should cover.
  * set_scale_by_groups: This is a crucial attribute for ensuring your map plays well on different sizes. It automatically scales the number_of_clumps based on the map size, so a huge map will have proportionally more forest patches than a tiny one.
  * spacing_to_other_terrain_types: This creates a buffer zone, preventing different terrain types from touching. For example, you could use this to ensure a path exists between your Palm forests and your Pine forests.
  * set_avoid_player_start_areas: A crucial command for competitive balance, it prevents features like forests or resource patches from spawning too close to a player's starting Town Center, ensuring they have room to build.
  * height_limits: This attribute restricts terrain placement to specific elevation levels. This allows you to create features like hilltop forests, forests that only grow in valleys, or oases that only appear at sea level.

A well-sculpted map provides a strategic and visually interesting environment. With the landscape now defined, the stage is set for the final layer of detail: the objects and resources that players will directly interact with.


--------------------------------------------------------------------------------


6. Populating the Map: Objects and Resources (<OBJECTS_GENERATION>)

The <OBJECTS_GENERATION> section is where the map comes to life and becomes playable. This is where you add every interactive element, from each player's starting Town Center and villagers to all the gold mines, stone piles, relics, huntable animals, and forage bushes that will fuel their economies and armies.

The primary command for this section is create_object. The order in which you list your create_object commands is critical. The game places objects sequentially, one after another. If space becomes limited, objects placed later in the script may fail to spawn. Therefore, you should always place the most important objects, like player Town Centers and starting resources, first.

Essential Attributes for Player-Specific Objects

These attributes are used to ensure every player receives their necessary starting units and resources:

* set_place_for_every_player: This is the core command for creating objects tied to each player's starting land. When this is active, the specified number of objects will be generated for every player in the game.
* set_gaia_object_only: When placing objects that cannot be owned by a player (like gold, stone, boars, or relics) for every player, this attribute is also required. It assigns the object to Gaia but ensures it is placed relative to each player's starting position.
* min_distance_to_players and max_distance_to_players: These attributes define a placement "ring" around each player's starting location. This is crucial for placing starting resources at a fair and consistent distance, ensuring no player gets an unfair advantage with gold or food that is too close or too far away.

Controlling Object Spacing and Distribution

Properly spacing objects across the map is key to creating a balanced experience. Two powerful attributes control this, but they have a critical difference in behavior.

Attribute	Behavior	Use Case Example
temp_min_distance_group_placement	Temporary: Sets a minimum distance between objects created within the same create_object command. This effect is not "sticky" and does not affect any subsequent commands.	Spacing out individual boars from each other to ensure they are evenly distributed across the map.
min_distance_group_placement	Persistent ('Sticky') and Cumulative: Sets a minimum distance that applies to its own objects and all subsequent objects placed later in the script. This effect accumulates with each subsequent min_distance_group_placement command, creating increasingly restrictive placement zones as the script progresses.	This 'sticky' behavior is a common tripwire for new scripters. If you set a large spacing value for boars early on, you might find your script struggling to place stone mines later, as it's trying to respect the large, lingering avoidance distance set by the boars. This cumulative effect can starve later objects of valid spawn locations, so use it with surgical precision.

* Grouping Attributes: number_of_objects, number_of_groups, and set_tight_grouping work together to create resource nodes. For example, to create a standard 7-tile gold mine, you would use number_of_objects 7, number_of_groups 1, and set_tight_grouping.

Controlling Placement by Terrain

You can restrict where objects can spawn to create thematic and strategic placements.

* terrain_to_place_on: This attribute ensures an object can only be placed on a specific terrain type. This is perfect for making sure fish spawn in water or that a special resource only appears on desert sand.
* avoid_forest_zone: A useful attribute that prevents objects from spawning inside dense forests where they would be inaccessible to villagers.

Mastering object placement is the final step in crafting a balanced, fair, and engaging map. However, to create truly sophisticated and replayable maps, we sometimes need more complex logic and explicit connections between different map areas.


--------------------------------------------------------------------------------


7. Advanced Scripting: Logic, Randomness, and Connections

Advanced scripts elevate map creation from a static process to a form of dynamic, intelligent design. By using conditional logic and controlled randomness, a scripter can build maps that adapt to game settings, introduce compelling variety, and ensure functional layouts for specific strategic goals.

Conditional Statements

The if, elseif, else, and endif structure allows your script to execute different code blocks based on the game's lobby settings. This is essential for creating robust maps that scale properly for different numbers of players or map sizes.

* Common conditions include checking for player count or map size:
  * Player Count: 2_PLAYER_GAME, 4_PLAYER_GAME, 8_PLAYER_GAME, etc.
  * Map Size: TINY_MAP, HUGE_MAP, GIGANTIC_MAP, etc.

This allows you to create rules that scale resource or feature density. For example, you can ensure a huge map has significantly more forest clumps than a tiny one:

if HUGE_MAP
  number_of_clumps 60
else
  number_of_clumps 20
endif


Controlled Randomness

While the entire map is "random," you can introduce specific points of high-impact variation using the random chance structure. The start_random, percent_chance, and end_random commands allow you to define several possible outcomes and the probability of each one occurring.

For instance, on a Coastal-style map, you could use this structure to create three different versions of the map with varying amounts of land, making each playthrough feel distinct:

start_random
  percent_chance 40 land_percent 52 /* Most likely outcome */
  percent_chance 30 land_percent 40 /* Less land */
  percent_chance 29 land_percent 25 /* Mostly water */
end_random


This adds significant replayability beyond simple positional changes. Note that if the percentages do not sum to 100, there is a chance none of the options are chosen.

Ensuring Connectivity: <CONNECTION_GENERATION>

Sometimes, you need to guarantee that players can reach certain areas. The <CONNECTION_GENERATION> section is designed to create explicit paths between landmasses, which is particularly useful for team games or maps with complex geography.

* Its primary purpose is to create guaranteed paths, often by replacing existing terrain with a road or shallow water.
* Key commands like create_connect_teams_lands will automatically generate a path connecting the starting lands of all players on the same team, ensuring allies are not cut off from one another. Attributes like replace_terrain define what the path is made of.

With these advanced tools, a scripter can build highly robust, varied, and intelligently designed maps. The final step is to apply some polish, debug any issues, and share the finished creation with the community.


--------------------------------------------------------------------------------


8. Finalizing and Publishing Your Map

Moving from a functional script to a polished, distributable mod is the final phase of the map-making process. This involves careful debugging, preparing the files for upload, and adding professional touches like a custom icon.

Practical Debugging Checklist

When your map isn't generating as expected, use these systematic techniques to diagnose the problem:

* Use a Fixed Seed: Lock the map seed in the Scenario Editor. This makes the "random" generation predictable, allowing you to reliably reproduce and isolate the bug.
* Comment Out Code: Use /* ... */ to temporarily disable large sections of your script. If the problem disappears, you know the error is within the commented-out block. You can narrow it down from there.
* Visualize Spawn Areas: To visualize all possible spawn locations for an object, use a 'flood fill' debugging trick. Temporarily set its number_of_objects to an absurdly high value like 10000. The map will fill with that object, instantly revealing every valid tile it can spawn on and helping you diagnose issues with terrain restrictions or spacing.
* Visualize Land and Paths: Use a brightly colored, unused terrain as a placeholder to visualize land generation or connection paths. For example, temporarily make a new landmass out of SNOW to see its exact shape and size on the minimap.

Publishing to the Mod Repository

To share your map with the wider community, you should package it as a mod. This requires a specific folder structure within your local mods directory:

1. Navigate to your local mods folder at: C:\Users\<username>\Games\Age of Empires 2 DE\<numericID>\mods\local.
2. Create a new folder for your mod (e.g., My Awesome Map).
3. Inside that folder, recreate the game's directory structure: \resources\_common\random-map-scripts\.
4. Place your final .rms file inside this random-map-scripts folder.

Creating a Custom Map Icon

A professional map icon helps your creation stand out in the game lobby.

* Create a square image in .png format. A key detail for a professional look is that the corners of the image should be transparent to fit the diamond-shaped slot in the UI.
* Name the .png file with the exact same name as your .rms file.
* Place the icon file in the same folder as your .rms script.
* You must restart the game after enabling the mod for the new icon to appear.

With your map polished and packaged, you are ready to share your work. Consider participating in the vibrant AoE2 modding community by uploading your map to the official repository and joining discussions with other creators on platforms like the Random Map Discord.


--------------------------------------------------------------------------------


9. Appendix: Essential Resources and Further Reading

This appendix contains a curated list of the most important external resources that are indispensable for any serious map scripter. These documents and communities are the foundation upon which much of the collective knowledge of RMS is built.

* The Definitive Random Map Scripting Guide by Zetnus This is the comprehensive "bible" for RMS. It contains a complete reference for nearly every command, attribute, and constant available in the scripting language. When you need to know exactly what a command does or what arguments it accepts, this is the ultimate reference manual.
* AoE2 Terrains Spreadsheet & Definitive Constants List These spreadsheets are crucial for finding the numeric IDs for all terrains, objects, units, and classes in the game. These IDs are necessary when defining your own constants with #const. Focus on the 'Terrains' and 'Objects' tabs of these spreadsheets to find the correct constant IDs needed for your script.
* Community Channels The Random Map Discord server is the primary hub for the map scripting community. It is the best place to ask questions, share progress, get feedback from experienced scripters, and collaborate with other map creators.
