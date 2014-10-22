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


var Student = (function(id){
  var obj = {

    /**
     * Constructor
     */
    init: function () {

      // Member Variables
      this.id = id;
    }

  };

  // Initialize the Object (ensures init is always ran when a new object is instantiated)
  obj.init();

  // Return the object (provides acess to member variables and methods)
  return obj;
});






var student           = new Student(123);
Student.prototype.person = new Person("Sean","Humbarger",35);
console.log(student.person);