//
// var callback = function (el) {
//
// }


Array.prototype.myUniq = function () {
  var results = [];
  for (var i = 0; i < this.length; i++){
    if (results.indexOf(this[i]) === -1) {
      results.push(this[i]);
    }
  }
  console.log(results);
};

// var array = [1, 2, 3, 3];

// array.myUniq();

Array.prototype.twoSum = function () {
  var results = [];
  for (var i = 0; i < this.length; i++){
    for (var j = i + 1; j < this.length; j++){
      if (this[i] + this[j] === 0){
        var array = [i, j];
        results.push([i, j]);
      }
    }
  }
  console.log(JSON.stringify(results));
};
//
// var array = [-1, 0, 2, -2, 1]
// array.twoSum();
Array.prototype.myTranspose = function () {
  var results = [];
  for (var i = 0; i < this.length; i++){
    var innerArray = [];
    for (var j = 0; j < this.length; j++){
      innerArray.push(this[j][i]);
    }
    results.push(innerArray);
  }
  console.log(JSON.stringify(results));
};

// var rows = [
//     [0, 1, 2],
//     [3, 4, 5],
//     [6, 7, 8]
//   ];
//
// rows.myTranspose();

Array.prototype.myEach = function (callback){
  for (var i = 0; i < this.length; i++) {
    callback(this[i]);
  }
  return this;
};

// var array = [1, 2, 3, 3];
//
// array.myEach(function (el) {
//   console.log(el);
// });

Array.prototype.myMap = function (callback){
  var results = [];
  this.myEach(function (i) {
    results.push(callback(i));
  });
  return results;
};

// var array = [1, 2, 3, 3];
//
// array.myMap(function (el) {
//   console.log(el * 2);
// });

// Array.prototype.myInject = function (callback){
//   var accumulator = this[0];
//   var remainingArray = this.slice(1);
//   remainingArray.myEach(function (i){
//     accumulator = callback(accumulator, i);
//   });
//   console.log(accumulator);
// };
//
//
// var array = [1, 2, 3, 3];
//
// array.myInject(function (acc, el) {
//   return acc * el;
// });

Array.prototype.bubbleSort = function (){
  var sorted = false;
  while(sorted === false){
    sorted = true;
    var i = 0;
    for (i; i < this.length - 1; i++){
      var j = i + 1;
      if (this[i] > this[j]) {
        var x = this[i];
        this[i] = this[j];
        this[j] = x;
        sorted = false;
      }
    }
  }
  console.log(this);
};
//
// var array = [4, 3, 5, 6, 1, 7];
// //
// array.bubbleSort();


String.prototype.subStrings = function (){
  var results = [];
  for (var i = 0; i < this.length; i++) {
    for (var j = i + 1; j < this.length + 1; j++) {
      if (results.indexOf(this.slice(i, j)) === -1) {
        results.push(this.slice(i, j));
      }
    }
  }
  console.log(results);
};

// var string = "racecar";
// string.subStrings();
