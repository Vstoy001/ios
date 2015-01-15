//
//  playerBullet.h
//  Space Invaders
//
//  Created by Victor Stoyanov on 1/2/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface playerBullet : NSObject

@property CGRect bulletRect;
@property UIImageView *bulletView;
@property (strong) NSTimer *bulletTimer;
@property UIView *gameView;

-(void) initBullet: (UIView *) gameView :(UIImageView *) playerView;

@end
