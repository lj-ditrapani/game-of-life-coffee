Author:  Lyall Jonathan Di Trapani

Conway's Game of Life on 2-D toroidal grid

I originally created this in 2009 in JavaScript, but finally put it on
github.  It has been rewritten in CoffeeScript.

Users can click on a cell to toggle it "alive/dead".  The simulation runs
with a 1.5 sec period.

Try it out here:
<http://ditrapani.info/sims/game-of-life/life.html>.

Download ready-to-use zip from
<http://ditrapani.info/sims/game-of-life.zip>.

To develop this code, clone repo at
<https://github.com/lj-ditrapani/game-of-life-coffee>

Development requires CoffeeScript and qUnit.


TODO
----

- BUG:  pressing start multiple times creates multiple calls to
  setInterval, but each call overwrites the life.id used to clear the
  interval.  So it is impossible to stop the iterations.
  Fix:  Have a single button. Initially, it is the start button.
  Once pressed, it toggles to the stop buton and so on.
  Could be a 'Run' check box?
- Use table layout css
- Separate out init game code
- Allow user to chose initial game state from list
- plug into web application to allow saving/loading initial game states
  to/from server
