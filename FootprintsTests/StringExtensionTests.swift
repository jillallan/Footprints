//
//  String+Extension.swift
//  JournalTests
//
//  Created by Jill Allan on 13/10/2023.
//

import XCTest
@testable import Journal

final class StringExtensionTests: XCTestCase {
    
    func assertInRange(_ int: Int, in range: ClosedRange<Int>, _ message: String = "") {
        XCTAssertGreaterThanOrEqual(int, range.lowerBound, message)
        XCTAssertLessThanOrEqual(int, range.upperBound, message)
    }
    
    func testString_randomWord_createsARandomWord() {
        // if
        let testParameterArray = [
            [5...10, true, true, "Should create a random word of length in range: \(5...10)"],
            [5...5, true, true, "Should create a random word of length in range: \(5...5)"],
            [5...10, true, false, "Should create a random word of length in range: \(5...10), with no capitals"],
            [5...10, false, true, "Should create a random word of length in range: \(5...10), with no digits"],
            [5...10, false, false, "Should create a random word of length in range: \(5...10), with digits or capitals"],
        ]
        
        for test in testParameterArray {
            // when
            let randomWord = String.randomWord(length: test[0] as! ClosedRange<Int>, includeDigits: test[1] as! Bool, includeCapitals: test[2] as! Bool)
            
            // then
            assertInRange(randomWord.count, in: test[0] as! ClosedRange<Int>, test[3] as! String)
        }
    }
    
    func testString_randomSentence_createsARandomSentence() throws {
        // if
        
        // when
        let randomSentence = String.randomSentence()
        print(randomSentence)
        
        let firstletter = try XCTUnwrap(randomSentence.first)
        let lastCharacter = try XCTUnwrap(randomSentence.last)
        var allOtherCharacters = randomSentence.replacingOccurrences(of: " ", with: "")
        allOtherCharacters.removeFirst()
        allOtherCharacters.removeLast()

    
        print("Test Sentence: \(allOtherCharacters)")
        
        // then
        XCTAssertTrue(!randomSentence.isEmpty, "There should be a sentence")
        XCTAssertTrue(firstletter.isUppercase, "The first letter of the sentence should be uppercase")
        XCTAssertEqual(lastCharacter, ".", "The last character of the sentences should be a full stop")
        _ = allOtherCharacters.map { character in
            XCTAssertTrue(character.isLowercase, "The character \(character) should be lowercase")
            XCTAssertTrue(character.isLetter, "The character \(character) should be a letter")
        }
    }
    
    func testString_randomSentence_createsARandomParagraph() {
        // if
        
        // when
        let randomParagraph = String.randomParagraph()
        print(randomParagraph)
        
        // then
        XCTAssertTrue(!randomParagraph.isEmpty, "There should be a paragraph")
    }
}
