import ballerina/io;

class MyClass {
    private int n; // only accessible by memebers only(within);

    // method called to initialize an instance
    // called on initialization(once).
    public function init(int n = 0) { // accessible anywhere;
        // must return an error or null
        // if no type is specified, init will never return an error
        self.n = n; // self keyword references the instance
    }

    // Method
    // Methods are functions that are bound to a class
    // and can be used through a class instance(or the class itself).
    public function inc() {
        self.n += 1;
    }

    public function get() returns int {
        return self.n;
    }

}

class File {
    string path;

    string contents;

    function init(string p) returns error? {
        self.path = p;
        self.contents = check io:fileReadString(p);
    }

}

function demoClass(){
    MyClass x = new MyClass(1234);
    x.inc();
    int n = x.get();

    io:println("Value is: ", n);
}

// File f = check new File("text.txt");
// const and final
// constants defines types whose values are known at compile time
// they are declared at module level
const MAX_VALUE = 1000;
// Finals are variables that cannot be reassigned after being initialized


// Enum
// Enum are shorthand for expressing unions of strings and constants;
// it's short for example

//      const RED = "RED";
//      const GREEN = "GREEN";
//      const BLUE = "BLUE";

//      type Color RED|GREEN|BLUE;

// Enum shortens it to
enum Color{
    RED,
    GREEN,
    BLUE
}

// we can also define it associated string values
enum Language{
    ENG="English",
    TL="Tamil",
    SI="Sinhala"
}




public function main() {
    // Objects in Ballerina
    // Objects bundle together code and data;
    demoClass();

    MyClass obj1 = new MyClass(3);
    MyClass obj2 = new MyClass(4);


    // Identity
    // Identity is used to compare memory location at runtime
    // uses the === not ==
    boolean b1 = (obj1 === obj1); //true
    boolean b2 = (obj1 === obj2); //false

    io:println("Identity, obj1: ", b1," obj2: ", b2);

    // accessing constants
    io:println("Constant value ", MAX_VALUE);

    // usnig finals
    final string msg = "God is good";
    io:println("Finally, ", msg);

    // Match statement
    // used to match against cases, unlike multiple if and else if

    io:println("Matching: ",mtest("str"));

    // Type interference
    // the use of var as a generic type for a local variable(in case of multiple types)
    // mostly could be used with for loops
    var x = "str";
    io:println("Var interference: ", x);

    foreach var item in 0..<10 {
        io:println("Var interference item: ", item);
    }

    // it also works with classes
    // var cx = new MyClass(78);

    // Testing functional programming

    int[] nums = [1, 2, 3, 4, 5];

    int[] evenNums = nums.filter(f);
    io:println("Even numbers: ", evenNums);

    int[] oddNumbers = nums.filter(n=> n % 2 != 0); // another way like javascript
    io:println("Odd numbers: ", oddNumbers);


    // Asynchronous function call;
    // start keyword runs the function on another thread
    // Asynchronous functions makes multi tasking possible
    future<string> f1 = start mtest("str");
    future<string> f2 = start mtest(MAX_VALUE);
    io:println("Started f1, f2");

    // we wait for the call with the wait keyword
    // using check to panic errors in case
    // string af1 = check wait f1;
    // string af2 = check wait f2;
    // io:println("Waited f1:",af1, " f2: ", af2);

    



}



function mtest(any v) returns string{
    match v{
        17 => {return "number";}
        true => {return "boolean";}
        "str" => {return "string";}
        MAX_VALUE => { return "constants";}
        0|1 =>{return "or";}
        _ => {return "any";} // for no matched case
    }
}

// Functional Programming
// Functions are values, and they work as closures
// function is a type that can be defined as a basic type
var isOdd = function (int n) returns boolean{ // annonymous function
    return n % 2 != 0;
};

type IntFilter function(int n) returns boolean; // function type

function isEven(int n) returns boolean{// matches signature with IntFilter
    return n % 2 == 0;
}


IntFilter f = isEven; // function as a value

