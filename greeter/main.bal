// Writing a simple REST API
import ballerina/http; // import http module from ballerian
// import ballerina/io; // for input and output

// 
// create a listener of type Listener on port 9090 
listener http:Listener httpListener = new (9090);

// Exposes endpoints and listens to requests
// Exposes it to /
service / on httpListener {
    // resource is like a view listening to a request
    // resource function [method] [endpoint name]() return [type defaults to text/plain content type]

    resource function get greeting() returns string {
        return "Hello World";
    }

    resource function get greeting/[string name]() returns string {
        return "Hello " + name;
    }
}

// public function main() {
//     // io:println("Hello, World!");

// }
