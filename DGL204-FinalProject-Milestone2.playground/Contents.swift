import UIKit
import Foundation

// Game constants
let MAX_ROLLS = 3;

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
        for choice in DieChoices.allCases {
            keep(die: choice)
        }
    }
    
    func resetHand() {
        self.hand = Hand()
        numRolls = 0
    }
    
}

enum DieChoices: Int, CaseIterable {
    case one = 0, two, three, four, five
}

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

struct Hand {
    var dice: [Die] = [];
    
    init() {
        createHand()
    }
    
    mutating func createHand(){
        while self.dice.count < DieChoices.allCases.count {
            let newDie = Die();
            self.dice.append(newDie);
        }
    }
    
    mutating func showValues() {
        dice.sort()
        print("\n")
        
        for index in dice.indices {
            print("\(index + 1): \(dice[index])");
        }
    }
}

enum ScorecardItems: CaseIterable {
    case ones, twos, threes, fours, fives, sixes, threeOfKind, fourOfKind, fullHouse, smStraight, lgStraight, yahtzee, chance
}

struct Scorecard {
    var values: [ScorecardItems: Int] = [:]
    var trackedItems: Int
    var filled: Bool
    
    init() {
        values.reserveCapacity(13);
        for item in ScorecardItems.allCases {
            values[item] = 0
        }
        trackedItems = 0
        filled = false
    }
    
    func trackScores(for field: ScorecardItems) {
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
                if(counts[0] == 2 && counts[1] == 3 || counts[0] == 3 && counts[1] == 2){
                    sum = 25
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
            let firstFour = Array(diceValues[0...3])
            let lastFour = Array(diceValues[2...4])
            for straight in possibleStraights {
                if(straight == firstFour || straight == lastFour){
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
    
    func totalScores() -> Int {
        var sum = 0
        for (_, value) in values {
            sum += value
        }
        return sum
    }
}

class Game {
    var players: [Player];
    var scoreboard: [String: Int] = [:]
    var numberOfPlayers: Int {
        get{
            players.count
        }
    }
    
    init(players: [Player]){
        self.players = players
    }
}

