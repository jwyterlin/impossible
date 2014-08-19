//
//  ImpossibleView.h
//  impossible
//
//  Created by Jhonathan Wyterlin on 17/08/14.
//  Copyright (c) 2014 Jhonathan Wyterlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImpossibleView : UIView

@property(nonatomic,strong) NSTimer *gameRunTimer;
@property(nonatomic) BOOL running;

// Player
@property(nonatomic) int playerX;
@property(nonatomic) int playerY;
@property(nonatomic) int playerRadius;

// Enemy
@property(nonatomic) int enemyX;
@property(nonatomic) int enemyY;
@property(nonatomic) int enemyRadius;

// Score
@property(nonatomic) int score;
@property(nonatomic,strong) UILabel *gameScoreLabel;

@property(nonatomic,strong) UILabel *gameOverLabel;

-(void)moveDown:(int)pixels;
-(void)increaseScore:(int)points;
-(void)restart;
-(void)stopGame;

@end
