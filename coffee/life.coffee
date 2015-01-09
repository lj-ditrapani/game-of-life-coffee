class Cell

  constructor: (row, col) ->
    @row = row
    @col = col
    @state = 'dead'
    @div = ljd.create('div', {'className': 'cell dead'}, [])
    click = () =>
      @toggle()
    @div.onclick = click

  setState: (state) ->
    ljd.removeClass(@div, @state)
    @state = state
    ljd.addClass(@div, state)

  toggle: () ->
    if @state == 'alive'
      @setState('dead')
    else
      @setState('alive')
    null

  toString: () ->
    return 'Cell<' + @row + ' ' + @col + ' ' + @state + '>'


life = {}


life.positionDict =
  'tl': [-1,-1], 'tc': [-1, 0], 'tr': [-1, 1]
  'ml': [ 0,-1],                'mr': [ 0, 1]
  'bl': [ 1,-1], 'bc': [ 1, 0], 'br': [ 1, 1]


life.getNeighbor = (cell, position, grid) ->
  offsets = life.positionDict[position]
  rows = grid.length
  cols = grid[0].length
  row = (cell.row + offsets[0]) % rows
  col = (cell.col + offsets[1]) % cols
  if row < 0
    row = rows - 1
  if col < 0
    col = cols - 1
  grid[row][col]


life.getLiveNeighborsCount = (cell, grid) ->
  neighbors = []
  for pos, _ of life.positionDict
    if life.getNeighbor(cell, pos, grid).state == 'alive'
      neighbors.push true
  neighbors.length


life.makeGrid = (size) ->
  makeRow = (i) ->
    (new Cell(i, j) for j in [0...size])
  (makeRow(i) for i in [0...size])


life.makeDivGrid = (grid) ->
  makeDivRow = (row) ->
    divRow = (cell.div for cell in row)
    ljd.create('div', {'className': 'row'}, divRow)
  divGrid = (makeDivRow(row) for row in grid)
  ljd.$('grid', divGrid)


life.iterate = () ->
  for row in life.grid
    for cell in row
      count = life.getLiveNeighborsCount(cell, life.grid)
      cell.nextState = if count == 3
        'alive'
      else if count == 2
        cell.state
      else
        'dead'
  for row in life.grid
    for cell in row
      cell.setState(cell.nextState)
  null


life.start = () ->
  life.id = setInterval(life.iterate, 1500)
  null


life.stop = () ->
  clearInterval(life.id)


life.main = () ->
  size = 50
  life.grid = life.makeGrid(size)
  g = life.grid
  life.makeDivGrid(g)
  for pos, _ of life.positionDict
    life.getNeighbor(g[0][0], pos, g).setState('alive')
  for i in [0...size]
    if i < 40 && i > 10
      g[10][i].setState('alive')
      g[25][i].setState('alive')
      g[40][i].setState('alive')
      g[i][10].setState('alive')
      g[i][25].setState('alive')
      g[i][40].setState('alive')
  ljd.$('startButton').onclick = life.start
  ljd.$('stopButton').onclick = life.stop
  null


ljd.Cell = Cell
ljd.life = life
