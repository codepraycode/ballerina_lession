// Import is of two part, organization name / module name
// Modules hierarchies follow the / and . notations, e.g org/x.y.z
// z:f points to a member f of module z(maybe a function)
import ballerina/io;
import ballerina/lang.'string;

// import ballerina/io as oi; // aliasing is allowed

// Variables are defined in this format
// [type] [name] = [value];
string greeting = "Hello World"; // module level variable(global)

// Type definitions
// we can create a custom type 
// type [type_name] [datatype];
type MapArray map<string>[]; // this one is an array of maps
type Ids int[]; // an array of integers

type PhoneNumber int;

// Using records in type definitions
type LinkedList record {
    string value;
    LinkedList? next;
};

type Coord record{
    int x;
    int y;
};

// Union
//  Union allows us to combine two or more types
// type [type_name] [a_type]| [another_type] | ...
type flexType string|int;

type Profile record {
    string firstname;
    string lastname;
};

type Name Profile|string;


// Errors subtyping (with the distinct keyword)
type XErr distinct error;
type YErr distinct error;

type Err XErr| YErr;


function decribeError(Err err) returns string{
    return err is XErr ? "An XErr error" : "An YErr error";
}



function name_to_string(Name nm) returns string{

    // using is operator
    if nm is string{
        return nm;
    }else{
        return nm.firstname + " " + nm.lastname;
    }
}
    




