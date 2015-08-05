function sum() {
  var summer = 0;
  for (var i = 0; i < arguments.length; i++) {
    summer += arguments[i];
  }
  return summer;
}

// sum(1, 2, 3, 4, 5);

Function.prototype.myBind = function(context, args) {
  var fn = this;
  var argy = Array.prototype.slice.call(arguments, 1);
  return function() {
    var boundArgs = Array.prototype.slice.call(arguments);
    return fn.apply(context, boundArgs.concat(argy));
  };
};

function curriedSum(numArgs) {
  var numbers = [];

  function _curriedSum(num) {
    numbers.push(num);

    if (numbers.length === numArgs) {
      var sum = 0;
      numbers.forEach(function(el) {
        sum += el;
      });
      return sum;
    } else {
      return _curriedSum;
    }
  }
  return _curriedSum;
}
// curriedSum(4)(5)(30)


Function.prototype.curry = function(numArgs) {
  var fn = this;
  var numbers = [];

  function _curriedSum(num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      return fn.apply(fn, numbers);
    } else {
      return _curriedSum;
    }
  }
  return _curriedSum;
};

var alex = sum.curry(4);
console.log(alex(1)(2)(3)(4));