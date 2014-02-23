# Author:  Lyall Jonathan Di Trapani -----------------------------------


module 'cell'


Cell = ljd.Cell
life = ljd.life


test 'Make cell', ->
  c = new Cell(2, 3, null, 'dead')
  equal c.row, 2
  equal c.col, 3
  equal c.state, 'dead'



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
    c = new Cell(row, col, null, 'dead')
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






