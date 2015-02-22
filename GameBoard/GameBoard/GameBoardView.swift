//
//  GameBoardView.swift
//  GameBoard
//
//  Created by Bobby Towers on 2/18/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit

/// 0 = Empty, 1 = Player1, 2 = Player2, 3 = Player1King, 4 = Player2King

enum PlayerType {
    
    case Empty
    case Player1
    case Player2
    
    case Player1King
    case Player2King
    
}




// use the system, not global constant
// just for testing, not for group app

/*
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
*/

@IBDesignable class GameBoardView: UIView, GamePieceDelegate {
    
    let gridSize = 8
    
    var piece = PieceType.Empty
    
    var previouslySelected: Bool?
    
    var previouslySelectedPiece: GamePiece?
    
    var piecesCreated = false
    
    var currentPlayer: PieceType?
    
    override func layoutSubviews() {
        
        currentPlayer = PieceType.Player1
//        User.currentUser().delegate3 = self
        
        previouslySelected = false
        
        if !piecesCreated {
            
            
            if let boardSquares = DataModel.mainData().currentGame?.boardSquares {
                for (rowIndex, rowArray) in enumerate(boardSquares) {
                    
                    
                    for (columnIndex, squarePieceType) in enumerate(rowArray) {
                        
                        
                        
                        if squarePieceType == 0 {
                            var piece = GamePiece(type: PieceType.Empty)
                            
                            piece.delegate = self
                            
                            piece.square = (columnIndex, rowIndex)
                            
                            DataModel.mainData().currentGame?.boardPieces[rowIndex][columnIndex] = piece
                            
                            let cF = CGFloat(columnIndex)
                            let rF = CGFloat(rowIndex)
                            
                            let squareSize = frame.width / CGFloat(gridSize)
                            
                            let x = cF * squareSize + squareSize/2
                            let y = rF * squareSize + squareSize/2
                            
                            
                            piece.center = CGPointMake(x, y)
                            
                            addSubview(piece)
                            
                            continue
                        }
                        
                        if let type = PieceType(rawValue: squarePieceType) {
                            
                            var piece = GamePiece(type: type)
                            
                            piece.delegate = self
                            
                            piece.square = (columnIndex, rowIndex)
                            
                            DataModel.mainData().currentGame?.boardPieces[rowIndex][columnIndex] = piece
                            
                            
                            let cF = CGFloat(columnIndex)
                            let rF = CGFloat(rowIndex)
                            
                            let squareSize = frame.width / CGFloat(gridSize)
                            
                            let x = cF * squareSize + squareSize/2
                            let y = rF * squareSize + squareSize/2
                            
                            
                            piece.center = CGPointMake(x, y)
                            //piece.frame = CGRectMake(0, 0, 20, 20)
                            
                            
                            addSubview(piece)
                            
                        }
                        
                        
                        
                        //   var piece = GamePiece(type: PieceType.Empty)
                        
                    }
                }
                
                
            }
            
            piecesCreated = true
            
        }
        
        
    }
    
//    override func layoutSubviews() {
//        
//        if let boardSquares = DataModel.mainData().currentGame?.boardSquares {
//            
//            for (rowIndex, rowArray) in enumerate(boardSquares) {
//                
//                for (columnIndex, squarePieceType) in enumerate(rowArray) {
//                    
//                    if squarePieceType == 0 { continue }
//                    
//                    if let type = PieceType(rawValue: squarePieceType) {
//                        
//                        var piece = GamePiece(type: type)
//                        
//                        piece.square = (columnIndex, rowIndex)
//                        piece.delegate = self
//                        DataModel.mainData().currentGame?.boardPieces[rowIndex][columnIndex] = piece
//                        
//                        let cF = CGFloat(columnIndex)
//                        let rF = CGFloat(rowIndex)
//                        
////                        println(frame.width)
//                        
//                        let squareSize = frame.width / CGFloat(gridSize)
//                        
//                        let x = cF * squareSize + squareSize / 2
//                        let y = rF * squareSize + squareSize / 2
//                        
//                        piece.center = CGPointMake(x, y)
//                        
//                        addSubview(piece)
//                        
//                    }
//                    
////                    println(squarePieceType)
//                    
//                }
//                
//            }
//            
//        }
//        
//    }
    
