Licenses: code LGPL 2.1 media CC BY-SA 3.0
Created by: UjEdwin
Date: 2016-03-28

Version 1

The gravity gun, that can pick up, and throw stuff away!

left click (use) to pick
up right click (place) on a holded object to throw away
up right click (place) on a block to place the tool

Is using 3D models in hand (basicly nodes)

The gravity guns using a auto glitch fix, thats makes static control over the object, (the glitches is caused by heavy models)

cast stuff can destroy blocks (fly away or create blocks) [if enable_gravitygun_throw_stuff_destroys is true]

Gravitygun
Can can pick up, place and throw away stuff / blocks
(players to if enable_gravitygun_requires_privilege_to_hold_players is false or have the gravitygun privilege)

Gravitygun Overloaded:
cant hold stuff, but used a very high force power to throw away evyerthing around you, even the blocks.
requires gravitygun2 (privilege as default)

Gravitygun basic:
Can only pick up and place stuff (but still usefull)
(players to if enable_gravitygun_requires_privilege_to_hold_players is false or have the gravitygun privilege)

Changes log:
V1.0:
Added using objects colision boxes
Changed: delays in ggun overloaded only effects with blocks
Added: attached players cant use gravitygun (fly glitch fix)
Added: players that holding an object, and not moving will drops the object after 60 secunds (saves cpu from afk players)
Added: dead players will drop their holded object
Added: stuff / players that hits by stuff that is big as or bigger then it self will randommly fly away (like the blocks)
Added: damage from cast stuff is based on the objects collision / size
Added: blocks will use ther own collision boxes (works on the mostly of them)
Fixed: crash by nil object
V0.9
Mode created