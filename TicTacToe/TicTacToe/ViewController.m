//
//  ViewController.m
//  TicTacToe
//
//  Created by Bobby Towers on 1/12/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// Center squares on View
// Score label on top that keeps track of wins for each player
// Make buttons change colors instead of title (reset colors when play again)
// * might need two global instance variables that keeps tracks of each score (score label)
// Button at bottom that resets game scores

@interface ViewController () <UIAlertViewDelegate>

// these properties are unused, but if used, must use self.player1Score and self.player2Score to modify
// property never has an actual value, the instance variable has an actual value
@property (nonatomic) int player1Score;

@property (nonatomic) int player2Score;


@end

@implementation ViewController

{
    // instance variable objects
    
    int playerTurn;
    
    int playerScore1;
    
    int playerScore2;
    
    NSMutableArray * squares;
    
    NSMutableArray * buttons;
    
    UILabel * scoreLabelP1;
    
    UILabel * scoreLabelP2;
    
    NSArray * playerColors;

    
}

// setters for player1Score and player2Score property
// using a property and using an instance variable are two different things
// reasons to rewrite setter: 1. listen for a change, 2. check for parameters, a validation
- (void)setPlayer1Score:(int)player1Score {
    
    scoreLabelP1.text = [NSString stringWithFormat:@"Player 1: %d", player1Score];
    _player1Score = player1Score;
    // _player1Score is an actual instance variable
    
}
- (void)setPlayer2Score:(int)player2Score {
    
    scoreLabelP2.text = [NSString stringWithFormat:@"Player 1: %d", player2Score];
    _player1Score = player2Score;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    playerColors = @[
                     [UIColor lightGrayColor],
                     [UIColor blueColor],
                     [UIColor redColor]
                     ];
    
    // we forgot to alloc and init buttons array, so previously it didn't even exist yet
    // @[] alloc inits a regular array, but the mutableCopy alloc inits a Mutable Array based off the 1st array
    buttons = [@[] mutableCopy];
    
    
    playerTurn = 1;
    
    playerScore1 = 0;
    playerScore2 = 0;
    
    // this array is for the computer to test against
    squares = [@[
                 @0, @0, @0,
                 @0, @0, @0,
                 @0, @0, @0
                 ] mutableCopy]; // value of 0, no one has touched a spot yet, mutableCopy will make the mutable Array
    
    int rowCount = 3;
    int colCount = 3;
    
    CGFloat width = 120;    // CGFloat is actually a C type, CG stands for core graphics
    CGFloat height = 120;
    
    CGFloat padding = -10;
    
    CGFloat fullWidth = (colCount * width) + (rowCount - 1) * padding;
    CGFloat fullHeight = (rowCount * height) + (rowCount - 1) * padding;
    
    int buttonCount = 0;
    
    // loop per row
    for (int r = 0; r < rowCount; r++) {

        // loop per column
        for (int c = 0; c < colCount; c++) {

            // this looks like crap, find a more formal way
            CGFloat x = c * (width + padding) + (SCREEN_WIDTH - fullWidth) / 2;
            CGFloat y = r * (height + padding) + (SCREEN_HEIGHT - fullHeight) / 2;
            
            // creates button and gives it a gray background (give red to 1, blue to 2)
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
            button.backgroundColor = playerColors[0];
//          [button setTitle:[NSString stringWithFormat:@"%d", buttonCount] forState:UIControlStateNormal];
            button.tag = buttonCount;
            
            
            // button talks to viewController, but we are in viewController, so it we target self
            // a selector is a method
            // squareTapped: will call the method below
            [button addTarget:self action:@selector(squareTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            
            // creating a circle button and making it transparent
            button.layer.cornerRadius = height / 2;
            button.alpha = 0.6;
            
            // adds button to view
            [self.view addSubview:button];
            [buttons addObject: button];
            
            
            buttonCount++;
            
        }
        
//        buttonCount++; // doesn't increment buttons properly
        
    }

//    player1ScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH - 40, 40)];
//      //    player1ScoreLabel.text = @"Player1: 0";
//    player1ScoreLabel.textAlignment = NSTextAlignmentRight;
//
//    [self.view addSubview: player1ScoreLabel];
    
//    player2ScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH - 40, 40)];
//      //    player2ScoreLabel.text = @"Player2: 0";
//    player2ScoreLabel.textAlignment = NSTextAlignmentRight;
//    
//    [self.view addSubview: player2ScoreLabel];
//    
//    self.player1Score = 0;
//      // _player1Score = 0;   // this actually sets the value, but does not update the score label that we were listening to
//    self.player2Score = 0;
    
    
//      //    -setProperty (setter) and -property (getter), and _property get create when we do our @property
//      //    self.property goes through the setter and getter, if = sign, then setter, if you are just getting it, getter
//      //    _property can be used like an instance variable, but skips setter and getter
//      //    self.property is good if you want to listen
    
    

    
    // create score label on top, give it a red background for player 1, and include label text
    scoreLabelP1 = [[UILabel alloc] initWithFrame:CGRectMake(130, 30, 110, 40)];
    scoreLabelP1.backgroundColor = [UIColor redColor];
    scoreLabelP1.text = [NSString stringWithFormat:@" P1 Score: %d", playerScore1];
    // adds label to view
    [self.view addSubview:scoreLabelP1];
    
    
    // create score label on top, give it a blue background for player 2, and include label text
    scoreLabelP2 = [[UILabel alloc] initWithFrame:CGRectMake(130, 80, 110, 40)];
    scoreLabelP2.backgroundColor = [UIColor blueColor];
    scoreLabelP2.text = [NSString stringWithFormat:@" P2 Score: %d", playerScore2];
    scoreLabelP2.textColor = [UIColor whiteColor];
    // adds label to view
    [self.view addSubview:scoreLabelP2];
    
    
    // create UIButton resetScoreButton, set color to black, and name it, then show it as a Subview
    UIButton * resetScoreButton = [[UIButton alloc] initWithFrame:CGRectMake(130, 550, 115, 40)];
    resetScoreButton.backgroundColor = [UIColor blackColor];
    [resetScoreButton setTitle:@"Reset scores" forState:UIControlStateNormal];
    [resetScoreButton addTarget:self action:@selector(resetScore:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetScoreButton];
    
    
    
    // debugger code
    // %@ formats an array, self.view.subviews will give us the subviews arrays
    // this will show us that we have 2 hidden arrays for a total of 11
    // UILayoutGuides are from the storyboards
//       NSLog(@"Subview count %@", self.view.subviews);
    
}

- (void)squareTapped:(UIButton *)button {
    
    // conditional to see if button has been tapped, if so, return nothing because void
    if ([squares[button.tag] intValue] != 0) { return; }
    
    // playerTurn is a C type, and need to be turned into a Obj C object
    // @ is the literal verstion to set the short cut
    // same as [NSNumber numberWithInt: playerTurn];
    squares[button.tag] = @(playerTurn);
    
    [button setTitle:[NSString stringWithFormat: @"%d", playerTurn] forState:UIControlStateNormal];
    
    // () = conditional, ? indicates conditional variable, : indicates else (T:F)
    playerTurn = (playerTurn == 2) ? 1 : 2;
    
    // sets the background color based on player's turn
    button.backgroundColor = playerColors[playerTurn];
    
    
//    if (playerTurn == 2) {
//        button.backgroundColor = [UIColor redColor];
//    } else if (playerTurn == 1) {
//        button.backgroundColor = [UIColor blueColor];
//    }
    
    
    [self checkForWin];
    
//    NSLog(@"\nbutton tapped %d\n", (int)button.tag); // .tag is an NSInteger, so we cast it with (int)
    
}

- (void)resetScore:(UIButton *)resetScoreButton {
    playerScore1 = 0;
    playerScore2 = 0;
    
    scoreLabelP1.text = [NSString stringWithFormat:@" P1 Score: %d", playerScore1];
    scoreLabelP2.text = [NSString stringWithFormat:@" P2 Score: %d", playerScore1];
    
}

- (void)checkForWin {
    
    NSArray * possibilities = @[
                                // rows
                                @[@0,@1,@2],
                                @[@3,@4,@5],
                                @[@6,@7,@8],
                                
                                // col
                                @[@0,@3,@6],
                                @[@1,@4,@7],
                                @[@2,@5,@8],
                                
                                // diagonal
                                @[@0,@4,@8],
                                @[@2,@4,@6]
                                ];  // array of array of all the possibile win conditions
                                    // 8 conditions, 3 accross, 3 vertical, and 2 diagonal
    
    for (NSArray *possibility in possibilities) {
        
        [self checkPossibility:possibility withPlayer:1];
        [self checkPossibility:possibility withPlayer:2];

    }
        
}
    


- (void)checkPossibility:(NSArray *)possibility withPlayer:(int)player {
    
    BOOL playerInSquare1 = ([squares[[possibility[0] intValue]] intValue] == player);
    BOOL playerInSquare2 = ([squares[[possibility[1] intValue]] intValue] == player);
    BOOL playerInSquare3 = ([squares[[possibility[2] intValue]] intValue] == player);
    
    
    if (playerInSquare1 && playerInSquare2 && playerInSquare3) {
        
        
        // using switch statements
        // switches in objective can only take integers
        // need to keep breaks in to distinguish each case
        switch (player) {
            case 1:
                self.player1Score++;
                break;
            
            case 2:
                self.player2Score++;
                break;
        }
        
        
        
        
        // player won
        NSLog(@"Player %d Won", player);
        
        NSString * message = [NSString stringWithFormat:@"Player %d Won", player];
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Winner!" message:message delegate:self cancelButtonTitle:@"Play Again" otherButtonTitles:nil];
        
        [alertView show];
        
        if (player == 1) {
            playerScore1++;
            NSLog(@"Player one wins, %d", playerScore1);
            scoreLabelP1.text = [NSString stringWithFormat:@" P1 Score: %d", playerScore1];
        } else if (player == 2) {
            playerScore2++;
            NSLog(@"Player two wins, %d", playerScore2);
            scoreLabelP2.text = [NSString stringWithFormat:@" P2 Score: %d", playerScore2];
        } else {
            return; // bugs when you tie (just freezes, does not know what to do)
        }
        
    }
    
}

// this is a delegate method, this specific one is called by UIAlertViews
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // reset square titles
    // playerTurn = 1;
    // reset squares array to 0
    
    // Subview has a property named subviews which is an array
    for (UIButton * button in buttons) {
        
        // hopefully we have 9 subviews because we have 9 buttons/titles
        [button setTitle:@"" forState:UIControlStateNormal];
        button.backgroundColor = playerColors[0];
        
    }
    
    playerTurn = 1;
    
    squares = [@[
                 @0, @0, @0,
                 @0, @0, @0,
                 @0, @0, @0
                 ] mutableCopy];
    
    NSLog(@"Play Again");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end




// instance variable, points to a spot in memory, directly accessing a value in memory
// UILabel * label;

// property
// @property (nonatomic) UILabel * label2;
// to get to a spot in memory, it has two methods, setter and getter
// label2 = alloc init
// we are saying, run the setter method
// _label2 = label2;
// _label2 is actually pointing to the memory
// it does not actually point to memory until you alloc and init it



//        // obtaining the position
////        int square1Position = [possibility[0] intValue];
//        int square1Index = [possibility[0] intValue];
//        int square2Index = [possibility[1] intValue];
//        int square3Index = [possibility[2] intValue];
//
//
//        // (squares[possibility[0]] == 1
//        // squares on left side is obj-c type,
//        // right side 1 is a c type (don't mix)
////        BOOL player1InSquare1 = ([squares[[possibility[0] intValue]] intValue] == 1);
////        BOOL player1InSquare2 = ([squares[[possibility[1] intValue]] intValue] == 1);
////        BOOL player1InSquare3 = ([squares[[possibility[2] intValue]] intValue] == 1);
//        BOOL player1InSquare1 = ([squares[square1Index] intValue] == 1);
//        BOOL player1InSquare2 = ([squares[square2Index] intValue] == 1);
//        BOOL player1InSquare3 = ([squares[square3Index] intValue] == 1);
//
//        if (player1InSquare1 && player1InSquare2 && player1InSquare3) {
//
//            // player 1 won
//            NSLog(@"Player 1 Won");


//    for (NSArray *possibility in possibilities) {
//
//        // obtaining the position
//        //        int square1Position = [possibility[0] intValue];
//        int square1Index = [possibility[0] intValue];
//        int square2Index = [possibility[1] intValue];
//        int square3Index = [possibility[2] intValue];
//
//
//        // (squares[possibility[0]] == 1
//        // squares on left side is obj-c type,
//        // right side 1 is a c type (don't mix)
//        //        BOOL player1InSquare1 = ([squares[[possibility[0] intValue]] intValue] == 1);
//        //        BOOL player1InSquare2 = ([squares[[possibility[1] intValue]] intValue] == 1);
//        //        BOOL player1InSquare3 = ([squares[[possibility[2] intValue]] intValue] == 1);
//        BOOL player1InSquare1 = ([squares[square1Index] intValue] == 1);
//        BOOL player1InSquare2 = ([squares[square2Index] intValue] == 1);
//        BOOL player1InSquare3 = ([squares[square3Index] intValue] == 1);
//
//        if (player1InSquare1 && player1InSquare2 && player1InSquare3) {
//
//            // player 1 won
//            NSLog(@"Player 1 Won");
//
//        }
//
//    }
