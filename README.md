# RobotSimulator
A popular robot simulation interview exercise

## Instructions
Write a robot simulator.

A robot factory's test facility needs a program to verify robot movements.

The robots have three possible movements:

* turn right `R`
* turn left `L`
* advance `A`
Robots are placed on a hypothetical infinite grid, facing a particular direction (north, east, south, or west) at a set of {x,y} coordinates, e.g., {3,8}, with coordinates increasing to the north and east.

The robot then receives a number of instructions, at which point the testing facility verifies the robot's new position, and in which direction it is pointing.

The letter-string "RAALAL" means:
* Turn right
* Advance twice
* Turn left
* Advance once
* Turn left yet again
Say a robot starts at {7, 3} facing north. Then running this stream of instructions should leave it at {9, 4} facing west.

## Example run
```
[1] pry(main)> p move(Position.new(:n, 7, 3), "RAALAL")
#<Position: W@{9, 4}>
=> #<struct Position d=:w, x=9, y=4>
```
