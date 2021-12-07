import UIKit
import Foundation
/**
 
 Author:      Reeve Jarvis
 Date:        12/06/2021
 Course:      DGL-204 - Swift
 Assignment:  Final Project
 
 Project Description:
 
 This project was planned as a general gameroom application meant to house three games. I have had to reduce it's overall complexity, due to time constraints and personal reasons getting in the way of my studies. I have created a codebase that includes the various pieces needed to play a game of yahtzee. This is not without errors, and is not entirely complete. It is a work in progress. With that said I was able to accomplish the basic functionality needed to play a few rounds, and track the players scores based on their hand of dice. I hope you can see some worth in what I have created, and I only wish I made more time and focus to give this project the attention it deserved.
 
 **/


// Player class object with various gameplay methods
//
class Player {
    let name: String
    var score: Int
    var numRolls: Int
    var hand: Hand
    var scorecard: Scorecard
    
    init(name:  String){
        self.name = name
        self.score = 0
        self.numRolls = 0
        self.hand = Hand()
        self.scorecard = Scorecard()
    }
    
    func roll(){
        hand.rollDice()
        numRolls += 1
    }
    
    func keep(choices: [DieChoices]){
        for index in hand.dice.indices {
            for choice in choices {
                if choice.rawValue == index {
                    hand.dice[index].kept = true
                }
            }
        }
    }
    
    func keepAll(){
        for index in hand.dice.indices {
            hand.dice[index].kept = true
        }
    }
    
