var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame (){
  this.stacks = [[3,2,1],[],[]];
}

HanoiGame.prototype.isWon = function (){
  var l1 = this.stacks[0].length;
  var l2 = this.stacks[1].length;
  var l3 = this.stacks[2].length;
  return (l1 === 0 && (l2 === 0 || l3 === 0));
};

HanoiGame.prototype.isValidMove = function(startTowerIdx, endTowerIdx){
  var start = this.stacks[startTowerIdx];
  var destination = this.stacks[endTowerIdx];

  if (start.length === 0){
    return false;
  }
  else if (destination.length !== 0 && start.slice(-1) > destination.slice(-1))  {
    return false;
  }
  else {
    return true;
  }
};

HanoiGame.prototype.move = function(startTowerIdx, endTowerIdx){
  var start = this.stacks[startTowerIdx];
  var destination = this.stacks[endTowerIdx];

  if (this.isValidMove(startTowerIdx, endTowerIdx)){
    var disc = start.slice(-1);
    this.stacks[startTowerIdx] = start.slice(0,-1);
    console.log(disc);
    this.stacks[endTowerIdx] = destination.concat(disc);
    return true;
  }
  return false;
};

HanoiGame.prototype.print = function () {
  console.log(JSON.stringify(this.stacks));
};

HanoiGame.prototype.promptMove = function (callback) {
    this.print();
    reader.question("Where do you want to move the disk from?", function (start) {
      console.log(start);
      reader.question("Where do you want to move the disk from?", function (end) {
        console.log(end);
        callback(parseInt(start), parseInt(end));
      });
    });
};

HanoiGame.prototype.run = function (completionCallback) {
    this.promptMove(function (start, end){
      var success = this.move(start, end);
      if (!success) {
        console.log("Invalid move");
      }
      if (this.isWon()){
        console.log("You've won!");
        completionCallback();
      }
      else {
        this.run(completionCallback);
      }
    }.bind(this));
    // var boundMove = newMove.bind(this);
    // this.promptMove(boundMove);
};

var game = new HanoiGame();
game.run(function () {
  reader.close();
});
