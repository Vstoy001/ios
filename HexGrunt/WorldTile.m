//
//  WorldTile.m
//  HexGrunt
//
//  Created by Victor Stoyanov on 1/12/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import "WorldTile.h"

@implementation WorldTile

-(void) initWithCenterX:(int)centerX Y:(int)centerY
{
    self.tile = [SKSpriteNode spriteNodeWithImageNamed:@"Grid"];
    self.tile.position = CGPointMake(centerX, centerY);
}

@end
