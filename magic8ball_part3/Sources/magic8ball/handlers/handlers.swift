//
//  mustachedHandler.swift
//  magic8ball
//
//  Created by Jonathan Guthrie on 2017-08-07.
//

import PerfectHTTP
import PerfectHTTPServer
import Foundation
import PerfectMustache

class Handlers {

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
}
