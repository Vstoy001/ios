//
//  Invader.h
//  Space Invaders
//
//  Created by Victor Stoyanov on 1/1/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "invaderBomb.h"

@interface Invader : NSObject
@property UIView *gameView;
@property NSInteger minXpos;
@property NSInteger maxXpos;
@property NSMutableArray *enemyList;
@property NSTimer *enemyTimer;
@property NSTimer *enemyBombTimer;
@property invaderBomb *enemiesBomb;

-(void) initEnemies: (UIView *) gameView;
-(void) moveSweep;
-(void) dropBomb;
-(void) startTimer;
-(void) stopTimer;

@end
