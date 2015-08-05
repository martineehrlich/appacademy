var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function absurdBubbleSort(arr, sortCompletionCallback){
  function outerBubbleSortLoop(madeAnySwaps){
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    }
    else{
      sortCompletionCallback(arr);
      reader.close();
    }
  }
  outerBubbleSortLoop(true);
}

function askIfGreaterThan(el1, el2, callback){
  reader.question("Is " + el1 + " greater than " + el2 + "?", function (input) {
    if (input === "yes") {
      callback(true);
    }
    else {
      callback(false);
    }
  });
}

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop){
  if (i < arr.length - 1) {
    askIfGreaterThan(arr[i], arr[i+1], function (isGreaterThan){
      if (isGreaterThan) { // swap the element, move on to next el
        var swap = arr[i];
        arr[i] = arr[i+1];
        arr[i+1] = swap;
        innerBubbleSortLoop(arr, i + 1, true, outerBubbleSortLoop);
      }
      else { //don't swap, move on
        innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerBubbleSortLoop);
      }
    });
  }
  else
  {
    outerBubbleSortLoop(madeAnySwaps);
  }
}



absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
});