    func trackScores(for field: ScorecardFields) {
        var sum = 0
        switch field {
        case .ones:
            if(scorecard.values[0].tracked){
               print("Already recorded a score for that one.")
                break
            }
            for die in hand.dice{
                sum += (die.value == 1) ? 1 : 0
            }
            scorecard.values[0].value = sum
            scorecard.values[0].tracked = true
            scorecard.showCard()
            
        case .twos:
            if(scorecard.values[1].tracked){
                print("Already recorded a score for that one.")
                break
            }
            for die in hand.dice{
                sum += (die.value == 2) ? 2 : 0
            }
            scorecard.values[1].value = sum
            scorecard.values[1].tracked = true
            scorecard.showCard()
            
        case .threes:
            if(scorecard.values[2].tracked){
                print("Already recorded a score for that one.")
                break
            }
            for die in hand.dice{
                sum += (die.value == 3) ? 3 : 0
            }
            scorecard.values[2].value = sum
            scorecard.values[2].tracked = true
            scorecard.showCard()
            
        case .fours:
            if(scorecard.values[3].tracked){
                print("Already recorded a score for that one.")
                break
            }
            for die in hand.dice{
                sum += (die.value == 4) ? 4 : 0
            }
            scorecard.values[3].value = sum
            scorecard.values[3].tracked = true
            scorecard.showCard()
            
        case .fives:
            if(scorecard.values[4].tracked){
                print("Already recorded a score for that one.")
                break
            }
            for die in hand.dice{
                sum += (die.value == 5) ? 5 : 0
            }
            scorecard.values[4].value = sum
            scorecard.values[4].tracked = true
            scorecard.showCard()
            
        case .sixes:
            if(scorecard.values[5].tracked){
                print("Already recorded a score for that one.")
                break
            }
            for die in hand.dice{
                sum += (die.value == 6) ? 6 : 0
            }
            scorecard.values[5].value = sum
            scorecard.values[5].tracked = true
            scorecard.showCard()
            
        case .threeOfKind:
            if(scorecard.values[6].tracked){
                print("Already recorded a score for that one.")
                break
            }
            var counts: [Int: Int] = [:]
            for die in hand.dice {
                counts[die.value, default: 0] += 1
            }
            for key in counts.keys {
                if(counts[key] == 3){
                    hand.dice.forEach { die in
                        sum += die.value
                    }
                }
            }
            scorecard.values[6].value = sum
            scorecard.values[6].tracked = true
            scorecard.showCard()
            
        case .fourOfKind:
            if(scorecard.values[7].tracked){
                print("Already recorded a score for that one.")
                break
            }
            var counts: [Int: Int] = [:]
            for die in hand.dice {
                counts[die.value, default: 0] += 1
            }
            for key in counts.keys {
                if(counts[key] == 4){
                    hand.dice.forEach { die in
                        sum += die.value
                    }
                }
            }
            scorecard.values[7].value = sum
            scorecard.values[7].tracked = true
            scorecard.showCard()
            
        case .fullHouse:
            if(scorecard.values[8].tracked){
                print("Already recorded a score for that one.")
                break
            }
            var counts: [Int: Int] = [:]
            for die in hand.dice {
                counts[die.value, default: 0] += 1
            }
            if(counts.keys.count == 2){
                for key in counts.keys{
                    if (counts[key] == 2 || counts[key] == 3){
                        sum = 25
                    }
                }
            }
            scorecard.values[8].value = sum
            scorecard.values[8].tracked = true
            scorecard.showCard()
            
        case .smStraight:
            if(scorecard.values[9].tracked){
                print("Already recorded a score for that one.")
                break
            }
            let possibleStraights = [[1,2,3,4],[2,3,4,5],[3,4,5,6]]
            var diceValues: [Int] = []
            hand.dice.forEach { die in
                if(!diceValues.contains(die.value)){
                    diceValues.append(die.value)
                }
            }
            for straight in possibleStraights {
                if(straight == diceValues){
                    sum = 30
                }
            }
            scorecard.values[9].value = sum
            scorecard.values[9].tracked = true
            scorecard.showCard()
            
        case .lgStraight:
            if(scorecard.values[10].tracked){
                print("Already recorded a score for that one.")
                break
            }
            let possibleStraights = [[1,2,3,4,5],[2,3,4,5,6]]
            var diceValues: [Int] = []
            hand.dice.forEach { die in
                diceValues.append(die.value)
            }
            for straight in possibleStraights {
                if(straight == diceValues){
                    sum = 40
                }
            }
            scorecard.values[10].value = sum
            scorecard.values[10].tracked = true
            scorecard.showCard()
            
        case .yahtzee:
            if(scorecard.values[11].tracked){
                print("Already recorded a score for that one.")
                break
            }
            var diceValues: [Int] = []
            hand.dice.forEach { die in
                diceValues.append(die.value)
            }
            let set = Set(diceValues)
            if set.count == 1 {
                sum = 50
            }
            scorecard.values[11].value = sum
            scorecard.values[11].tracked = true
            scorecard.showCard()
            
        case .chance:
            if(scorecard.values[12].tracked){
                print("Already recorded a score for that one.")
                break
            }
            hand.dice.forEach { die in
                sum += die.value
            }
            scorecard.values[12].value = sum
            scorecard.values[12].tracked = true
            scorecard.showCard()
        }
    }
}

// Enumeration to hold and govern possible die choices
//
enum DieChoices: Int, CaseIterable {
    case one = 0, two, three, four, five
}

// Die structure used within a players hand
//
struct Die: Comparable {
    var value: Int
    var kept: Bool
    
    init(){
        self.value = 1
        self.kept = false
    }
    
    static func < (lhs: Die, rhs: Die) -> Bool {
        return lhs.value < rhs.value
    }
    
    mutating func roll() {
        if(kept != true){
            self.value = Int.random(in:1...6)
        }
    }
}

// Hand class to track and govern a players current hand of dice
//
class Hand {
    var dice: [Die] = [];
    
    init() {
        createHand()
    }
    
    func createHand(){
        while self.dice.count < DieChoices.allCases.count {
            let newDie = Die();
            self.dice.append(newDie);
        }
    }
    
    func rollDice() {
        for index in dice.indices {
            dice[index].roll()
        }
    }
    
    func showValues() {
        dice.sort()
        for index in dice.indices {
            print("\(index + 1): \(dice[index])");
        }
        print("")
    }
    
    func resetDice() {
        for index in dice.indices {
            dice[index].kept = false
        }
    }
}

// ScorecardFields enumeration to govern possible Scorecard Fields
//
enum ScorecardFields: Int, CaseIterable {
    case ones = 0, twos, threes, fours, fives, sixes, threeOfKind, fourOfKind, fullHouse, smStraight, lgStraight, yahtzee, chance
}

