//
//  main.swift
//  ManualHTTPoverTCP
//
//  Created by Antti Juustila on 03/10/2019.
//  Copyright © 2019 Antti Juustila. All rights reserved.
//

import Foundation
import NIO

print("Starting ManualHttpOverTCP...")

private final class ManualHttpOverTCPHandler: ChannelInboundHandler {
   public typealias InboundIn = ByteBuffer
   public typealias OutboundOut = ByteBuffer
   
   private func printByte(_ byte: UInt8) {
      fputc(Int32(byte), stdout)
   }
   
   public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
      var buffer = self.unwrapInboundIn(data)
      while let byte: UInt8 = buffer.readInteger() {
         printByte(byte)
      }
   }
   
   public func errorCaught(context: ChannelHandlerContext, error: Error) {
      print("error: ", error)
      // As we are not really interested getting notified on success or failure we just pass nil as promise to
      // reduce allocations.
      context.close(promise: nil)
   }
}

let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
let bootstrap = ClientBootstrap(group: group)
   // Enable SO_REUSEADDR.
   .channelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR), value: 1)
   .channelInitializer { channel in
      channel.pipeline.addHandler(ManualHttpOverTCPHandler())
}
defer {
   try! group.syncShutdownGracefully()
}

// First argument is the program path
let arguments = CommandLine.arguments
let arg1 = arguments.dropFirst().first
let arg2 = arguments.dropFirst(2).first
let arg3 = arguments.dropFirst(3).first

let defaultHost = "weather.willab.fi"
let defaultPath = "/"
let defaultPort = 80

enum ConnectTo {
   case ip(host: String, port: Int)
   case ip(host: String, port: Int, path: String)
}

let connectTarget: ConnectTo
switch (arg1, arg2.flatMap(Int.init), arg3) {
case (.some(let h), .some(let p), .some(let p2)):
   connectTarget = .ip(host: h, port: p, path: p2)
case (.some(let h), .some(let p), _):
   /* we got two arguments, let's interpret that as host and port */
   connectTarget = .ip(host: h, port: p, path: defaultPath)
default:
   connectTarget = .ip(host: defaultHost, port: defaultPort, path: defaultPath)
}

let channel = try { () -> Channel in
   switch connectTarget {
   case .ip(let host, let port, _):
      return try bootstrap.connect(host: host, port: port).wait()
   }
   }()

print("Connected to server: \(channel.remoteAddress!).\n Press ^D to exit.")

var requestBuffer = channel.allocator.buffer(capacity: 1024)
let requestTemplate = "GET %@ HTTP/1.1\r\nHost: %@\r\nUser-Agent: SwiftApp/0.0.1\r\nAccept: */*\r\n\r\n"
var request = ""
switch (connectTarget) {
case .ip(let host, _, let path):
   request = request.appendingFormat(requestTemplate, path, host)
}
requestBuffer.writeString(request)

print("Writing buffer: ")
while let byte: UInt8 = requestBuffer.readInteger() {
   fputc(Int32(byte), stdout)
}

requestBuffer.writeString(request)
try! channel.writeAndFlush(requestBuffer).wait()
print("Wrote buffer to channel.")

print("Press enter to exit app")
while let line = readLine(strippingNewline: true) {
   if line.count == 0 {
      break
   }
}

// EOF, close connect
try! channel.close().wait()

print("ManualHttpOverTCP closed")
