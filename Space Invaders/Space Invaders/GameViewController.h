//
//  GameViewController.h
//  Space Invaders
//
//  Created by Victor Stoyanov on 12/31/14.
//  Copyright (c) 2014 Victor Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Invader.h"
#import "playerObject.h"

@interface GameViewController : UIViewController

@property playerObject *playerOne;
@property Invader *enemies;
@property UIView *playerView;

- (IBAction)moveLeft:(id)sender;
- (IBAction)moveRight:(id)sender;
- (IBAction)TouchRelease:(id)sender;
- (IBAction)fireButton:(id)sender;

@property (strong, atomic) NSTimer *moveTimer;
@property (strong, atomic) NSTimer *collisionTimer;

typedef NS_ENUM(NSInteger, GAME_STATE)
{
    INIT = 1,
    PLAY = 2,
    RELOAD = 3,
    END = 4
};
@property GAME_STATE currState;

@property (strong) UIImageView *loadingView;

@end
