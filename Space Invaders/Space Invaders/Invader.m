//
//  Invader.m
//  Space Invaders
//
//  Created by Victor Stoyanov on 1/1/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import "Invader.h"
#import "invaderBomb.h"

@implementation Invader

int eSize = 32;
int xSpace = 5;
int ySpace = 10;
bool goingLeft = false;
int enemyRows = 4;
int enemyCols = 5;

-(void) initEnemies:(UIView *)gameView
{
    self.minXpos = 10;
    self.maxXpos = 250;
    self.gameView = gameView;
    
    int rowCount = 0;
    int startX = 10;
    int startY = 0;
    
    UIImage *enemy1 =  [UIImage imageNamed:@"enemy01.png"];
    UIImage *enemy2 =  [UIImage imageNamed:@"enemy02.png"];
    UIImage *enemy3 =  [UIImage imageNamed:@"enemy03.png"];

    self.enemyList = [[NSMutableArray alloc]init];
    
    for(int i = 0; i < (enemyRows * enemyCols); i++)
    {
        int colMod = i % enemyCols;
        if(colMod == 0)
        {
            rowCount++;
        }
        int xPos = startX + ((eSize*colMod) + (colMod*xSpace));
        int yPos = startY + ((eSize*rowCount) + (rowCount));
        int picker = rand() % 3;
        UIImageView *enemyView;
        switch(picker)
        {
            case 0:
                enemyView = [[UIImageView alloc] initWithImage: enemy1];
                break;
            case 1:
                enemyView = [[UIImageView alloc] initWithImage: enemy2];
                break;
            case 2:
                enemyView = [[UIImageView alloc] initWithImage: enemy3];
                break;
            default:
                enemyView = [[UIImageView alloc] initWithImage: enemy1];
                break;
        }

        enemyView.frame = CGRectMake(xPos, yPos, eSize, eSize);
        [self.enemyList addObject:enemyView];
        [self.gameView addSubview:enemyView];
    }
}

-(void) startTimer
{
    self.enemyTimer = [NSTimer scheduledTimerWithTimeInterval:.03
                                                       target:self
                                                     selector:@selector(moveSweep)
                                                     userInfo:nil
                                                      repeats:YES];
    self.enemyBombTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                           target:self
                                                         selector:@selector(dropBomb)
                                                         userInfo:nil
                                                          repeats:YES];
}

-(void) stopTimer
{
    [self.enemyTimer invalidate];
    self.enemyTimer = NULL;
    [self.enemyBombTimer invalidate];
    self.enemyBombTimer = NULL;
    self.enemiesBomb = NULL;
}

-(void) moveSweep
{
    UIImageView *enemyView = self.enemyList[0];
    if(enemyView.frame.origin.x < self.minXpos)
    {
        goingLeft = false;
    }
    enemyView = self.enemyList[enemyCols-1];
    if(enemyView.frame.origin.x > self.maxXpos)
    {
        goingLeft = true;
    }
    
    for(int i = 0; i < self.enemyList.count; i++)
    {
        enemyView = self.enemyList[i];
        int xPos;
        if(goingLeft)
        {
            xPos = enemyView.frame.origin.x - 3;
        }else{
            xPos = enemyView.frame.origin.x + 3;
        }
        enemyView.frame = CGRectMake(xPos, enemyView.frame.origin.y, eSize, eSize);
        [self.gameView addSubview:enemyView];
    }
}

-(void) dropBomb
{
    invaderBomb *newBomb = [[invaderBomb alloc]init];
    [newBomb fireBullet: self.gameView:self.enemyList];
}



@end
