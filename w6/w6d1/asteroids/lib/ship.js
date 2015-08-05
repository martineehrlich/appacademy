(function () {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Ship = window.Asteroids.Ship = function(attrs) {
    this.COLOR = attrs['color'] || "#0000FF";
    this.RADIUS = attrs['radius'] || 25;
    this.VEL = 0;
    this.pos = attrs['pos'];
    this.game = attrs['game'];
    attrs['color'] = this.COLOR;
    attrs['radius'] = this.RADIUS;
    attrs['vel'] = this.VEL;
    window.Asteroids.MovingObject.call(this, attrs);
  };

  window.Asteroids.Util.inherits(Ship, window.Asteroids.MovingObject);

})();
