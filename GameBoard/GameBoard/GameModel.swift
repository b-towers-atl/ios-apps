//
//  GameModel.swift
//  GameBoard
//
//  Created by Bobby Towers on 2/19/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

// game model is going to contain one game

import UIKit

private let _mainData = DataModel()

class DataModel: NSObject {
    
    var allGames: [GameModel] = []
    var currentGame: GameModel?
    
    class func mainData() -> DataModel { return _mainData }
    
}

class GameModel: NSObject {
    
    // game board
    
    /// 0 = empty, 1 = player1, 2 = player2, 3 = player1King, 4 = player2King
    
    let boardSquares = [
        
        // boardSquares[row][col]
        [0,1,0,1,0,1,0,1],
        [1,0,1,0,1,0,1,0],
        [0,1,0,1,0,1,0,1],
        [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0],
        [2,0,2,0,2,0,2,0],
        [0,2,0,2,0,2,0,2],
        [2,0,2,0,2,0,2,0]
        
    ]
    
    var boardPieces: [[GamePiece?]] = Array(count: 8, repeatedValue: Array(count: 8, repeatedValue: nil))
   

    
    // players (index 0 = player 1, index 1 = player 2)
    var players: [Player] = [Player(direction: 1), Player(direction: -1)]
    
    
    
    // winner
    var winner: Player?
    var isDraw = false
    
    
    
    // moves made
    
    // kings per player
    
    // 
    
}

// for kinging 
// var oppositeRow = player.direction == 1 ? 7 : 0

class Player: NSObject {
    
    var direction: Int!
    
    init(direction: Int) {
        
        super.init()
        self.direction = direction
        
    }
    
}
