Battlefield-2-Unlocks
=====================

Server software for 'cheating' a local Battlefield 2 server to allow all weapons unlocked for players.


This was uploaded prematurely. I don't consider the quality of this code to be very good, but it works.


It is necessary to patch the Battlefield Dedicated Server. The file ~/bf2/python/bf2/stats/unlocks.py will have to be patched.

Do this by cd'ing to the bf2/python/bf2/stats directory and running:

patch < [path to repo/]bf2server.patch
