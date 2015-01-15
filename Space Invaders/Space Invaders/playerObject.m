//
//  playerObject.m
//  Space Invaders
//
//  Created by Victor Stoyanov on 1/3/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "playerObject.h"

@implementation playerObject

-(playerObject *) initPlayer:(UIView *) gameView
{
    self.gameView = gameView;
    self.playerImage = [UIImage imageNamed:@"ship.png"];
    self.playerView = [[UIImageView alloc] initWithImage:self.playerImage];
    
    self.playerRect = CGRectMake(50, 500, 32, 32);
    self.playerView.frame = self.playerRect;
    [self.playerView addSubview:self.playerView];

    return self;
}

-(UIView *) getPlayerView
{
    return self.playerView;
}

-(void) movePlayerLeft
{
    if(self.playerRect.origin.x >= 10)
    {
        self.playerRect = CGRectOffset(self.playerRect, -3, 0);
        self.playerView.frame = self.playerRect;
        NSLog(@"ship is at %f, %f \n", self.playerRect.origin.x, self.playerRect.origin.y);
    }
}

-(void) movePlayerRight
{
    if(self.playerRect.origin.x <= 280)
    {
        self.playerRect = CGRectOffset(self.playerRect, 3, 0);
        self.playerView.frame = self.playerRect;
        NSLog(@"ship is at %f, %f \n", self.playerRect.origin.x, self.playerRect.origin.y);
    }
}

-(void) fireBullet
{
    [[[playerBullet alloc]init] initBullet:self.gameView:self.playerView];
}

@end
