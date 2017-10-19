//
//  mustachedHandler.swift
//  magic8ball
//
//  Created by Jonathan Guthrie on 2017-08-07.
//

import Foundation

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
