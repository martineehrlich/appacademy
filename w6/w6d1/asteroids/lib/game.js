(function () {
  if (typeof Asteroids === "undefined") {window.Asteroids = {};}

  var Game = window.Asteroids.Game = function(attrs) {
    this.DIMX = attrs['dimx'];
    this.DIMY = attrs['dimy'];
    this.asteroids = [];
    this.addAsteroids();
    this.ship = this.addShip();
  };

  Game.prototype.addShip = function () {
    return new window.Asteroids.Ship({pos: this.randomPos(this.DIMX, this.DIMY), game: this});
  };


  Game.prototype.addAsteroids = function () {
    for (var i = 0; i < Game.NUM_ASTEROIDS; i++) {
      this.asteroids.push(
        new window.Asteroids.Asteroid({pos: this.randomPos(this.DIMX, this.DIMY), game: this})
      );
    }
  };

  Game.NUM_ASTEROIDS = 8;

  Game.prototype.allObjects = function () {
    var objects = [];
    objects = objects.concat(this.asteroids);
    objects.push(this.ship);
    return objects;
  };

  Game.prototype.randomPos = function (canvasXdim, canvasYdim) {
    var xLoc = canvasXdim * Math.random();
    var yLoc = canvasYdim * Math.random();
    return [xLoc, yLoc];
  };

  Game.prototype.draw = function (ctx) {
    ctx.clearRect(0, 0, this.DIMX, this.DIMY);
    var objects = this.allObjects();
    objects.forEach(function (object) {
      object.draw(ctx);
  });};

  Game.prototype.moveObjects = function () {
    var objects = this.allObjects();
    objects.forEach(function (object) {
      object.move();
      });
  };

  Game.prototype.wrap = function (pos) {
    var game = this;
    var wrapped = pos;

    if ((pos[0] < game.DIMX && pos[0] > 0) && (pos[1] < game.DIMY && pos[1] > 0)){
      return wrapped;
    }

    if (pos[0] > game.DIMX) {
      wrapped[0] = pos[0] - game.DIMX;
    }
    else if (pos[0] < 0) {
      wrapped[0] = pos[0] + game.DIMX;
    }

    if (pos[1] > game.DIMY) {
      wrapped[1] = pos[1] - game.DIMY;
    }
    else if (pos[1] < 0) {
      wrapped[1] = pos[1] + game.DIMY;
    }

    return wrapped;
  };



  Game.prototype.checkCollisions = function() {
    var game = this;
    var objects = game.allObjects();
    for (var i = 0; i < objects.length; i++) {
      for (var j = i + 1; j < objects.length; j++) {
        if (objects[i].isCollidedWith(objects[j])) {
          objects[i].collideWith(objects[j]);
        }
      }
    }

    // game.asteroids.forEach(function(asteroid1) {
    //   game.asteroids.forEach(function(asteroid2) {
    //     if ((asteroid1 !== asteroid2) && asteroid1.isCollidedWith(asteroid2)) {
    //       alert("COLLISION");
    //     }
    //   });
    // });
  };
  Game.prototype.remove = function(asteroid) {
    var index = this.asteroids.indexOf(asteroid);
    this.asteroids.splice(index, 1);
  };

  Game.prototype.step = function() {
    this.moveObjects();
    this.checkCollisions();
  };

})();
