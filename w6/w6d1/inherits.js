Function.prototype.inherits = function (superclass) {
  function Surrogate () {}
  Surrogate.prototype = superclass.prototype;
  this.prototype = new Surrogate();
};
