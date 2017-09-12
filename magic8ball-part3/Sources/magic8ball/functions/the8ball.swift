//
//  mustachedHandler.swift
//  magic8ball
//
//  Created by Jonathan Guthrie on 2017-08-07.
//

import Foundation

func the8ball() -> String {
	var answers = [String]()
	answers.append("It is certain")
	answers.append("It is decidedly so")
	answers.append("Without a doubt")
	answers.append("Yes definitely")
	answers.append("You may rely on it")
	answers.append("As I see it, yes")
	answers.append("Most likely")
	answers.append("Outlook good")
	answers.append("Yes")
	answers.append("Signs point to yes")
	answers.append("Reply hazy try again")
	answers.append("Ask again later")
	answers.append("Better not tell you now")
	answers.append("Cannot predict now")
	answers.append("Concentrate and ask again")
	answers.append("Don't count on it")
	answers.append("My reply is no")
	answers.append("My sources say no")
	answers.append("Outlook not so good")
	answers.append("Very doubtful")

	return answers[Int(arc4random() % 20)]
}
