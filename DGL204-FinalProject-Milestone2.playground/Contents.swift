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
    
    func takeTurn(){
        if (numRolls < MAX_ROLLS){
            rollDice()
            print("Pick what dice to keep, and roll again.")
        } else {
            keepAll()
            print("No more rolls. Track your score.")
        }
    }
    
    func rollDice() {
        for index in hand.dice.indices {
            hand.dice[index].roll()
        }
        numRolls += 1
        hand.showValues()
    }
    
    func keep(die: DieChoices){
        for index in hand.dice.indices {
            if die.rawValue == index {
                hand.dice[index].kept = true
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
    
    mutating func trackScores(for item: ScorecardItems, from hand: Hand) {
        var sum = 0
        switch item {
        case .ones:
            for die in hand.dice{
                sum += (die.value == 1) ? 1 : 0
            }
            values[.ones] = sum
            trackedItems += 1
            
        case .twos:
            for die in hand.dice{
                sum += (die.value == 2) ? 2 : 0
            }
            values[.twos] = sum
            trackedItems += 1
            
        case .threes:
            for die in hand.dice{
                sum += (die.value == 3) ? 3 : 0
            }
            values[.threes] = sum
            trackedItems += 1
            
        case .fours:
            for die in hand.dice{
                sum += (die.value == 4) ? 4 : 0
            }
            values[.fours] = sum
            trackedItems += 1
        case .fives:
            for die in hand.dice{
                sum += (die.value == 5) ? 5 : 0
            }
            values[.fives] = sum
            trackedItems += 1
            
        case .sixes:
            for die in hand.dice{
                sum += (die.value == 6) ? 6 : 0
            }
            values[.sixes] = sum
            trackedItems += 1
            
        case .threeOfKind:
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
            values[.threeOfKind] = sum
            trackedItems += 1
            
        case .fourOfKind:
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
            values[.fourOfKind] = sum
            trackedItems += 1
            
        case .fullHouse:
            var counts: [Int: Int] = [:]
            for die in hand.dice {
                counts[die.value, default: 0] += 1
            }
            if(counts.keys.count == 2){
                if(counts[0] == 2 && counts[1] == 3 || counts[0] == 3 && counts[1] == 2){
                    sum = 25
                }
            }
            values[.fullHouse] = sum
            trackedItems += 1
            
        case .smStraight:
            let possibleStraights = [[1,2,3,4],[2,3,4,5],[3,4,5,6]]
            for straight in possibleStraights {
                var count = 0
                for die in hand.dice {
                    if straight.contains(die.value) {
                        count += 1
                    }
                }
                if(count == 4){
                    sum = 30
                }
            }
            values[.smStraight] = sum
            trackedItems += 1
            
        case .lgStraight:
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
            values[.lgStraight] = sum
            trackedItems += 1
            
        case .yahtzee:
            var diceValues: [Int] = []
            hand.dice.forEach { die in
                diceValues.append(die.value)
            }
            let set = Set(diceValues)
            if set.count == 1 {
                sum = 50
            }
            values[.yahtzee] = sum
            trackedItems += 1
            
        case .chance:
            hand.dice.forEach { die in
                sum += die.value
            }
            values[.chance] = sum
            trackedItems += 1
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

