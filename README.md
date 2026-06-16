#  ManualHttpOverTCP

This sample console app was developed to show how you can implement HTTP functionality on top of TCP protocol in an app developed with [Swift](https://swift.org) programming language.

The app connects to a web server, using TCP and makes a HTTP GET request, printing out the response. Note that the demo does not work with HTTPS, at port 443, but only with HTTP.

This sample is based on the chat client example, part of Swift NIO library (see Dependencies).

You can see a demo video of the app running in [YouTube](https://youtu.be/tY7YDCyZ2Dk).

## Usage

Build the app:

`swift build`

And then run it, either without parameters...:

`.build/debug/ManualHTTPoverTCP`

...to *attempt* to get the current weather in Linnanmaa, Oulu in xml format from weather.willab.fi:

```
Starting ManualHttpOverTCP...
Connected to server: [IPv4]193.166.161.62/193.166.161.62:80.
 Press ^D to exit.
Writing buffer: 
GET / HTTP/1.1
Host: weather.willab.fi
User-Agent: ManualHTTPoverTCPDemo/0.0.1
Accept: */*

Wrote buffer to channel.
Press enter to exit app
HTTP/1.1 301 Moved Permanently
Server: nginx/1.18.0 (Ubuntu)
Date: Tue, 16 Jun 2026 08:17:05 GMT
Content-Type: text/html
Content-Length: 178
Connection: keep-alive
Location: https://weather.willab.fi/

<html>
<head><title>301 Moved Permanently</title></head>
<body>
<center><h1>301 Moved Permanently</h1></center>
<hr><center>nginx/1.18.0 (Ubuntu)</center>
</body>
</html>
```

Since the server does not (anymore) support HTTP, only HTTPS, you will see the 301 notification response.

You can pass another server, port and and path to access something else:

```
> swift run ManualHTTPoverTCP www.oulu.fi 80 /
Building for debugging...
[7/7] Applying ManualHTTPoverTCP
Build of product 'ManualHTTPoverTCP' complete! (1.84s)
Starting ManualHttpOverTCP...
Connected to server: [IPv4]130.231.10.10/130.231.10.10:80.
 Press ^D to exit.
Writing buffer: 
GET / HTTP/1.1
Host: www.oulu.fi
User-Agent: ManualHTTPoverTCPDemo/0.0.1
Accept: */*

Wrote buffer to channel.
Press enter to exit app
HTTP/1.1 302 Found
Date: Tue, 16 Jun 2026 08:23:15 GMT
Server: Apache/2.4.6 (Red Hat Enterprise Linux) OpenSSL/1.0.2k-fips mod_perl/2.0.11 Perl/v5.16.3
Location: https://www.oulu.fi/
Content-Length: 204
Content-Type: text/html; charset=iso-8859-1

<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>302 Found</title>
</head><body>
<h1>Found</h1>
<p>The document has moved <a href="https://www.oulu.fi/">here</a>.</p>
</body></html>
```

As you can see, you can also use `swift run ... ` to launch the app, recompiling if needed. Here:

1. `ManualHTTPoverTCP` is the app name to launch.
1. First parameter `weather.willab.fi` is the host name to connect to.
1. Second parameter is the port number (`80`) to connect with TCP (default port for HTTP).
1. Third parameter `/weather.xml` is the request path sent to the server with HTTP GET.

You can use the app to try to connect to other servers than weather.willab.fi. Note that this app does not support HTTPS, it only uses TCP, not TLS/SSL, so you cannot use it with HTTPS servers.

## Dependencies

The app uses [Swift.NIO](https://github.com/apple/swift-nio).

See `Package.swift` for details.

## Who made this

This app was made as a sample for the 1st year course Devices and Networks, in the Study program for Information Processing Science, University of Oulu, Finland.

* (c) Antti Juustila, 2019-2026
* INTERACT Research Unit
* University of Oulu, Finland
