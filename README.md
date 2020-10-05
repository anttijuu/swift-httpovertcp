#  ManualHttpOverTCP

This sample console app was developed to show how you can implement HTTP functionality on top of TCP protocol in an app developed with [Swift](https://swift.org) programming language.

The app connects to a web server, using TCP and makes a HTTP GET request, printing out the response.

This sample is based on the chat client example, part of Swift NIO library (see Dependencies).

You can see a demo video of the app running in [YouTube](https://youtu.be/tY7YDCyZ2Dk).

## Usage

Build the app and then run it:

`./ManualHTTPoverTCP <host> <port> <path>`

For example, to get the current weather in Linnanmaa, Oulu in xml format from weather.willab.fi:

`./ManualHTTPoverTCP weather.willab.fi 80 /weather.xml`

Where

1. `./ManualHTTPoverTCP` is the app binary name to launch the app.
1. First parameter `weather.willab.fi` is the host name to connect to.
1. Second parameter is the port number (`80`) to connect with TCP (default port for HTTP).
1. Third parameter `/weather.xml` is the request path sent to the server with HTTP GET.

You can use the app to try to connect to other servers than weather.willab.fi. Note that this app does not support HTTPS, it only uses TCP, not TLS/SSL, so you cannot use it with HTTPS servers.

## Dependencies

The app uses [Swift.NIO](https://github.com/apple/swift-nio).

## Who made this

This app was made as a sample for the 1st year course Devices and Networks, in the Study program for Information Processing Science, University of Oulu, Finland.

(c) Antti Juustila, 2019-2020
INTERACT Research Unit, University of Oulu, Finland
