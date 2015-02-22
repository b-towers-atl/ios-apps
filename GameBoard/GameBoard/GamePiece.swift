//
//  GamePiece.swift
//  GameBoard
//
//  Created by Bobby Towers on 2/18/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit

/// 0 = Empty, 1 = Player1, 2 = Player2, 3 = Player1King, 4 = Player2King

enum PieceType: Int {
    
    // basic feature
    case Empty
    case Player1
    case Player2
    
    // hard feature
    case Player1King
    case Player2King
    
}

protocol GamePieceDelegate {
    
    func pieceSelected(piece: GamePiece)
    
}

class GamePiece: UIView {
    
    var type: PieceType!
    var player: Player? {
        
//        var index = 0
//        
//        switch type! {
//            
//            case .Player1, .Player1King:
//                
//                index = 0
//                
//            case .Player2, .Player2King:
//                
//                index = 1
//            
//            case .Empty:
//                // never going to be used
//                
//                index = 0
//            
//        }
        
        let playerIndex = (type.rawValue - 1) % 2
        return DataModel.mainData().currentGame?.players[playerIndex]
        
    }
    
    /// (col,row) (x,y)
    var square: (Int,Int)!
    
    var delegate: GamePieceDelegate?
    
    init(type: PieceType) {
        
        super.init(frame: CGRectMake(0, 0, 20, 20))
        self.type = type
        
        self.backgroundColor = type.hashValue % 2 == 0 ? UIColor.redColor() : UIColor.whiteColor()
        
        self.layer.cornerRadius = 10
        
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // piece selected
        delegate?.pieceSelected(self)
        
        // change color for selection (add later/change background color)
        
        
    }

    // init coder is something that is called by storyboard
    // only classes that go on a storyboard will require this
    // this is a must if we override the normal init
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
