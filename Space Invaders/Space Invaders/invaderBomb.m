//
//  invaderBomb.m
//  Space Invaders
//
//  Created by Victor Stoyanov on 1/3/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import "Invader.h"
#import "invaderBomb.h"

@implementation invaderBomb


-(void) fireBullet: (UIView *) gameView :(NSArray *) enemyList
{
    int randEnemy = random() % enemyList.count;
    UIImageView *enemyView = enemyList[randEnemy];
    self.gameView = gameView;
    UIImage *bombImage1 = [UIImage imageNamed:@"bullet.png"];
    
    int bombWidth = 20;
    int bombStartX = enemyView.frame.origin.x;
    
    CGImageRef imageRefA = CGImageCreateWithImageInRect([bombImage1 CGImage], CGRectMake(0, 0, 32, 64));
    CGImageRef imageRefB = CGImageCreateWithImageInRect([bombImage1 CGImage], CGRectMake(33, 0, 32, 64));
    
    NSMutableArray *bombArray = [[NSMutableArray alloc]init];
    [bombArray addObject:[UIImage imageWithCGImage:imageRefA]];
    [bombArray addObject:[UIImage imageWithCGImage:imageRefB]];
    
    self.bombRect = CGRectMake(bombStartX, enemyView.frame.origin.y, bombWidth, bombWidth/2);
    self.bombView = [[UIImageView alloc] initWithFrame:self.bombRect];
    
    [self.bombView setImage:[UIImage imageWithCGImage:imageRefB]];
    self.bombView.animationImages = bombArray;
    self.bombView.animationDuration = .3;
    [self.gameView addSubview:self.bombView];
    [self.bombView startAnimating];
    self.bombTimer = [NSTimer scheduledTimerWithTimeInterval:.03
                                                      target:self
                                                    selector:@selector(moveBomb)
                                                    userInfo:nil
                                                     repeats:YES];
}

-(void) moveBomb
{
    self.bombRect = CGRectOffset(self.bombRect, 0, 3);
    self.bombView.frame = self.bombRect;
    if(self.bombRect.origin.y > 460)
    {
        [self.bombTimer invalidate];
        self.bombTimer = nil;
        [self.bombView removeFromSuperview];
    }
}

@end
