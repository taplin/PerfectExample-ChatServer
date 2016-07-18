//
//  main.swift
//  PerfectExample-ChatServer
//
//  Created by Tim Taplin on 7/7/16.
//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectWebSockets

#if os(Linux)
    import SwiftGlibc
#else
    import Darwin
#endif

// Initialize base-level services
PerfectServer.initializeServices()

// Create our webroot
let webRoot = "./webroot"
try Dir(webRoot).create()
var production = false

do {
    let server = HTTPServer()

    // Set a listen port of 8181
    server.serverPort = 8181
    
    // Add our routes and such
    let chatRoutes = addChatServerHandler()
    server.addRoutes(chatRoutes)

    // Set a document root.
    // This is optional. If you do not want to serve static content then do not set this.
    server.documentRoot = webRoot

    // Check the console to see the logical structure of what was installed.
    print(chatRoutes.navigator.description)
    
    // Gather command line options and further configure the server.
    // Run the server with --help to see the list of supported arguments.
    // Command line arguments will supplant any of the values set above.
    configureServer(server)
    // Launch the HTTP server.
    try server.start()
    
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