//  Scorecard structure to be used by each player in the game for tracking points from hand of dice.
//
struct Scorecard {
    var values: [(field: ScorecardFields, value: Int, tracked: Bool)] = []
    var trackedItems: Int
    var filled: Bool
    
    init() {
        for item in ScorecardFields.allCases {
            values.append((item, 0, false))
        }
        trackedItems = 0
        filled = false
    }
    
    func showCard(){
        print("SCORECARD TOTALS")
        print("================")
        for item in values {
            print("\(item.field): \(item.value)");
        }
        print("")
    }
    
    func totalScores() -> Int {
        var sum = 0
        for item in values {
            sum += item.value
        }
        return sum
    }
}

// Game class to manage gameplay, and track players and their turns.
//
class Game {
    var players: [Player];
    var currentPlayer: Int
    var scoreboard: [String: Int] = [:]
    var numberOfPlayers: Int {
        get{
            return players.count
        }
    }
    
    init(players: [Player]){
        self.players = players
        currentPlayer = 0
        setScoreboard()
    }
    
    func setScoreboard(){
        for player in players {
            self.scoreboard[player.name] = player.score
        }
    }
    
    func play(){
        let MAX_ROLLS_PER_TURN = 3;
        let player = players[currentPlayer]
        print("\(player.name)'s roll.\n")
        player.roll()
        if(player.numRolls < MAX_ROLLS_PER_TURN){
            player.hand.showValues()
            print("Roll: \(player.numRolls)/\(MAX_ROLLS_PER_TURN). Pick what dice to keep, and roll again. Choices Are: .one, .two, .three, .four, .five.\n")
        } else {
            player.keepAll()
            player.hand.showValues()
            print("No rolls left. Use your scorecard to track your points!\n")
            player.scorecard.showCard()
            changeTurns()
        }
    }
    
    func changeTurns(){
        currentPlayer += 1
        if(currentPlayer > numberOfPlayers - 1){
            currentPlayer = 0
        }
    }
}

// TESTING CODE FUNCTIONALITY WITH A COUPLE SCRIPTED ROUNDS:

// I have placed some code below in a particular scripted order to replicate a round between two players, and allow you to enter values to see the code I have made functioning (with some errors expected). This is in place of any real user interaction. I wanted to be able to show a gameplay loop, and did not quite understand how to do so for this project.

// To act-out the game, enter values according to the provided comments and continue code execution as you go.

// A players turn consists of these steps:
//
//  1. Roll
//  2. Select dice to keep
//  3. Roll
//  4. Select dice to keep
//  5. Roll
//  6. Track scores



let player1 = Player(name: "Reeve") // Add Name
let player2 = Player(name: "Kayla") // Add Name

let yahtzee = Game(players: [player1, player2]) // Instantiate game with players

yahtzee.play()

player1.keep(choices: []) // Multiple Choices Allowed. Choices Are: .one, .two, .three, .four, .five. Leave empty if you don't want to keep any.

yahtzee.play()

player1.keep(choices: []) // Multiple Choices Allowed. Choices Are: .one, .two, .three, .four, .five. Leave empty if you don't want to keep any.

yahtzee.play()

player1.trackScores(for: ) // Scorecard Item Choices: .ones, .twos, .threes, .fours, .fives, .sixes, .threeOfKind, .fourOfKind, .fullHouse, .smStraight, .lgStraight, .yahtzee, .chance

yahtzee.play()

player2.keep(choices: []) // Multiple Choices Allowed. Choices Are: .one, .two, .three, .four, .five. Leave empty if you don't want to keep any.

yahtzee.play()

player2.keep(choices: []) // Multiple Choices Allowed. Choices Are: .one, .two, .three, .four, .five. Leave empty if you don't want to keep any.

yahtzee.play()

player2.trackScores(for: ) // Scorecard Item Choices: .ones, .twos, .threes, .fours, .fives, .sixes, .threeOfKind, .fourOfKind, .fullHouse, .smStraight, .lgStraight, .yahtzee, .chance
