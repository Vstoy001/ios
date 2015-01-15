//
//  GameOverScene.m
//  NinjaTester
//
//  Created by Victor Stoyanov on 1/11/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScene.h"


@implementation GameOverScene

-(id) initWithSize:(CGSize)size won:(BOOL)won
{
    if(self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        NSString *message;
        if(won)
        {
            message = @"You Won!";
        } else {
            message = @"You Lose :[";
        }
        
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"chalkduster"];
        label.text = message;
        label.fontSize = 40;
        label.fontColor = [SKColor blackColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:label];
        
        [self runAction:
         [SKAction sequence:@[
          [SKAction waitForDuration:3.0],
            [SKAction runBlock:^{
             SKTransition *reveal =
             [SKTransition flipHorizontalWithDuration:0.5];
              SKScene *myScene = [[GameScene alloc]initWithSize:self.size];
             [self.view presentScene:myScene transition: reveal];
            }]
          ]]
         ];
    }
    return self;
}

@end
