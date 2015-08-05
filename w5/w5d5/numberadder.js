var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback){
  if (numsLeft > 0) {
    reader.question("Choose a number: ", function(input){
      var number = parseInt(input);
      var newSum = sum + number;
      console.log(newSum);
      addNumbers(newSum, numsLeft - 1, completionCallback);
    });
    }
    else {
      completionCallback(sum);
      reader.close();
    }
  }

addNumbers(0, 5, function(nums){ console.log("who cares!?");});
