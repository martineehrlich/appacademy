(function () {
  if (typeof Asteroids === "undefined") {window.Asteroids = {};}

  var MovingObject = window.Asteroids.MovingObject = function(attrs) {
    this.pos = attrs['pos'];
    this.centerX = this.pos[0];
    this.centerY = this.pos[1];
    this.vel = attrs['vel'];
    this.radius = attrs['radius'];
    this.color = attrs['color'];
    this.game = attrs['game'];
  };

  MovingObject.prototype.draw = function(ctx){
    ctx.fillStyle = this.color;
    ctx.beginPath();

    ctx.arc(
      this.centerX,
      this.centerY,
      this.radius,
      0,
      2 * Math.PI,
      false
    );

    ctx.fill();
  };

  MovingObject.prototype.move = function () {
    this.pos = this.game.wrap([this.centerX + this.vel[0], this.centerY + this.vel[1]]);
    this.centerX = this.pos[0];
    this.centerY = this.pos[1];
  };

  MovingObject.prototype.isCollidedWith = function (otherObject) {
    if ((Math.abs(this.centerX - otherObject.centerX) < (this.radius + otherObject.radius)) &&
     (Math.abs(this.centerY - otherObject.centerY) < (this.radius + otherObject.radius)))
    {
      return true;
    }
    else {
      return false;
    }
  };

  MovingObject.prototype.collideWith = function (otherObject){
    this.game.remove(otherObject);
    this.game.remove(this);
  };

})();



//some other file
// var mo = new Asteroids.MovingObject({name: "jeff"});
