var Cat = function(name, owner){
  this.name = name;
  this.owner = owner;
};

Cat.prototype.cuteStatement = function(){
  console.log(this.owner + " loves " + this.name);
};



var subSets = function(ary) {
  if (ary.length === 0){
    return [[]];
  }
  // debugger;
  var first = ary[0];
  var subs = subSets(ary.slice(1));
  return subs.concat(subs.map(function(sub){
    // debugger;
  return sub.concat([first]);
  }));
};

console.log(JSON.stringify(subSets([1, 2, 3])));

var mSort = function(ary) {
  if (ary.length <= 1) {
    return ary;
  }

  var mid = Math.floor(ary.length / 2);
  var left = ary.slice(0, mid);
  var right = ary.slice(mid);

  return merge(mSort(left), mSort(right));
};

var merge = function(ary1, ary2) {

  var resultAry = [];
  while (ary1.length > 0 && ary2.length > 0) {
  if (ary1[0] <= ary2[0]){
    resultAry.push(ary1[0]);
    ary1 = ary1.slice(1);
  }
  else{
    resultAry.push(ary2[0]);
    ary2 = ary2.slice(1);
  }
  }
  resultAry = resultAry.concat(ary1);
  resultAry = resultAry.concat(ary2);
  return resultAry;
};

// console.log(mSort([3, 4, 2, 1, 7]));
var makeChange = function(amt, coins) {
  if (amt === 0) {
    return [];
  }

  var usedCoins = [];
  coins.forEach (function(coin){
    var theseCoins = [];
    if (amt >= coin){
      theseCoins.push(coin);
      theseCoins = theseCoins.concat(makeChange(amt - coin, coins));
    }
    else {
      theseCoins = theseCoins.concat(makeChange(amt, coins.slice(1)));
    }
  if (usedCoins.length === 0 || theseCoins.length < usedCoins.length){
    usedCoins = theseCoins;
  }
});
return usedCoins;
  // if (amt >= coins[0]) {
  //   useCoins.push(coins[0]);
  //   return useCoins.concat(makeChange(amt - coins[0], coins));
  // }
  // else {
  //   return useCoins.concat(makeChange(amt, coins.slice(1)));
  // }
};

// console.log(makeChange(50, [15, 10, 1]));

var bsearch = function (ary, target) {
  if (ary.length === 0) {
    return null;
  }

  var mid = Math.floor(ary.length / 2);

  if (ary[mid] === target) {
    return mid;
  }
  else if(ary[mid] < target) {
    if (bsearch(ary.slice(mid + 1, ary.length + 1), target) === null) {
      return null;
    }
    return bsearch(ary.slice(mid, ary.length + 1), target) + mid;
  }
  else {
    return bsearch(ary.slice(0, mid), target);
  }
};

// console.log(bsearch([1, 2, 3], 1));
// console.log(bsearch([2, 3, 4, 5], 3));
// console.log(bsearch([2, 4, 6, 8, 10], 6));
// console.log(bsearch([1, 3, 4, 5, 9], 5));
// console.log(bsearch([1, 2, 3, 4, 5, 6], 6));
// console.log(bsearch([1, 2, 3, 4, 5, 6], 0));
// console.log(bsearch([1, 2, 3, 4, 5, 7], 6));

var range = function(x, y) {
  if(x === y) {
    return [y];
  }
  return [x].concat(range(x + 1, y));
};

// console.log(range(1,5));

var exponentiation = function(base, exp) {
    if (exp === 0)
    {return 1;}

  return base * exponentiation(base, exp - 1);

};

// console.log(exponentiation(2, 4));

var expo = function(base, exp) {
  if (exp === 0) {return 1;}
  if (exp === 1) {return base;}

  if (exp % 2 === 0){
    return expo(base, exp / 2) * expo(base, exp / 2);
  }
  else {
    return base * (expo(base, (exp - 1) / 2)) * (expo(base, (exp - 1) / 2));
  }

};

// console.log(expo(2, 5));

var fib = function(n) {
  if (n === 1) {
    return [1];
  }
  if (n === 2) {
    return [1, 1];
  }

  var ary = fib(n - 1);
  return ary.concat(ary[ary.length - 1] + ary[ary.length - 2]);
};

// console.log(fib(3));
