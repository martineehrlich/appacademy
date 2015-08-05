(function () {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Asteroid = window.Asteroids.Asteroid = function(attrs) {
    this.COLOR = attrs['color'] || "#00FF00";
    this.RADIUS = attrs['radius'] || 25;
    this.VEL = window.Asteroids.Util.randomVec(2);
    this.pos = attrs['pos'];
    this.game = attrs['game'];
    attrs['color'] = this.COLOR;
    attrs['radius'] = this.RADIUS;
    attrs['vel'] = this.VEL;
    window.Asteroids.MovingObject.call(this, attrs);
  };

  window.Asteroids.Util.inherits(Asteroid, window.Asteroids.MovingObject);

})();



//some other file
// var mo = new Asteroids.MovingObject({name: "jeff"});
