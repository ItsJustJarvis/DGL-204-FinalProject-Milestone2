import UIKit
import Foundation

// Game constants
let MAX_ROLLS = 3;
let NUM_OF_DIE = 5;

class Player {
    let name: String
    var score: Int
    var numRolls: Int
    
    init(name:  String){
        self.name = name
        self.score = 0
        self.numRolls = 0
    }
}

struct Die{
    var value: Int
    var kept: Bool
    
    init(){
        self.value = 1
        self.kept = false
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

