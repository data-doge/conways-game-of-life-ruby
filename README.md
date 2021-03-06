# Conway's Game of Life

This is a ruby version of the famed Cellular Automaton, [Conway's Game of Life](http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life).

The game is simple. There is a two-dimensional grid. The grid contains cells. Every cell is either alive or dead.

Every turn, the grid is updated in accordance with these four rules:
  - If a live cell has less than 2 live neighbors, it dies (as if by underpopulation).
  - If a live cell has more than 3 live neighbors, it dies (as if by overpopulation).
  - If a live cell has 2 or 3 live neighbors, it remains alive for another turn.
  - If a dead cell has exactly 3 live neighbors, it becomes alive again (as if by reproduction).

## Usage

Assuming you have ruby + rspec installed on your machine,
- clone this repo
- run specs: ```rspec ./spec```
- run program: ```ruby conways_game_of_life.rb```
- resize terminal window so that the entire grid fits on the screen
- stop program: ^ + c

Here's a [demo](https://www.youtube.com/watch?v=M0n2aZBnAYM).

<img src='http://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Glider.svg/220px-Glider.svg.png'/>
