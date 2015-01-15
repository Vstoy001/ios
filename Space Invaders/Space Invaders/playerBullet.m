//
//  playerBullet.m
//  Space Invaders
//
//  Created by Victor Stoyanov on 1/2/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import "playerBullet.h"

@implementation playerBullet

-(void) initBullet: (UIView *) gameView :(UIImageView *) playerView
{
    self.gameView = gameView;
    UIImage *bombImage1 = [UIImage imageNamed:@"bullet.png"];
    
    int bulletWidth = 8;
    int bulletStartX = playerView.frame.origin.x + (playerView.frame.size.width/2)-(bulletWidth/2);
    
    CGImageRef imageRefA = CGImageCreateWithImageInRect([bombImage1 CGImage], CGRectMake(0, 0, 32, 64));
    CGImageRef imageRefB = CGImageCreateWithImageInRect([bombImage1 CGImage], CGRectMake(33, 0, 32, 64));
    
    NSMutableArray *bombArray = [[NSMutableArray alloc]init];
    [bombArray addObject:[UIImage imageWithCGImage:imageRefA]];
    [bombArray addObject:[UIImage imageWithCGImage:imageRefB]];
    
    self.bulletRect = CGRectMake(bulletStartX, playerView.frame.origin.y, bulletWidth, bulletWidth*4);
    self.bulletView = [[UIImageView alloc] initWithFrame:self.bulletRect];
    
    [self.bulletView setImage:[UIImage imageWithCGImage:imageRefB]];
    self.bulletView.animationImages = bombArray;
    self.bulletView.animationDuration = .3;
    [self.gameView addSubview:self.bulletView];
    [self.bulletView startAnimating];
    self.bulletTimer = [NSTimer scheduledTimerWithTimeInterval:.03
                                target:self
                                selector:@selector(moveBullet)
                                userInfo:nil
                                repeats:YES];
}

-(void) moveBullet
{
    self.bulletRect = CGRectOffset(self.bulletRect, 0, -5);
    self.bulletView.frame = self.bulletRect;
    if(self.bulletRect.origin.y < 20)
    {
        [self.bulletTimer invalidate];
        self.bulletTimer = nil;
        [self.bulletView removeFromSuperview];
    }
}

@end
