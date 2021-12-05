import UIKit
import Foundation

// Game constants
let MAX_ROLLS = 3;
let NUM_OF_DIE = 5;

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
        while self.dice.count < NUM_OF_DIE {
            let newDie = Die();
            self.dice.append(newDie);
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

