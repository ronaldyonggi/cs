# NBody Simulation
This project is a program simulating the motion of multiple objects in a plane, taking into account gravitational forces between each object as theorized by Sir Isaac Newton's [Law of Universal Gravitation](http://en.wikipedia.org/wiki/Newton%27s_law_of_universal_gravitation). This project is based on [Spring 2019 University of California - Berkeley CS61B Project 0 - NBody Simulation](https://sp19.datastructur.es/materials/proj/proj0/proj0).

## Instruction on Running The Simulation

Using a shell, navigate to the NBody directory and run the following:

`java NBody [T] [dT] [filename]`

* `T`: desired time length of the simulation (in milliseconds)
* `dT`: time increment for each frame of the animation (in milliseconds)
* `filename`: the complete filepath to a `.txt` file containing the data of a particular universe.
    * These data files are available in `/data` directory.

#### Example

`java NBody 157788000.0 250.0 data/planets.txt`