    func pieceSelected(piece: GamePiece) {
        
        var player = piece.type
        
        if  previouslySelectedPiece == nil {
            
            if (piece.type != PieceType.Empty) && (piece.type == currentPlayer) {
                
                previouslySelectedPiece = piece
                
                piece.changeColor(UIColor.yellowColor())
            }
            
        }
            
        else {
            
            previouslySelectedPiece?.changeColorBack()
            
            var validOptions = getValidMoveOptions(previouslySelectedPiece!)
            
            
            let (pieceCol,pieceRow) = piece.square
            
            let (previousCol,previousRow) = previouslySelectedPiece!.square
            
            for move in validOptions {
                
                
                
                let (moveCol,moveRow) = move.square
                
                
                
                
                if moveCol == pieceCol && moveRow == pieceRow {
                    
                    let center = piece.center
                    
                    piece.center = previouslySelectedPiece!.center
                    previouslySelectedPiece?.center = center
                    
                    let square = piece.square
                    
                    piece.square = previouslySelectedPiece?.square
                    previouslySelectedPiece?.square = square
                    
                    DataModel.mainData().currentGame?.boardPieces[previousRow][previousCol] = piece
                    DataModel.mainData().currentGame?.boardPieces[pieceRow][pieceCol] = previouslySelectedPiece
                    

//                    currentPlayer = currentPlayer!.other()
                    
                    
                }
                
                
            }
            
            
            
            previouslySelectedPiece = nil
            
            
        }
        
        
        
    }
    
//    func pieceSelected(piece: GamePiece) {
//        
//        // piece.square is your start point
//        
//        let (c,r) = piece.square
//        let spotTopRight = DataModel.mainData().currentGame?.boardPieces[c + 1][r - 1]
//        let spotTopLeft = DataModel.mainData().currentGame?.boardPieces[c - 1][r - 1]
//        
//        // do something with piece (move or jump)
//        
//    }
    
    func getValidPiece(row: Int, col: Int) -> GamePiece? {
        
        if row > 7 || row < 0 || col > 7 || col < 0 { return nil }
        
        var piece = DataModel.mainData().currentGame?.boardPieces[row][col] as GamePiece!
        
        return piece
    }
    
    func getValidMoveOptions(gamePiece: GamePiece) -> [GamePiece] {
        
        
        var options : [GamePiece?] = []
        
        let (c, r) = gamePiece.square
        
        if (gamePiece.type == PieceType.Player1 || gamePiece.type == PieceType.Player1King || gamePiece.type == PieceType.Player2King) {
            
            
            
            // Diagonals up-lef and up right
            
            
            
            
            options.append(self.getValidPiece(r + 1, col: c + 1))
            
            
            options.append(self.getValidPiece(r + 1, col: c - 1))
            
            
            
            
            
            
        }
        
        if (gamePiece.type == PieceType.Player2 || gamePiece.type == PieceType.Player1King || gamePiece.type == PieceType.Player2King) {
            
            // Diagonals below left and below right
            
            
            options.append(self.getValidPiece(r - 1, col: c + 1))
            
            
            options.append(self.getValidPiece(r - 1, col: c - 1))
            
            
            
            
        }
        
        
        
        
        var validOptions : [GamePiece] = []
        
        // safety
        for possibleValid in options {
            
            if var validTile = possibleValid {
                // if there is no checker then we can move
                
                
                if validTile.type == PieceType.Empty {
                    
                    
                    
                    
                    validOptions.append(validTile)
                    
                }
            }
        }
        
        return validOptions
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // touching gameboard
        
        if let touch = touches.allObjects.last as? UITouch {
            
            let location = touch.locationInView(self)
            
            let squareSize = frame.width / CGFloat(gridSize)
            
            let col = Int(floor(location.x / squareSize))
            let row = Int(floor(location.y / squareSize))
            
            let selectedSquare = DataModel.mainData().currentGame?.boardPieces[row][col]
            
        }
        
    }
    
    override func drawRect(rect: CGRect) {
        
        var context = UIGraphicsGetCurrentContext()
        
        // loop through cols
        for c in 0..<gridSize {
            
            // loop through rows
            for r in 0..<gridSize {
                
                let cF = CGFloat(c)
                let rF = CGFloat(r)
                
                let squareSize = rect.width / CGFloat(gridSize)
                
                let x = cF * squareSize
                let y = rF * squareSize
                
                let color = (c + r) % 2 == 0 ? UIColor.darkGrayColor() : UIColor.blackColor()
                
                color.set()
                
                CGContextFillRect(context, CGRectMake(x, y, squareSize, squareSize))
                
            }
            
        }
        
    }

}
