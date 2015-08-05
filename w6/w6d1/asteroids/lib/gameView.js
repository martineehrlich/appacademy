(function () {
  if (typeof Asteroids === "undefined") {window.Asteroids = {};}

  window.Asteroids.GameView = function (dimx, dimy, canvasEl) {
    this.game = new window.Asteroids.Game ({dimx: dimx, dimy: dimy});
    this.ctx = canvasEl.getContext("2d");
  };

  window.Asteroids.GameView.prototype.start = function () {
    var game = this.game;
    var gameview = this;
     window.setInterval((function () {
       game.step();
       game.draw(gameview.ctx);
     }), 1000 / 50);
   };
})();
