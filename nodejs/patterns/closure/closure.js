
var add = (function () {

  var counter = 0;


  var my_fun = function() { return counter += 1;};


  return my_fun;

})();
