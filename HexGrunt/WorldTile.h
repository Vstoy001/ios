//
//  WorldTile.h
//  HexGrunt
//
//  Created by Victor Stoyanov on 1/12/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface WorldTile : UIImage

@property (nonatomic) SKSpriteNode *tile;
@property (nonatomic) int centerX;
@property (nonatomic) int centerY;

- (void) initWithCenterX:(int)centerX Y:(int)centerY;

@end
