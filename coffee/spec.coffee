# Author:  Lyall Jonathan Di Trapani -----------------------------------


module 'cell', {
  setup: () ->
    @c = new Cell(2, 3)
}


Cell = ljd.Cell
life = ljd.life


test 'Make cell', ->
  c = @c
  equal c.row, 2
  equal c.col, 3
  equal c.state, 'dead'


test 'setState, toggle, onclick', ->
  c = @c
  check = (func, state) ->
    c[func](state)
    equal c.state, state
    equal c.div.className, 'cell ' + state
  check('setState', 'alive')
  check('setState', 'dead')
  check('toggle', 'alive')
  check('toggle', 'dead')
  div = c.div
  div.onclick()
  equal c.state, 'alive'
  equal c.div.className, 'cell alive'


test 'toString', ->
  c = @c
  equal c.toString(), 'Cell<2 3 dead>'



module 'life'


test 'positionDict', ->
  pDict = life.positionDict
  deepEqual pDict.tl, [-1, -1]
  deepEqual pDict.br, [1, 1]


test 'getNeighbor', ->
  grid = [
    [0, 1, 2]
    [3, 4, 5]
    [6, 7, 8]
  ]
  runTests = (row, col, tests) ->
    c = new Cell(row, col)
    for [pos, val] in tests
      equal life.getNeighbor(c, pos, grid), val
  tests = [
    ['tl', 0]
  ]
  runTests(1, 1, tests)
  tests = [
    ['br', 3]
    ['tc', 8]
  ]
  runTests(0, 2, tests)
  tests = [
    ['tc', 6]
    ['tl', 8]
    ['ml', 2]
    ['bl', 5]
  ]
  runTests(0, 0, tests)
  tests = [
    ['bl', 0]
    ['bc', 1]
    ['br', 2]
  ]
  runTests(2, 1, tests)


test 'getLiveNeighborsCount', ->
  grid = [
    [{state: 'alive'}, {state: 'dead'}, {state: 'alive'}]
    [{state: 'dead'}, {state: 'alive'}, {state: 'dead'}]
    [{state: 'dead'}, {state: 'alive'}, {state: 'alive'}]
  ]
  c = new Cell(1, 2)
  equal life.getLiveNeighborsCount(c, grid), 5


test 'makeGrid', ->
  grid = life.makeGrid(3)
  equal grid.length, 3
  equal grid[0].length, 3
  equal grid[1][2].toString(), 'Cell<1 2 dead>'
  equal grid[2][0].toString(), 'Cell<2 0 dead>'


test 'makeDivGrid', ->
  grid = life.makeGrid(3)
  life.makeDivGrid(grid)
  g = ljd.$('grid')
  rows = g.children
  equal rows.length, 3
  cells = rows[0].children
  equal cells.length, 3
  equal cells[0].className, 'cell dead'

