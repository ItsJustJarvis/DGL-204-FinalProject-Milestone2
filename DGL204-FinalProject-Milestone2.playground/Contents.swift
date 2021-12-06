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
    
    func rollDice() {
        if(numRolls < MAX_ROLLS){
            for index in hand.dice.indices {
                hand.dice[index].roll()
            }
            numRolls += 1
        } else {
            keepAll()
        }
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
        for die in dice {
            print(die);
        }
    }
}

enum ScorecardItems: CaseIterable {
    case ones, twos, threes, fours, fives, sixes, threeOfKind, fourOfKind, fullHouse, smStraight, lgStraight, yahtzee, chance
}

struct Scorecard {
    var values: [ScorecardItems: Int] = [:]
    
    init() {
        values.reserveCapacity(13);
        for item in ScorecardItems.allCases {
            values[item] = 0
        }
    mutating func trackScores(for item: ScorecardItems, from hand: Hand) {
        var sum = 0
        switch item {
        case .ones:
        case .twos:
        case .threes:
        case .fours:
        case .fives:
        case .sixes:
        case .threeOfKind:
        case .fourOfKind:
        case .fullHouse:
        case .smStraight:
        case .lgStraight:
        case .yahtzee:
        case .chance:
        }
    }
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

