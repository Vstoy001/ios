//
//  GameScene.h
//  DragDrop
//

//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

static NSString * const kAnimalNodeName = @"moveable";

@interface GameScene : SKScene

@property (nonatomic, strong) SKSpriteNode *background;
@property (nonatomic, strong) SKSpriteNode *selectedNode;

-(id) initWithSize:(CGSize)size;

@end
