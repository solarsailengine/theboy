# theboy

A SolarSail example project showing a 2D platformer with sprite sheet animations

![](https://github.com/solarsailengine/theboy/blob/master/assets/atlas/TheBoy/idle-05.png)

## Quickstart
 1. Clone this repo
 2. [Download the player](https://www.solarsailengine.com/)
 3. Unzip player into this repo
 4. Run player

## Controls

### Movement
- **LEFT/RIGHT Arrow Keys**: Move and change direction
- **SPACE**: Jump (with gravity physics)

### Animation Selection (Number Keys)
- **1**: Idle animation
- **2**: Walk animation
- **3**: Run animation
- **4**: Jump animation
- **5**: Dead animation
- **0**: Reset to automatic animation mode

## Features

- **2D Platformer Movement**: Horizontal movement with proper speed control
- **Jump Physics**: Gravity simulation with ground collision detection
- **Direction Facing**: Character flips when changing direction
- **Automatic Animation**: Idle/run animations based on movement state
- **Manual Animation Control**: Number keys for testing specific animations
- **Frame-Rate Independent**: Uses Time.deltaTime for consistent movement
