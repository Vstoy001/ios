//
//  GameScene.h
//  NinjaTester
//

//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic) SKSpriteNode *player;
@property (nonatomic) int monstersDestroyed;

@property (nonatomic) NSTimeInterval lastSpawnTimeInerval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

@end
