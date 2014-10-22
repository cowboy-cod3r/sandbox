
/**
 * Give me a description
 * @param  {[type]} first_name [description]
 * @param  {[type]} last_name  [description]
 * @param  {[type]} age        [description]
 * @return {[type]}            [description]
 */
var Person = (function(first_name, last_name, age){

  var obj = {

    /**
     * Constructor
     */
    init: function () {

      // Member Variables
      this.first_name = first_name;
      this.last_name  = last_name;
      this.age        = age;
    },

    /**
     * Returns the full name of the person
     */
    get_name: function () {
      return this.first_name + " " + this.last_name;
     }
  };

  // Initialize the Object (ensures init is always ran when a new object is instantiated)
  obj.init();

  // Return the object (provides acess to member variables and methods)
  return obj;
});


var sean   = new Person("Sean", "Humbarger", 35);
console.log(sean.get_name());
var lisa   = new Person("Lisa", "Humbarger", 35);
console.log(lisa.get_name());