// public makes this function accessible outside the module
public function main() {
    string name = "Precious"; // local variable

    io:println("Global " + greeting); // every statement must be terminated by a semi-colon
    io:println(name+" is here");

    int sum_up = add(4,5);
    io:println("Sum of 4 and 5 is: ",sum_up);

    // Integers
    // Ballerina defaults to a 64-bits signed integer
    // it could be decimal or hexadecimal
    int m = 1;
    int n = 0xFFFF;
    io:println("Integers ", m," ",n);
    // Integers supports 
    //      arithemetic operators: +, -, *, /, and %
    //      comparison operators: ==, !=, <, >, <=, >=
    //      compound assignment operators: +=, -=
    //      bitwise operators:  &, |, ^, ~, <<, and >>

    // Integer does not support increment and decrement operators (++,--)
    // Interger overflow will result to runtime error

    // Floating point numbers
    // Ballerina defaults to a 64-bits binary representation
    // they support operations like integers except bitwise operations
    float x = 1.0;
    io:println("Float var x ", x);

    // Implicit conversion not supported,
    // But explicit conversion can be done with <T> notation
    int g = 2;
    float y = x + <float>g;
    io:println("Float with explicit conversion from n:", n, "ans: ", y);


    // Booleans and conditional
    // Booleans are just true and false;

    boolean flag = true;
    // boolean supports !,||,and && operators
    int z = flag ? 1:0;// boolean in expression
    io:println("Boolean(expression) ", z);

    // Conditional Statements
    // Parenthesis are optional
    if flag{
        io:println("There's a flag");
    }else{
        io:println("No flag");
    }


    // Nil (also refered to as null in Javascript)
    // it represented as ()
    // supports == and != for comparison
    int? v = (); // means the type should be either an int or nil;

    io:println("Nil val() > ", v);

    boolean isNil = v == () ? true : false;
    io:println("Is value nil ", isNil);

    // Functions that has no return statement
    // defaults to return (), like
    //      function foo() returns () {
    //          return ();
    //      }
    // 

    // Strings
    // strings are immutable sequences of zero or more unicode characters
    // they are enclosed in double quotes
    // they support == to compare character
    // they support <, <=, =>, and > to compare code points
    // they support + for concatenation
    string question_mark = "\u{1F600}";
    io:println("String literal ", question_mark);

    io:println("String literal(concatenated", "Hey" + question_mark);
    // string character can be accessed using it index e.g s[i]
    // Ballerina does not support character, as it is considered a string of length one


    // Langlib functions
    // Ballerina provides lang libraries for operations on built-in datatypes
    string prefix = "Precious".substring(0,3);
    io:println("Prefix substring ", prefix, "...");

    int name_length = "Precious".length();
    io:println("String 'Precious' is of length ", name_length);

    // we can import a type from lang directly and use it member
    int name_length_with_imported_method = string:length("Precious");
    io:println("String 'Precious' is of length(using import) ", name_length_with_imported_method);


    //  -------------- Data Structures ---------
    // Arrays
    // Arrays are sequential data structures consisting of values of SAME TYPE
    int[] arr = [1,2,3];
    io:println("Array, ", arr);
    // Values can be access with indexes e.g 
    int val1 = arr[0];
    io:println("Array first value ", val1);

    // Arrays are mutable
    // Arrays support == and !== comparison operators(deep comparison of values and order)
    int arr_lent = arr.length();
    io:println("Array of length ", arr_lent);

    // ----- Loops -----
    // For loops
    float[] vv = [0.3,0.5,0.6];
    foreach float xx in vv{
        io:println("Iter val: ", xx);
    }
    
    // For each on a range of numbers
    foreach int xvv in 0..<vv.length(){
        io:println("Range val: ", xvv);
    }
    
    // While Loops
    int count = 1;
    while true{
        io:println("Running loop: ",count);

        if count >10{
            break;
        }
        if count%2 == 0{
            io:println("Encountered an even number: ", count);
        }

        count += 1;
    }


    // Binary data
    // they are represented by an array of bytes
    byte[] data = base64 `yPHaytRgJPg+QjjylUHakEwz1fWPx/wXCW41JSmqYW8=`;
    io:println("Bytes: ", data);
    // A byte is between the number 0 and 0xFF
    byte bb = 0XFF;
    io:println("Byte: ", bb);


    // Maps
    //  they are associative structures on multiple (string values) as keys and thier values
    // supports == and != for comparison
    map<int> mm = {
        "x":1,
        "y":2
    };

    io:println("Map: ", mm);
    // Maps are like json, they are mutable
    mm["z"] = 5;
    // accessible like mm['x'], returns the value or nill if key not present
    int? mx = mm["x"]; // if key is not present, it returns nill '()'
    io:println("Updated Map: ", mm);
    io:println("Map value of 'x': ", mx);

    // langlib provides a function get(k) which get the value mapped to k
    // also keys( ) which returns an array containing all the key strings of the map


    // Using custom defined types
    MapArray arr_m = [
        {"x":"foo"},
        {"y":"bar"}
    ];

    io:println("Custom map array: ", arr_m);

    PhoneNumber ph = 8122137834;
    io:println("Phone number type, ", ph);
    Ids d_ids = [8,12,21,3,78,34];
    io:println("Id types", d_ids);

    // Records
    //  A record is a collection of fields of a specific type
    //  it gives us control over what the keys are
    record {int x; int y;} r = {
        x:1,
        y:2
    };

    io:println("Record: ", r);

    // using a type definition of record
    Coord cd = {x:1,y:2};
    io:println("Coord: ", cd);

    // we access record values using . notation
    io:println("A record value: ", cd.x);


    // Structural Typing
    flexType af = 1;
    io:println("Union of a type int: ", af);
    flexType ast = "Hello";
    io:println("Union of a type string: ", ast);


    io:println("User name ", name_to_string("Precious"));

    Profile user = {
        firstname:"Precious",
        lastname:"Olusola"
    };

    io:println ("User profile name ", name_to_string (user));


    // Working with error reporting
    // string vn = "4";
    int|error stt = parse("s");
    io:println("Parsed: ", stt);


    // Running Test on panic
    // int div = division(4,0);
    // io:println("Division: ", div);


    // Any type
    // Ballerina allows defining a value to any type except error
    // the type can be casted to a type using <T>x
    any vx = 1;
    io:println("Any type vx: ", vx);
    // casting the type
    int nx = <int>vx;
    io:println("Casted any type to int: ", nx);

    // any type can be converted to string
    string sx = vx.toString();
    io:println("Casted any type to string by conversion: ", sx);

    // using operators on any
    float fx = vx is int|float ? <float>vx:0.0;
    io:println("Casting with operators: ", fx);


    // Function return values
    // Ballerina doesn't allow us to not assign a function call to a variable
    // except that function returns a nil
    // int divx = division(4,2); // allowed
    // division(4,2); // not allowed because it returns a type int
    // but implicit assignments to _ is allowed
    _ = division(4,2); // this is allowed

    doX(); // this is allowed as it returns nil


    // when a function returns an error type,
    // it has to be handled, 
    // the checkpanic panic keyword will panic instead of ignoring
    // checkpanic shouldPanic();


    // Convariance
    // for example, if we have an array of integers int[] arrn;
    // we can use the any type to assign arrn to it like any anrn = arrn;
    // but because arrn is now any, doesn't gives us the opportunity to change it values to another type
    // arrn[0] = "str"; // will panic

    any[] arn = ["str",4]; // defining an array of multiple types of value
    io:println("Multi types: ", arn);


    

}


// This function isn't accessible outside the module
// Functions are defined as follows
// function [name]([type] [var],...) returns [type]{}
function add(int x, int y) returns int{
    int sum = x +y;
    return sum;
}

// Error reporting
// errors as first class citizens in Ballerina
function parse(string s) returns int|error{
    int n = 0;
    int[] cps = s.toCodePointInts();
    io:println("Code points: ", cps);

    foreach int cp in cps{
        int p = cp - 0x30;
        if p < 0 || p >9{
            return error("not a digit");
        }
        n = n*10 + p;
    }

    return n;
}

function IntFromBytes(byte[] bytes) returns int|error{
    string|error ret = string:fromBytes(bytes);

    if ret is error{
        return ret;
    }else{
        return int:fromString(ret);
    }
}

// Using check
function IntFromBytesWithCheck(byte[] bytes) returns int|error {

    string ret = check string:fromBytes(bytes); // check for errors and return immediately if any
    
    return int:fromString(ret);
    
}


// Panics
// panics are like rasing an code crashing error
function division(int m, int n) returns int{
    if n==0{
        panic error("division by 0");
    }

    return m/n;
}

function doX()returns (){
    io:println("Does nothing..");
    return ();
}

function shouldPanic() returns error{
    return error("Panicking error!");
}