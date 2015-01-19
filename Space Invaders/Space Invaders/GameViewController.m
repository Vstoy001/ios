//
//  GameViewController.m
//  Space Invaders
//
//  Created by Victor Stoyanov on 12/31/14.
//  Copyright (c) 2014 Victor Stoyanov. All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self changeState: INIT];
    NSLog(@"loaded view!\n");
}

-(void) changeState: (int)newState
{
    switch(newState)
    {
        case INIT:
            NSLog(@"in INIT\n");
            [self loadingScreen];
            break;
            
        case PLAY:
            NSLog(@"in PLAY\n");
            break;
            
        case RELOAD:
            NSLog(@"in RELOAD\n");
            [self.view addSubview:self.loadingView];
            [self.enemies stopTimer];
            [self.collisionTimer invalidate];
            self.collisionTimer = NULL;
            break;
            
        case END:
            NSLog(@"in END\n");
            break;
            
        default:
            NSLog(@"out of range state!");
            break;
    }
    self.currState = newState;
}

-(void) loadingScreen
{
    self.playerOne = [[[playerObject alloc]init] initPlayer:self.view];
    self.playerView = [self.playerOne getPlayerView];
    [[[Invader alloc]init] initEnemies:self.view];
    
    self.loadingView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading.png"]];
    self.loadingView.frame = self.view.frame;
    NSLog(@"trying to add self");
    [self.view addSubview:self.loadingView];
    NSLog(@"added self");
    [NSTimer scheduledTimerWithTimeInterval:2
             target:self
             selector:@selector(closeScreen)
             userInfo:nil
             repeats:NO];
}

-(void) closeScreen
{
    [self.loadingView removeFromSuperview];
    
    [self changeState: PLAY];
    
    [self.enemies startTimer];
    self.collisionTimer = [NSTimer scheduledTimerWithTimeInterval:.1
                                   target:self
                                   selector:@selector(intersectCheck)
                                   userInfo:nil
                                   repeats:YES];
}

-(void) endScreen
{
    [self.loadingView removeFromSuperview];
    [self changeState:END];
    [self performSegueWithIdentifier:@"unwind" sender:self];
}

-(void) intersectCheck
{
    BOOL isConnecting = CGRectIntersectsRect(self.enemies.enemiesBomb.bombRect, self.playerOne.playerRect);
    if(isConnecting == true)
    {
        [NSTimer scheduledTimerWithTimeInterval:2
                 target:self
                 selector:@selector(endScreen)
                 userInfo:nil
                 repeats:NO];
        [self changeState:RELOAD];
    }
}

-(void) releaseTouch
{
    if(self.moveTimer != nil)
    {
        [self.moveTimer invalidate];
        self.moveTimer = nil;
    }    
}

- (IBAction)moveLeft:(id)sender
{
    [self releaseTouch];
    if(self.currState != PLAY)
        return;
    self.moveTimer = [NSTimer scheduledTimerWithTimeInterval: .03
                              target:self
                              selector:@selector(movePlayerLeft)
                              userInfo:nil
                              repeats:YES];
    NSLog(@"moving left\n");
}

- (IBAction)moveRight:(id)sender
{
    [self releaseTouch];
    if(self.currState != PLAY)
            return;
    self.moveTimer = [NSTimer scheduledTimerWithTimeInterval: .03
                                                      target:self
                                                    selector:@selector(movePlayerRight)
                                                    userInfo:nil
                                                     repeats:YES];
    NSLog(@"moving right\n");
}

- (IBAction)TouchRelease:(id)sender
{
    [self releaseTouch];
    NSLog(@"stopping\n");
}

- (IBAction)fireButton:(id)sender
{
    if(self.currState != PLAY)
        return;
    [self.playerOne fireBullet];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
