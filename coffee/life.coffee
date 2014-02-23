class Cell

  constructor: (row, col, state) ->
    @row = row
    @col = col
    @state = state
    @div = ljd.create('div', {'className': 'cell dead'}, [])
    click = () =>
      @toggle()
    @div.onclick = click

  setState: (state) ->
    ljd.removeClass(@div, @state)
    @state = state
    ljd.addClass(@div, state)

  live: () ->
    @setState('alive')

  die: () ->
    @setState('dead')

  toggle: () ->
    if @state == 'alive'
      @die()
    else
      @live()

  toString: () ->
    return 'Cell<' + @row + ' ' + @col + ' ' + @state + '>'


life = {}


positionDict =
  'tl': [-1,-1], 'tc': [-1, 0], 'tr': [-1, 1],
  'ml': [ 0,-1],                'mr': [ 0, 1],
  'bl': [ 1,-1], 'bc': [ 1, 0], 'br': [ 1, 1]


getNeighbor = (cell, position, grid) ->
  offsets = positionDict[position]
  rows = grid.length
  cols = grid[0].length
  row = (cell.row + offsets[0]) % rows
  col = (cell.col + offsets[1]) % cols
  if row < 0
    row = rows - 1
  if col < 0
    col = cols - 1
  grid[row][col]


getLiveNeighborsCount = (cell, grid) ->
  neighbors = []
  for pos, _ of positionDict
    if getNeighbor(cell, pos, grid).state == 'alive'
      neighbors.push true
  neighbors.length

life.positionDict = positionDict
life.getNeighbor = getNeighbor
life.getLiveNeighborsCount = getLiveNeighborsCount



###
life.makeGrid = ->
  divGrid = []
  makeCell = (i, j, divRow) ->
    id = 'r' + i + 'c' + j
    cell = ljd.create('div', {'className': 'cell dead', 'id': id}, [])
    cell.onclick = life.click
    divRow.push(cell)
    row.push(new Cell(i, j, cell, 'dead'))

  makeRow = (i) ->
    row = (makeCell(i, j) for j in [0...Cell::max])
    i / 2
  grid = (makeRow(i) for i in [0...Cell::max])
  ljd.$('grid', divGrid)
  Cell.grid = grid


life.makeGrid = ->
    grid = []
    divGrid = []
    grid = makeRow(i) for i in [0..Cell::max]
        row = []
        divRow = []
        for
        for(j = 0; j < Cell.max; j++) {
            id = 'r' + i + 'c' + j
            cell = create('div', {'className':'cell dead', 'id':id}, [])
            cell.onclick = life.click
            divRow.push(cell)
            row.push(new Cell(i, j, cell, 'dead'))
        }
        divGrid.push(create('div', {'className':'row'}, divRow))
        grid.push(row)
    }
    $('grid', divGrid)
    Cell.grid = grid
    ###

ljd.Cell = Cell
ljd.life = life
