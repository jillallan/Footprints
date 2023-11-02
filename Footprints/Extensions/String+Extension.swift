//
//  String+Extension.swift
//  Journal
//
//  Created by Jill Allan on 13/10/2023.
//

import Foundation

extension String {
    static func randomWord(length range: ClosedRange<Int> = 5...10, includeDigits: Bool = true, includeCapitals: Bool = true) -> String {
        let length = Int.random(in: range)
        var letters = ""
        if includeDigits && includeCapitals {
            letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        } else if includeDigits {
            letters = "abcdefghijklmnopqrstuvwxyz0123456789"
        } else if includeCapitals {
            letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        } else {
            letters = "abcdefghijklmnopqrstuvwxyz"
        }
        
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    static func randomSentence() -> String {
        var length = Int.random(in: 10...20)
        var sentence = ""
        
        let firstWord = randomWord(includeDigits: false, includeCapitals: false).capitalized
        sentence.append(firstWord)
        while length > 0 {
            sentence.append(randomWord(length: 1...10, includeDigits: false, includeCapitals: false))
            sentence.append(" ")
            length -= 1
        }
        sentence.append(randomWord(length: 1...10, includeDigits: false, includeCapitals: false))
        sentence.append(".")
        return sentence
    }
    
    static func randomParagraph() -> String {
        let length = Int.random(in: 4...8)
        var paragraph = ""
        for _ in Range(1...length) {
            paragraph.append(randomSentence())
            paragraph.append(" ")
        }
        return paragraph
    }
}
