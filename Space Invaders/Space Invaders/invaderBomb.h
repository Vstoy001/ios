//
//  invaderBomb.h
//  Space Invaders
//
//  Created by Victor Stoyanov on 1/3/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface invaderBomb : NSObject

@property UIImageView *bombView;
@property (strong) NSTimer *bombTimer;
@property CGRect bombRect;
@property NSTimer *enemyBombTimer;

@property UIView *gameView;
-(void) fireBullet: (UIView *) gameView :(NSArray *) enemyList;

@end
