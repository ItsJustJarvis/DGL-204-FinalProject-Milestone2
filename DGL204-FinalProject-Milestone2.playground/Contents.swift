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

