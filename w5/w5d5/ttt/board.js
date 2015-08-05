function Board() {
  this.grid = [["_", "_", "_"], ["_", "_", "_"], ["_", "_", "_"]];
}

Board.prototype.placeMark = function (pos, mark) {
    var row = pos[0];
    var col = pos[1];
    this.grid[row][col] = mark;
};

Board.prototype.empty = function (pos) {
  var row = pos[0];
  var col = pos[1];
  return (this.grid[row][col] === "_");
};

Board.prototype.won = function () {
  return (this.winner !== null);
};

Board.prototype.winner = function (){
  var threes = [];
  threes = threes.concat(this.grid);
  threes = threes.concat(this.transpose());
  threes = threes.concat(this.diagonals());

  for (var i = 0; i < threes.length; i++) {
    var arr = threes[i];
    var first = arr[0];
    if (arr[1] === first && arr[2] === first){
      return first;
    }
  }
  return null;
}

Board.prototype.transpose = function (){
  var transpose = [[],[],[]];
  for (var i = 0; i < this.grid.length; i++) {
    for (var j= 0; j < this.grid.length;j++) {
      transpose[j].push(this.grid[j][i]);
    }
  }
  return transpose;
};

Board.prototype.print = function () {
  console.log(JSON.stringify(this.grid));
};
Board.prototype.diagonals = function(){
  var g = this.grid;
  var diags = [];
  diags.push([g[0][0], g[1][1], g[2][2]]);
  diags.push([g[2][0], g[1][1], g[0][2]]);
  return diags;
};

var b = new Board();
b.won();
