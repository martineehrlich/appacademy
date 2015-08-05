function Clock () {
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  var time = this.currentTime;
  console.log(time.getHours() + ":" + time.getMinutes() + ":" + time.getSeconds());
  // Format the time in HH:MM:SS
};

Clock.prototype.run = function () {
    this.currentTime = new Date();
    this.printTime();
    var boundTick = this._tick.bind(this);
    setInterval(boundTick, Clock.TICK);
};

Clock.prototype._tick = function () {
    var seconds = this.currentTime.getSeconds();
     this.currentTime.setSeconds(seconds + (Clock.TICK/1000));
     this.printTime();
  // 1. Increment the currentTime.
  // 2. Call printTime.
};

var clock = new Clock();
clock.run();
//
// module.exports = Clock;
