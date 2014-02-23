life = {}
life.click = function() {
    var id = this.id.substring(1, this.id.length);
    var nums = id.split('c');
    var cell = Cell.grid[nums[0]*1][nums[1]*1];
    if(cell.state == 'dead')
        cell.setState('alive');
    else
        cell.setState('dead');
}
life.makeGrid = function() {
    var grid = [];
    var divGrid = [];
    for(var i = 0; i < Cell.max; i++) {
        var row = [];
        var divRow = [];
        for(var j = 0; j < Cell.max; j++) {
            var id = 'r' + i + 'c' + j;
            var cell = create('div', {'className':'cell dead', 'id':id}, []);
            cell.onclick = life.click;
            divRow.push(cell);
            row.push(new Cell(i, j, cell, 'dead'));
        }
        divGrid.push(create('div', {'className':'row'}, divRow));
        grid.push(row);
    }
    $('grid', divGrid);
    Cell.grid = grid;
}
life.iterate = function() {
    for(var r in Cell.grid) {
        var row = Cell.grid[r];
        for(var c in row) {
            var cell = row[c];
            var count = cell.getLiveNeighbors();
            if(count == 3)
                cell.nextState = 'alive';
            else if(count == 2) {
                cell.nextState = cell.state;
            }
            else
                cell.nextState = 'dead';
        }
    }
    for(var r in Cell.grid) {
        var row = Cell.grid[r];
        for(var c in row) {
            var cell = row[c];
            cell.setState(cell.nextState);
        }
    }
}
life.start = function() {
    life.id = setInterval(life.iterate, 1500);
}
life.stop = function() {
    clearInterval(life.id);
}
life.main = function() {
    life.makeGrid();
    var g = Cell.grid;
    var x = Cell.max - 1;
    for(var pos in Cell.positionDict)
        g[0][0].getNeighbor(pos).setState('alive')
    for(var i = 0; i < Cell.max; i++){
        if(i<40 && i > 10) {
            g[10][i].setState('alive');
            g[25][i].setState('alive');
            g[40][i].setState('alive');
            g[i][10].setState('alive');
            g[i][25].setState('alive');
            g[i][40].setState('alive');
        }
    }
    $('startButton').onclick = life.start;
    $('stopButton').onclick = life.stop;
}
window.onload = life.main
