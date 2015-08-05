Function.prototype.myBind = function(context) {
  var fn = this;
  return function(){
    fn.apply(context);
  };
};

function Kitten(name) {
  this.name = name;
}

Kitten.prototype.meow = function(){
  console.log(this.name + " meows");
};
var kitty = new Kitten("kitty");
var a = kitty.meow;
a();
var boundA = a.myBind(kitty);
boundA();
