//
//  playerObject.h
//  Space Invaders
//
//  Created by Victor Stoyanov on 1/3/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "playerBullet.h"

@interface playerObject : NSObject

@property UIView *gameView;
@property CGRect playerRect;
@property (strong) UIImage *playerImage;
@property (strong) UIImageView *playerView;

- (playerObject *) initPlayer: (UIView *) gameView;
- (void) movePlayerLeft;
- (void) movePlayerRight;
- (void) fireBullet;
- (UIView *) getPlayerView;

@end
