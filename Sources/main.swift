//
//  main.swift
//  PerfectExample-ChatServer
//
//  Created by Tim Taplin on 7/7/16.
//
//

import PerfectLib
import PerfectWebSockets

// Initialize base-level services
PerfectServer.initializeServices()

// Create our webroot
let webRoot = "./webroot"
try Dir(webRoot).create()

// Add our routes and such
addChatServerHandler()

do {
    
    // Launch the HTTP server on port 8181
    try HTTPServer(documentRoot: webRoot).start(port: 8181)
    
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
