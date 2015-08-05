(function () {
  if (typeof Asteroids === "undefined") {window.Asteroids = {};}

  var Util = window.Asteroids.Util = {};
  Util.inherits = function (ChildClass, ParentClass) {
    function Surrogate() {}
    Surrogate.prototype = ParentClass.prototype;
    ChildClass.prototype = new Surrogate();
    ChildClass.prototype.constructor = ChildClass;
  };

  Util.randomVec = function (speed) {
    var dx = (Math.random() * speed) - 1;
    var dy = (Math.random() * speed) - 1;

    return [dx, dy];
  };

  // Util.randomPos = function (canvasXdim, canvasYdim) {
  //   var xLoc = canvasXdim * Math.random();
  //   var yLoc = canvasYdim * Math.random();
  //   return [xLoc, yLoc];
  // };

})();
