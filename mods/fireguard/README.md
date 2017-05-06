# fireguard

Fireguard is a Minetest mod that controls the player interactions with fire and lava to avoid major catastrophes.

Fireguard is divided in 2 modes : safe and restricted.

**Safe mode**

```fireguard_mode = safe```

 - fire will only spread near lava.
This behaviour keeps the challenge when mining near lava but prevents griefers to start huge fires.
The fire will then simply fade out without causing damage.

 - lava can only be spawned naturally. When players harvest a lava source with their bucket,
it's replaced with a safe lava source instead. 
This safe source will have the same look and damage as default's but won't spread and set fire to nearby nodes.
That way it can still be used as decoration or for other mod's applications.

**Restricted mode**

```fireguard_mode = restricted```

  - fire isn't available in the creative inventory (use ```givme```) and is restricted with the ```fgfire``` privilege.
  A warning will be prompted to players lacking this privilege. The standard behaviour of fire isn't halted.
 
  - lava isn't available in the ceative inventory (use ```givme```) and is restricted with the ```fglava``` privilege.
  A warning will be prompted to players lacking this privilege. The standard behaviour of lava isn't halted.
  
**Privileges**
  
fgfire , fglava
  
**Depends**
  
default , fire , bucket

**Licence**

GNU LGPL v2.1

