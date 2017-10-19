//
//  main.swift
//  Magic 8-Ball Project
//
//  Created by Jonathan Guthrie
//	Copyright (C) 2017 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2017 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import Foundation
import PerfectMustache

// An example request handler.
// This 'handler' function can be referenced directly in the configuration below.
func handler(data: [String:Any]) throws -> RequestHandler {
	return {
		request, response in

		response.setHeader(.contentType, value: "text/html")

		let question = request.param(name: "q") ?? ""
		if request.method == .post, !question.isEmpty {
			var answer = "<p>\(question)</p>"
			answer += "<h3>\(the8ball())</h3>"
			response.appendBody(string: answer)
		}

		var html = "<form method=\"POST\">"
		html += "What question would you like to ask the Magic 8-Ball?"
		html += "<br>"
		html += "<input type=\"text\" name=\"q\">"
		html += "<input type=\"submit\" value=\"Ask!\">"
		html += "</form>"
		response.appendBody(string: html)

		response.completed()
	}
}

func mustacheHandler(data: [String:Any]) throws -> RequestHandler {
	return {
		request, response in
		var ctx = [String: Any]()

		let question = request.param(name: "q") ?? ""
		if request.method == .post, !question.isEmpty {
			ctx["answering"] = ["question":question, "answer": the8ball()]
		}

		response.renderMustache(template: request.documentRoot + "/templates/test.mustache", context: ctx)
	}
}


func the8ball() -> String {
	var answers = [
		"It is certain",
		"It is decidedly so",
		"Without a doubt",
		"Yes definitely",
		"You may rely on it",
		"As I see it, yes",
		"Most likely",
		"Outlook good",
		"Yes",
		"Signs point to yes",
		"Reply hazy try again",
		"Ask again later",
		"Better not tell you now",
		"Cannot predict now",
		"Concentrate and ask again",
		"Don't count on it",
		"My reply is no",
		"My sources say no",
		"Outlook not so good",
		"Very doubtful"
	]

	return answers[Int(arc4random() % 20)]
}


// Configuration data for an example server.
// This example configuration shows how to launch a server
// using a configuration dictionary.


let confData = [
	"servers": [
		// Configuration data for one server which:
		//	* Serves the hello world message at <host>:<port>/
		//	* Serves static files out of the "./webroot"
		//		directory (which must be located in the current working directory).
		//	* Performs content compression on outgoing data when appropriate.
		[
			"name":"localhost",
			"port":8181,
			"routes":[
				["method":"get", "uri":"/", "handler":mustacheHandler],
				["method":"post", "uri":"/", "handler":mustacheHandler],
				["method":"get", "uri":"/**", "handler":PerfectHTTPServer.HTTPHandler.staticFiles,
				 "documentRoot":"./webroot",
				 "allowResponseFilters":true]
			],
			"filters":[
				[
				"type":"response",
				"priority":"high",
				"name":PerfectHTTPServer.HTTPFilter.contentCompression,
				]
			]
		]
	]
]

do {
	// Launch the servers based on the configuration data.
	try HTTPServer.launch(configurationData: confData)
} catch {
	fatalError("\(error)") // fatal error launching one of the servers
}


