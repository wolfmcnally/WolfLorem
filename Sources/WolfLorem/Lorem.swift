//
//  Lorem.swift
//  WolfLorem
//
//  Created by Wolf McNally on 2/21/17.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

//
// Based on:
//
//  LoremSwiftum.swift
//  http://github.com/lukaskubanek/LoremSwiftum
//  2014-2015 (c) Lukas Kubanek (http://lukaskubanek.com)
//

import Foundation

public class Lorem {
    public typealias Decorator = (String) -> String
    
    // ======================================================= //
    // MARK: - Text
    // ======================================================= //
    
    public static func word(emojisFrac: Double = 0) -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return word(emojisFrac: emojisFrac, using: &rng)
    }
    
    public static func word<R: RandomNumberGenerator>(emojisFrac: Double = 0, using rng: inout R) -> String {
        guard Double.random(in: 0..<1, using: &rng) > emojisFrac else { return emoji(using: &rng) }
        return allWords.randomElement(using: &rng)!
    }

    public static func words(_ count: Int, emojisFrac: Double = 0) -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return words(count, emojisFrac: emojisFrac, using: &rng)
    }
    
    public static func words<R: RandomNumberGenerator>(_ count: Int, emojisFrac: Double = 0, using rng: inout R) -> String {
        return compose(word(emojisFrac: emojisFrac, using: &rng), count: count, middleSeparator: .space)
    }

    private static let sentenceEnds: [Separator] = [
        .dot,
        .dot,
        .dot,
        .questionMark,
        .exclamationPoint
    ]
    
    private static func sentenceEnd<R: RandomNumberGenerator>(using rng: inout R) -> Separator {
        return sentenceEnds.randomElement(using: &rng)!
    }

    public static func sentence(emojisFrac: Double = 0) -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return sentence(emojisFrac: emojisFrac, using: &rng)
    }

    public static func sentence<R: RandomNumberGenerator>(emojisFrac: Double = 0, using rng: inout R) -> String {
        let numberOfWordsInSentence = Int.random(in: 4...16, using: &rng)
        let capitalizeFirstLetterDecorator: Decorator = { $0.capitalizedFirstCharacter() }
        return compose(word(emojisFrac: emojisFrac, using: &rng), count: numberOfWordsInSentence, middleSeparator: .space, endSeparator: sentenceEnd(using: &rng), decorator: capitalizeFirstLetterDecorator)
    }

    public static func shortSentence(emojisFrac: Double = 0) -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return shortSentence(emojisFrac: emojisFrac, using: &rng)
    }

    public static func shortSentence<R: RandomNumberGenerator>(emojisFrac: Double = 0, using rng: inout R) -> String {
        let numberOfWordsInSentence = Int.random(in: 3...8, using: &rng)
        let capitalizeFirstLetterDecorator: Decorator = { $0.capitalizedFirstCharacter() }
        return compose(word(emojisFrac: emojisFrac, using: &rng), count: numberOfWordsInSentence, middleSeparator: .space, endSeparator: sentenceEnd(using: &rng), decorator: capitalizeFirstLetterDecorator)
    }

    public static func sentences(_ count: Int, emojisFrac: Double = 0) -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return sentences(count, emojisFrac: emojisFrac, using: &rng)
    }

    public static func sentences<R: RandomNumberGenerator>(_ count: Int, emojisFrac: Double = 0, using rng: inout R) -> String {
        return compose(sentence(emojisFrac: emojisFrac, using: &rng), count: count, middleSeparator: .space)
    }

    public static func shortSentences(_ count: Int, emojisFrac: Double = 0) -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return shortSentences(count, emojisFrac: emojisFrac, using: &rng)
    }

    public static func shortSentences<R: RandomNumberGenerator>(_ count: Int, emojisFrac: Double = 0, using rng: inout R) -> String {
        return compose(shortSentence(emojisFrac: emojisFrac, using: &rng), count: count, middleSeparator: .space)
    }

    public static func paragraph(emojisFrac: Double = 0) -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return paragraph(emojisFrac: emojisFrac, using: &rng)
    }

    public static func paragraph<R: RandomNumberGenerator>(emojisFrac: Double = 0, using rng: inout R) -> String {
        let numberOfSentencesInParagraph = Int.random(in: 3...9, using: &rng)
        return sentences(numberOfSentencesInParagraph, emojisFrac: emojisFrac, using: &rng)
    }

    public static func paragraphs(_ count: Int, emojisFrac: Double = 0) -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return paragraphs(count, emojisFrac: emojisFrac, using: &rng)
    }

    public static func paragraphs<R: RandomNumberGenerator>(_ count: Int, emojisFrac: Double = 0, using rng: inout R) -> String {
        return compose(paragraph(emojisFrac: emojisFrac, using: &rng), count: count, middleSeparator: .newLine)
    }

    public static func title() -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return title(using: &rng)
    }

    public static func title<R: RandomNumberGenerator>(using rng: inout R) -> String {
        let numberOfWordsInTitle = Int.random(in: 2...7, using: &rng)
        let capitalizeStringDecorator: Decorator = { $0.capitalized }
        return compose(word(using: &rng), count: numberOfWordsInTitle, middleSeparator: .space, decorator: capitalizeStringDecorator)
    }

    public static func shortTitle() -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return shortTitle(using: &rng)
    }

    public static func shortTitle<R: RandomNumberGenerator>(using rng: inout R) -> String {
        let numberOfWordsInTitle = Int.random(in: 2...3, using: &rng)
        let capitalizeStringDecorator: Decorator = { $0.capitalized }
        return compose(word(using: &rng), count: numberOfWordsInTitle, middleSeparator: .space, decorator: capitalizeStringDecorator)
    }

    public static func emoji() -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return emoji(using: &rng)
    }

    public static func emoji<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return String(allEmoji.randomElement(using: &rng)!)
    }

    public static func emojis(_ count: Int) -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return emojis(count, using: &rng)
    }

    public static func emojis<R: RandomNumberGenerator>(_ count: Int, using rng: inout R) -> String {
        return compose(emoji(using: &rng), count: count, middleSeparator: .none)
    }

    public static func organizationSuffix() -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return organizationSuffix(using: &rng)
    }

    public static func organizationSuffix<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return allOrganizationSuffixes.randomElement(using: &rng)!
    }

    public static func phoneNumber() -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return phoneNumber(using: &rng)
    }

    public static func phoneNumber<R: RandomNumberGenerator>(using rng: inout R) -> String {
        let format: String = phoneFormats.randomElement(using: &rng)!
        var s = ""
        for c in Array(format) {
            if c == "#" {
                s.append(String(Int.random(in: 0 ... 9, using: &rng)))
            } else {
                s.append(c)
            }
        }
        return s
    }

    // ======================================================= //
    // MARK: - Misc
    // ======================================================= //

    public static func femaleScreenName() -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return femaleScreenName(using: &rng)
    }

    public static func femaleScreenName<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return "\(femaleFirstName(using: &rng).lowercased())\(Int.random(in: 100...999, using: &rng))"
    }

    public static func maleScreenName() -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return maleScreenName(using: &rng)
    }

    public static func maleScreenName<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return "\(maleFirstName(using: &rng).lowercased())\(Int.random(in: 100...999, using: &rng))"
    }

    public static func screenName() -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return screenName(using: &rng)
    }

    public static func screenName<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return "\(firstName(using: &rng).lowercased())\(Int.random(in: 100...999, using: &rng))"
    }

    public static func femaleFirstName() -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return femaleFirstName(using: &rng)
    }

    public static func femaleFirstName<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return femaleFirstNames.randomElement(using: &rng)!
    }

    public static func maleFirstName() -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return maleFirstName(using: &rng)
    }

    public static func maleFirstName<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return maleFirstNames.randomElement(using: &rng)!
    }

    public static func firstName() -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return firstName(using: &rng)
    }

    public static func firstName<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return firstNames.randomElement(using: &rng)!
    }

    public static func givenName() -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return givenName(using: &rng)
    }

    public static func givenName<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return firstName(using: &rng)
    }

    public static func lastName() -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return lastName(using: &rng)
    }

    public static func lastName<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return lastNames.randomElement(using: &rng)!
    }

    public static func familyName() -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return familyName(using: &rng)
    }

    public static func familyName<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return lastName(using: &rng)
    }

    public static func name() -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return name(using: &rng)
    }

    public static func name<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return "\(firstName(using: &rng)) \(lastName(using: &rng))"
    }

    public static func email(firstName: String? = nil, lastName: String? = nil) -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return email(firstName: firstName, lastName: lastName, using: &rng)
    }

    public static func email<R: RandomNumberGenerator>(firstName: String? = nil, lastName: String? = nil, using rng: inout R) -> String {
        let delimiter: String = emailDelimiters.randomElement(using: &rng)!
        let domain: String = emailDomains.randomElement(using: &rng)!
        let fn = firstName ?? self.firstName(using: &rng)
        let ln = lastName ?? self.lastName(using: &rng)
        return "\(fn)\(delimiter)\(ln)@\(domain)".lowercased()
    }

    public static func url() -> URL {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return url(using: &rng)
    }

    public static func url<R: RandomNumberGenerator>(using rng: inout R) -> URL {
        let domain: String = domains.randomElement(using: &rng)!
        return URL(string: "http://\(domain))/")!
    }

    public static func tweet() -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return tweet(using: &rng)
    }

    public static func tweet<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return tweets.randomElement(using: &rng)!
    }

    public static func pastDate() -> Date {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return pastDate(using: &rng)
    }

    public static func pastDate<R: RandomNumberGenerator>(using rng: inout R) -> Date {
        let currentDate = Date()
        let currentCalendar = Calendar.current
        var referenceDateComponents = DateComponents()
        referenceDateComponents.year = -4
        let referenceDate: Date = currentCalendar.date(byAdding: referenceDateComponents, to: currentDate)!
        let timeIntervalSinceReferenceDate: Int = Int(referenceDate.timeIntervalSinceReferenceDate)
        let randomTimeInterval = TimeInterval(Int.random(in: 0...timeIntervalSinceReferenceDate, using: &rng))
        return referenceDate.addingTimeInterval(randomTimeInterval)
    }

    public static func futureDate() -> Date {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return futureDate(using: &rng)
    }

    public static func futureDate<R: RandomNumberGenerator>(using rng: inout R) -> Date {
        let currentDate = Date()
        let currentCalendar = Calendar.current
        var referenceDateComponents = DateComponents()
        referenceDateComponents.year = 4
        let referenceDate: Date = currentCalendar.date(byAdding: referenceDateComponents, to: currentDate)!
        let timeIntervalSinceReferenceDate: Int = Int(referenceDate.timeIntervalSinceReferenceDate)
        let randomTimeInterval = -TimeInterval(Int.random(in: 0...timeIntervalSinceReferenceDate, using: &rng))
        return referenceDate.addingTimeInterval(randomTimeInterval)
    }

    public static func imageURL() -> URL {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return imageURL(using: &rng)
    }

    public static func imageURL<R: RandomNumberGenerator>(using rng: inout R) -> URL {
        return URL(string: imageURLs.randomElement(using: &rng)!)!
    }

    private static func _avatarURL<R: RandomNumberGenerator>(type: String, using rng: inout R) -> URL {
        let n = Int.random(in: 0...99, using: &rng)
        return URL(string: "https://randomuser.me/api/portraits/\(type)/\(n).jpg")!
    }

    public static func maleAvatarURL() -> URL {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return maleAvatarURL(using: &rng)
    }

    public static func maleAvatarURL<R: RandomNumberGenerator>(using rng: inout R) -> URL {
        return _avatarURL(type: "men", using: &rng)
    }

    public static func femaleAvatarURL() -> URL {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return femaleAvatarURL(using: &rng)
    }

    public static func femaleAvatarURL<R: RandomNumberGenerator>(using rng: inout R) -> URL {
        return _avatarURL(type: "women", using: &rng)
    }

    public static func avatarURL() -> URL {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return avatarURL(using: &rng)
    }

    public static func avatarURL<R: RandomNumberGenerator>(using rng: inout R) -> URL {
        return Bool.random(using: &rng) ? maleAvatarURL(using: &rng) : femaleAvatarURL(using: &rng)
    }

    public static func password() -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return password(using: &rng)
    }

    public static func password<R: RandomNumberGenerator>(using rng: inout R) -> String {
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        let digits = "0123456789"
        let symbols = "!@#$%^&*-_=+"
        var result = (0..<Int.random(in: 6...12, using: &rng)).reduce("") { (result, _) in
            return result + String(alphabet.randomElement(using: &rng)!)
        }
        result.insert(digits.randomElement(using: &rng)!, at: result.indices.randomElement(using: &rng)!)
        result.insert(symbols.randomElement(using: &rng)!, at: result.indices.randomElement(using: &rng)!)
        return result
    }

    public static func recordID() -> Int {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return recordID(using: &rng)
    }

    public static func recordID<R: RandomNumberGenerator>(using rng: inout R) -> Int {
        return Int.random(in: 10000...99999, using: &rng)
    }

    public static func alphanumericRecordID() -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return alphanumericRecordID(using: &rng)
    }

    public static func alphanumericRecordID<R: RandomNumberGenerator>(using rng: inout R) -> String {
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        return (0..<Int.random(in: 4...8, using: &rng)).reduce("") { (result, _) in
            return result + String(alphabet.randomElement(using: &rng)!)
        }
    }

    public static func uuid() -> UUID {
        return UUID()
    }

    public static func uuidString() -> String {
        return uuid().uuidString
    }
    
    public static func letters(_ count: Int) -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return letters(count, using: &rng)
    }

    public static func letters<R: RandomNumberGenerator>(_ count: Int, using rng: inout R) -> String {
        let alphabet = Array("abcdefghijklmnopqrstuvwxyz")
        return (0 ..< count).reduce("") { result, _ in
            result + String(alphabet.randomElement(using: &rng)!)
        }
    }
    
    public static func digits(_ count: Int) -> String {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return digits(count, using: &rng)
    }

    public static func digits<R: RandomNumberGenerator>(_ count: Int, using rng: inout R) -> String {
        return (0 ..< count).reduce("") { result, _ in
            result + String(Int.random(in: 0 ... 9, using: &rng))
        }
    }
    
    public static func data(_ count: Int) -> Data {
        var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
        return data(count, using: &rng)
    }

    public static func data<R: RandomNumberGenerator>(_ count: Int, using rng: inout R) -> Data {
        var result = Data()
        for _ in 0 ..< count {
            result.append(UInt8.random(in: 0...255, using: &rng))
        }
        return result
    }

    // ======================================================= //
    // MARK: - Private
    // ======================================================= //

    private enum Separator: String {
        case none = ""
        case space = " "
        case dot = "."
        case questionMark = "?"
        case exclamationPoint = "!"
        case newLine = "\n"
    }

    private static func compose(_ provider: @autoclosure () -> String, count: Int, middleSeparator: Separator, endSeparator: Separator = .none, decorator: Decorator? = nil) -> String {
        var composedString = ""

        for index in 0..<count {
            composedString += provider()

            if index < count - 1 {
                composedString += middleSeparator.rawValue
            } else {
                composedString += endSeparator.rawValue
            }
        }

        if let decorator = decorator {
            return decorator(composedString)
        } else {
            return composedString
        }
    }

    // ======================================================= //
    // MARK: - Data
    // ======================================================= //

    private static let allOrganizationSuffixes = "Inc. Co. Ltd LLC LLP".components(separatedBy: " ")

    private static let allEmoji = "😀😁😅🤣😇😍🤪🤓🤩😎😡😳😰🤗🙄😲🤐🤮😈🤡💩👻💀👽🎃😺😻🤲🏻🙌🏼👍🏼✊🏼✌🏼🤘🏼💄👁👧🏻👨🏽‍⚕️👨🏼‍🚀🧙🏼‍♂️👼🏼🤷🏼‍♀️👨‍❤️‍💋‍👨👪👔🐱🐶🐯🐵🙈🙉🙊🐤🦆🐺🐝🐞🐙🦈🐳🐂🦌🐿🍀🌞🌙🌏🌟🌧💦☔️🍉🍓🥩🍛🍧🥛🍸🎱⛹🏼‍♂️🧗🏼‍♀️🎪🎺🎲🚙🚇🏟🏤🌁🕹💶💊🔑📆📘✏️❤️💙🖤☮️🈺🅰️💯⚠️✳️🅿️🆒🎵✖️☑️🔴🔶🔔♣️🏳️🏁🏳️‍🌈"

    private static let allWords = "alias consequatur aut perferendis sit voluptatem accusantium doloremque aperiam eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo aspernatur aut odit aut fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt neque dolorem ipsum quia dolor sit amet consectetur adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem ut enim ad minima veniam quis nostrum exercitationem ullam corporis nemo enim ipsam voluptatem quia voluptas sit suscipit laboriosam nisi ut aliquid ex ea commodi consequatur quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae et iusto odio dignissimos ducimus qui blanditiis praesentium laudantium totam rem voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident sed ut perspiciatis unde omnis iste natus error similique sunt in culpa qui officia deserunt mollitia animi id est laborum et dolorum fuga et harum quidem rerum facilis est et expedita distinctio nam libero tempore cum soluta nobis est eligendi optio cumque nihil impedit quo porro quisquam est qui minus id quod maxime placeat facere possimus omnis voluptas assumenda est omnis dolor repellendus temporibus autem quibusdam et aut consequatur vel illum qui dolorem eum fugiat quo voluptas nulla pariatur at vero eos et accusamus officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae itaque earum rerum hic tenetur a sapiente delectus ut aut reiciendis voluptatibus maiores doloribus asperiores repellat".components(separatedBy: " ")

    private static let maleFirstNames = "Abel Alberto Alfredo Allen Alonzo Alvin Andre Andres Angelo Antonio Arturo Ashton Auryn Bart Beau Bevan Billie Billy Brayden Brendan Brenden Brendon Brock Bryce Byron Caleb Calum Casey Chris Ciaran Clint Clinton Clyde Collin Colm Colton Connor Dalton Daren Darius Daryl Davion Denis Dirk Dominick Don Dwayne Earl Eli Elias Emiliano Eric Ewan George Gordon Grady Guy Hamish Harrison Harvey Hector Hudson Ian Jamal Jared Jason Javon Jerald Joey John Johnnie Johnny Kaden Kelvin Kendrick Kenneth Kerry Kerry Kieran Leland Lorenzo Luis Manuel Mohammed Monty Moses Neil Niall Nolan Omar Orlaith Patrick Pete Phil Preston Quinn Rafael Randal Raul Reese Reid Robert Roberto Rogelio Rolando Ruben Samuel Shawn Teddy Terry Toby Tomas Ty Vance Virgil Wayne Wendell Yehudi Zachariah".components(separatedBy: " ")

    private static let femaleFirstNames = "Abigail Adrianna Agnes Alexa Alexandra Alexis Allyson Alma Alondra Alyson Ana Angela Angelina Aniya Annika Antoinette Beth Bianca Bonita Bonnie Brooklynn Caitlyn Camila Cara Carla Carley Carly Carmen Cathleen Chris Ciara Cindy Constance Courtney Cynthia Danielle Deana Dora Doris Dulce Elaine Elise Eliza Emely Emma Eoin Esmeralda Fatima Francesca Freya Gayle Geraldine Giselle Gretchen Harriet Ida Inley Isabel Isabelle Jackie Jacquelyn Jadyn Jamie Janet Jean Joann Jordyn Josephine Judith Justice Kailey Kaleigh Katherine Katie Kaylin Kellie Kelly Kristi Kyla Kyleigh Kyra Laila LaTonya Leslie Lexi Liliana Lori Lorie Lucinda Lynette Madeline Maggie Maisie Makenzie Margarita Marianne Marsha Marybeth Melinda Michelle Mitzi Mya Nadia Nia Nika Noel Noelle Paola Peggy Penny Perla Piper Ruby Rylee Sadie Sheryl Shirley Sienna Skye Skylar Skyler Sonja Staci Stephanie Summer Sydney Tammie Tonia Tracy Tricia Trisha Uriel Vanessa Xena Yvonne Zoe".components(separatedBy: " ")

    private static let firstNames: [String] = {
        var a = Lorem.maleFirstNames
        a.append(contentsOf: Lorem.femaleFirstNames)
        return a
    }()

    private static let lastNames = "Chung Chen Melton Hill Puckett Song Hamilton Bender Wagner McLaughlin McNamara Raynor Moon Woodard Desai Wallace Lawrence Griffin Dougherty Powers May Steele Teague Vick Gallagher Solomon Walsh Monroe Connolly Hawkins Middleton Goldstein Watts Johnston Weeks Wilkerson Barton Walton Hall Ross Chung Bender Woods Mangum Joseph Rosenthal Bowden Barton Underwood Jones Baker Merritt Cross Cooper Holmes Sharpe Morgan Hoyle Allen Rich Rich Grant Proctor Diaz Graham Watkins Hinton Marsh Hewitt Branch Walton O'Brien Case Watts Christensen Parks Hardin Lucas Eason Davidson Whitehead Rose Sparks Moore Pearson Rodgers Graves Scarborough Sutton Sinclair Bowman Olsen Love McLean Christian Lamb James Chandler Stout Cowan Golden Bowling Beasley Clapp Abrams Tilley Morse Boykin Sumner Cassidy Davidson Heath Blanchard McAllister McKenzie Byrne Schroeder Griffin Gross Perkins Robertson Palmer Brady Rowe Zhang Hodge Li Bowling Justice Glass Willis Hester Floyd Graves Fischer Norman Chan Hunt Byrd Lane Kaplan Heller May Jennings Hanna Locklear Holloway Jones Glover Vick O'Donnell Goldman McKenna Starr Stone McClure Watson Monroe Abbott Singer Hall Farrell Lucas Norman Atkins Monroe Robertson Sykes Reid Chandler Finch Hobbs Adkins Kinney Whitaker Alexander Conner Waters Becker Rollins Love Adkins Black Fox Hatcher Wu Lloyd Joyce Welch Matthews Chappell MacDonald Kane Butler Pickett Bowman Barton Kennedy Branch Thornton McNeill Weinstein Middleton Moss Lucas Rich Carlton Brady Schultz Nichols Harvey Stevenson Houston Dunn West O'Brien Barr Snyder Cain Heath Boswell Olsen Pittman Weiner Petersen Davis Coleman Terrell Norman Burch Weiner Parrott Henry Gray Chang McLean Eason Weeks Siegel Puckett Heath Hoyle Garrett Neal Baker Goldman Shaffer Choi Carver".components(separatedBy: " ")

    private static let emailDelimiters = ["", ".", "-", "_"]

    private static let emailDomains = "gmail.com yahoo.com hotmail.com email.com live.com me.com mac.com aol.com fastmail.com mail.com".components(separatedBy: " ")

    private static let domains = "twitter.com google.com youtube.com wordpress.org adobe.com blogspot.com godaddy.com wikipedia.org wordpress.com yahoo.com linkedin.com amazon.com flickr.com w3.org apple.com myspace.com tumblr.com digg.com microsoft.com vimeo.com pinterest.com qq.com stumbleupon.com youtu.be addthis.com miibeian.gov.cn delicious.com baidu.com feedburner.com bit.ly".components(separatedBy: " ")

    private static let phoneFormats = ["(###) ###-####", "###-###-####", "+1 ### #######", "+44 ## #### ####", "(01 ##) #### ####", "+33 # ## ## ## ##", "+61 # #### ####"]

    private static let tweets = [
        "I was born in the cemetery under the blood red moon. From fire and death and brutal destruction I bring this unholy message: Surfs up.",
        "I was driving last night on a lonely dark road and met this alien or maybe a really ugly girl and it gave me the lottery numbers.",
        "\"I'm pretty popular on the internet,\" I whisper to my cat. Cat doesnt respond because cat doesnt exist. There is no cat and I am alone.",
        "When I take a girl to meet my parents, I bring her to a cemetery and say \"There they are,\" and point to some ducks.",
        "You're in a park hangin out w people. All the people are dogs and you're a dog. You've never heard of Twitter and your life isn't miserable.",
        "Cat enters hotel room, tosses gun on bed, peers out window. \"So this is where it all ends,\" he softly whispers.",
        "My brain says no but my heart says yes and my mouth says why do my organs have mouths and my spleen says dude a mad scientist kidnapped us."
    ]

    private static let imageURLs = [
        "https://68.media.tumblr.com/3f5d6a2ed0c4a5f1f64c95d54073bf7f/tumblr_okametxqXC1w1ctyao1_500.png", // unlikely river
        "https://68.media.tumblr.com/15a3fe1eedcbf4a7d6a950202affac5e/tumblr_of3rh4IuJ21trkvxko1_500.jpg", // space between
        "https://68.media.tumblr.com/ee912a87e833e486e614dba128a0513a/tumblr_obuwahGNwg1sn3ne4o1_500.jpg", // luminous tree
        "https://68.media.tumblr.com/0b4921df4f50a44b2d83a4b4517f66e5/tumblr_obm6a54QN31s44okeo1_500.jpg", // visitor
        "https://68.media.tumblr.com/062874323dc4358698b8ffdcf26ccd40/tumblr_o8fkrsJmhO1v1jf78o1_500.jpg", // blue sky face
        "https://68.media.tumblr.com/62961458ffbecd94749e72943b2b22ec/tumblr_o85yvko2AM1sj1s6vo1_500.jpg", // dreamscape #3
        "https://68.media.tumblr.com/c85a271c5b58546c28810d3d435f1589/tumblr_o6yveo9ILF1udk56ko1_500.jpg", // front gate
        "https://68.media.tumblr.com/3abdc77808bf1c75b470dac0e58b114e/tumblr_o5blg2Cu881voapweo8_500.jpg", // grasso house
        "https://68.media.tumblr.com/a3283144b6f16ff511c9219bfd95a29f/tumblr_o3i0xbQKZS1rr0102o1_540.jpg", // magritte human condition
        "https://68.media.tumblr.com/477f63f6b43dbb0a70692458a4b2464d/tumblr_olrjrmDDnl1vj0qybo1_540.jpg", // queen of space

        "https://68.media.tumblr.com/a7a9ac0ec9f4d5ec163d3cbc831c8878/tumblr_ojuhdklyRQ1ttzaedo1_r1_500.jpg", // the intellect
        "https://68.media.tumblr.com/9ca1d580d01f9288f6519dbe29b2fbf2/tumblr_of450kXtVY1ttzaedo1_500.jpg", // salvia droid
        "https://68.media.tumblr.com/279af3ef9994891d2136f5737077fd1a/tumblr_ntibnkhYrw1tfdblio1_500.jpg", // mattingly couple
        "https://68.media.tumblr.com/c5d63160b2af33da912e47eeef728e56/tumblr_oc78hiG5H21ttzaedo1_r1_500.png", // familiar stranger
        "https://68.media.tumblr.com/17bf718ac8387c9fd9295a8abbacc765/tumblr_nvw3tsavY71qgxdtao1_500.jpg", // beauty in perspective
        "https://68.media.tumblr.com/83fcf28632dcd16f492f7f17493df9ce/tumblr_ntnr8gtUDK1uywqfao1_500.jpg", // bautista this queer curiosity
        "https://68.media.tumblr.com/8d3f3f938b49ea4dae3a6fb674a6c954/tumblr_nrjecjv3Pe1u1uaauo1_500.jpg", // bautista mine
        "https://68.media.tumblr.com/ac6a52b3f129da7a551515a6e5f15f7a/tumblr_nmcmic62Oi1u1uaauo1_500.jpg", // bautista no
        "https://s-media-cache-ak0.pinimg.com/736x/b3/cb/a5/b3cba5d6b7d7b7013a0e282a8dbbc607.jpg", // parkes juggler
        "https://s-media-cache-ak0.pinimg.com/736x/c7/65/0a/c7650affd2fa0d4e2cda5128a2275976.jpg" // parkes gargoyle
    ]

    private static let colors = "red orange yellow green blue violet purple gray black white brown cyan magenta silver gold mahogany chestnut tangerine sepia copper tan peach goldenrod aquamarine turquoise cerulean periwinkle indigo fuchsia pink maroon mauve scarlet".components(separatedBy: " ")
    private static let animals = "alligator ant bear bee bird camel cat cheetah chicken chimpanzee cow crocodile deer dog dolphin duck eagle elephant fish fly fox frog giraffe goat goldfish hamster hippopotamus horse kangaroo kitten lion lobster monkey octopus owl panda pig puppy rabbit rat scorpion seal shark sheep snail snake spider squirrel tiger turtle wolf zebra".components(separatedBy: " ")
    private static let adjectives = "droit amatory animistic arcadian baleful bellicose bilious boorish calamitous caustic cerulean comely concomitant contumacious corpulent crapulous defamatory didactic dilatory dowdy efficacious effulgent egregious endemic equanimous execrable fastidious feckless fecund friable fulsome garrulous gustatory heuristic incendiary insidious insolent intransigent inveterate invidious irksome jejune jocular judicious lachrymose limpid loquacious luminous mannered mendacious meretricious minatory mordant munificent nefarious noxious parsimonious pendulous pernicious pervasive petulant precipitate propitious puckish querulous quiescent rebarbative recalcitrant redolent risible ruminate sagacious salubrious sartorial sclerotic serpentine spasmodic strident taciturn tenacious tremulous trenchant turbulent turgid ubiquitous uxorious verdant voluble voracious wheedling withered alert able acceptable accurate ample angry agile amused aromatic austere brisk bulky busy beautiful blind bouncy brave big blissful bold brilliant charming cheery clever courteous cultured calm careless costly crafty cuddly cute carefree cheerful colossal complex corageous crazy dapper deadly decisive dazzling deep defiant devoted dangerous delightful diligent disguised dramatic dutiful earnest elaborate energetic enraged esteemed excellent exciting exotic eager eminent elated elegant envious euphoric fabulous flashy flawless flippant fragrant frugal fussy fearless flowery frivolous frosty famous feisty flamboyant fluffy fortunate friendly funny generous giant gracious grumpy gentle glorious gregarious gleaming gullible hefty honorable huge harmless hilarious humble honest hungry imaginary imperfect intrepid important incredible impeccable infamous innocent jealous joyous jovial jubilant kind kooky keen limping lovely loyal luminous lucky likable lustrous majestic modern miniature marvelous naive needy naughty noisy nervious nutty obedient ornery opulant ornate passionate perfumed proper playful pleasing proud perky pesky popular powerful pretty prudent puzzling quaint quick quirky radiant regal ragged reckless robust sad sardonic satisfied sparkling shy shiny smart sneaky sociable strange subtle striped swift talkative tender tricky trusting testy thoughtful trusty unique upbeat uncommon vibrant virtuous vigorous vapid vivacious weighty worthwhile worn wretched weird winged witty worthy warm wild wet wiry wrathful yawning young youthful zany zealous zesty".components(separatedBy: " ")

    public static func color() -> String {
        var rng = SystemRandomNumberGenerator()
        return color(using: &rng)
    }

    public static func color<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return colors.randomElement(using: &rng)!
    }

    public static func animal() -> String {
        var rng = SystemRandomNumberGenerator()
        return animal(using: &rng)
    }

    public static func animal<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return animals.randomElement(using: &rng)!
    }

    public static func adjective() -> String {
        var rng = SystemRandomNumberGenerator()
        return adjective(using: &rng)
    }

    public static func adjective<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return adjectives.randomElement(using: &rng)!
    }

    public static func adjectiveOrColor() -> String {
        var rng = SystemRandomNumberGenerator()
        return adjectiveOrColor(using: &rng)
    }

    public static func adjectiveOrColor<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return Bool.random(using: &rng) ? adjective(using: &rng) : color(using: &rng)
    }

    public static func codeName() -> String {
        var rng = SystemRandomNumberGenerator()
        return codeName(using: &rng)
    }

    public static func codeName<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return [adjectiveOrColor(using: &rng), animal(using: &rng)].joined(separator: " ")
    }

    public static func longCodeName() -> String {
        var rng = SystemRandomNumberGenerator()
        return longCodeName(using: &rng)
    }

    public static func longCodeName<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return [adjective(using: &rng), color(using: &rng), animal(using: &rng)].joined(separator: " ")
    }

    /// https://github.com/satoshilabs/slips/blob/master/slip-0039/wordlist.txt
    private static let recoveryWords = "academic acid acoustic actor actress adapt adjust admit adult advance advice aerobic afraid again agent agree airport aisle alarm album alcohol alert alien alpha already also alter always amazing amount amused analyst anchor anger angry animal answer antenna antique anxiety anything apart april arctic arena argue armed armor army artefact artist artwork aspect atom auction august aunt average avocado avoid awake away awesome awful awkward axis bean beauty because become bedroom behave believe below bench benefit best betray between beyond bicycle bike biology bird birth black blame blanket bleak blind blossom boat body bomb border bounce bowl bracket brain brand brave bread bridge brief broccoli broken brother brown brush budget build bulb burden burger burn busy buyer cactus camera campaign canal canyon capital captain carbon career carpet casino castle catalog catch category cause ceiling cement census chair chaos chat cheap check choice chuckle churn circle city civil claim clap clarify clean clerk clever click client climb clinic clog closet cloth clown club clump cluster coach coconut code coil column comfort comic coral corn cost country cousin cover coyote cradle craft crane crater crazy credit crew cricket crime crisp critic cross crouch crowd crucial cruel cruise crunch crystal cube culture cupboard curious curve cycle daily damage dance daughter death debris decade december decision decline decorate decrease degree delay deliver denial dentist deny depart depend describe desert design desk despair destroy detail detect device devote diamond diary diesel diet dilemma direct disagree dismiss display distance divert divorce doctor dolphin domain dose double dozen dragon drama drastic dream dress drift drink drum duck dumb dune dwarf dynamic eager eagle early earn earth easy echo ecology edge edit educate elbow elder electric elegant element elephant elevator elite else embrace emerge employ empty endless endorse enemy energy enforce engage enjoy enlist enroll entire entry envelope episode equal erase erode erosion erupt escape estate eternal event evidence evil evolve exact example excess exchange exclude excuse execute exercise exhaust exile exist exotic expand expect expire explain express extend extra eyebrow face facility faculty faint faith false family famous fancy fantasy fashion fatal fatigue favorite fiber fiction field file filter final find finish firm fiscal fish fitness flag flavor flip float flower fluid foam focus fold force forest forget fork fortune forward fragile frame frequent fresh friend fringe frog frozen fruit fuel function furnace fury gadget galaxy garden garlic gasp gate gauge general genius genre gentle gesture glad glance glare glide glimpse glue goal golden grape grass gravity great grid grocery group grow grunt guard guess guilt guitar half hamster hand harbor harvest hawk hazard head heart heavy hedgehog help hero hockey holiday hospital hotel hour huge human hundred hurdle hurt husband hybrid idea identify idle image imitate impact improve impulse inch income increase index industry infant inflict inform inhale inherit injury inmate insane insect inside install intact invite involve island isolate item ivory jacket jaguar jealous jeans jewel join joke judge juice jump jungle junk ketchup kick kingdom kitchen kite kiwi knife lady lamp large laugh laundry lava lawn lawsuit layer leader leaf league leave lecture legal legend leisure lemon length lens level liberty library license lift likely limit line living lizard loan lobster local lock loud love lucky lunar lunch luxury lyrics machine magazine magnet maid make manage mandate mango mansion manual maple marble march mask master material matrix maximum meaning measure media melt member menu mercy mesh metal method midnight minute miracle misery mistake mixed mixture mobile model modify moment more morning motor mouse movie much mule multiply muscle museum music must myself mystery myth naive name napkin neck negative neglect neither nephew nerve network news nice nuclear number obey object oblige obscure obtain ocean october odor often olive olympic orange orbit ordinary organ orient ostrich other oven owner oyster package pact painting pair palace panda panic panther paper parade parent park party path patrol pave payment peace peanut peasant pelican penalty pencil perfect period permit photo phrase physical piano picnic picture piece pilot pink pipe pistol pitch planet plastic plate play please pledge pluck plug plunge practice predict prepare present pretty primary priority prison private prize problem produce profit program promote prosper proud public pulse pumpkin pupil purchase purpose push pyramid quantum quarter question quick quiz quote rack radar radio raise ranch rapid rare raven razor ready real rebel recall receive recipe recycle regret regular reject relax rely remind remove render repair repeat replace rescue resemble resist response retreat reunion review reward rhythm rich rifle ring risk rival river road robot robust rocket romance rotate rough royal rude runway rural sadness salad salon salt satisfy satoshi sauce sausage scale scan scatter scene school science scissors scorpion scout scrap screen script scrub search seat second secret security segment select senior sense sentence service seven shadow shaft share shed sheriff shock shoe short shoulder shrimp sibling siege silent silver similar simple siren sister size skate sketch skin skirt skull slender slice slogan slow slush small smart smile smoke snake social soda soft soldier solve someone soul sound source spawn special spell spend sphere spider spike spirit split spray spread spring squeeze stadium staff stage stamp stand station stay steak step stereo stick still sting stomach stove strike strong style sugar suit sunset super surface survey swallow swap swear swift swim switch sword symbol symptom system tackle tail talent target taxi teach team tenant text thank theater theme theory throw thunder ticket tilt timber time tiny tired title toast today together toilet token tomato torch tornado tortoise total tourist tower town trade traffic transfer trash travel tray trend trial trick trim trouble true trumpet trust twelve twenty twice twin twist type typical ugly umbrella unaware uncle uncover under unfair unfold unhappy unique universe unknown until upgrade upset urge usage used useless usual vacant vacuum vague valid valve vanish vast vault velvet vendor venture verify very veteran vibrant vicious victory video view vintage violin virus visa visit vital vivid voice volcano volume vote voyage wage wagon wait walnut warfare warm warning wash waste water wealth weapon weather weird welcome western whale wheat when where width wild window winter wire wisdom wolf woman world worth wrap wreck wrestle wrist write yard young zebra".components(separatedBy: " ")

    public static func recoveryWord() -> String {
        var rng = SystemRandomNumberGenerator()
        return recoveryWord(using: &rng)
    }

    public static func recoveryWord<R: RandomNumberGenerator>(using rng: inout R) -> String {
        return recoveryWords.randomElement(using: &rng)!
    }

    public static func recoveryWords(_ count: Int) -> String {
        var rng = SystemRandomNumberGenerator()
        return recoveryWords(count, using: &rng)
    }

    public static func recoveryWords<R: RandomNumberGenerator>(_ count: Int, using rng: inout R) -> String {
            return compose(recoveryWord(using: &rng), count: count, middleSeparator: .space)
    }
}
