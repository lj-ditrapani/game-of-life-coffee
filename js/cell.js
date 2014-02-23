function Cell(row, col, div, state) {
    this.row = row;
    this.col = col;
    this.div = div;
    this.state = state;
}
Cell.max = 50;
Cell.positionDict = {
    'tl': [-1,-1], 'tc': [-1, 0], 'tr': [-1, 1],
    'ml': [ 0,-1],                'mr': [ 0, 1],
    'bl': [ 1,-1], 'bc': [ 1, 0], 'br': [ 1, 1]
}
Cell.prototype.getNeighbor = function(position) {
    var offsets = Cell.positionDict[position];
    var row = this.row + offsets[0];
    var col = this.col + offsets[1];
    if(row < 0) row = Cell.max - 1;
    if(col < 0) col = Cell.max - 1;
    if(row >= Cell.max) row = 0;
    if(col >= Cell.max) col = 0;
    return Cell.grid[row][col];
}
Cell.prototype.getLiveNeighbors = function() {
    var count = 0;
    for(pos in Cell.positionDict) {
        if(this.getNeighbor(pos).state == 'alive')
            count++;
    }
    return count
}
Cell.prototype.setState = function(state) {
    removeClass(this.div, this.state);
    this.state = state;
    addClass(this.div, state);
}
Cell.prototype.toString = function() {
    return '' + this.row + ' ' + this.col + ' ' + this.state;
}
