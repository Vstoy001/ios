//
//  GameScene.m
//  NinjaTester
//
//  Created by Victor Stoyanov on 1/10/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//  =================
//

#import "GameScene.h"
#import "GameOverScene.h"

static const uint32_t projectileCategory = 0x1 << 0;
static const uint32_t monsterCategory   = 0x1 << 1;

static const int GRAVITY = 0;

static inline CGPoint rwAdd(CGPoint a, CGPoint b)
{
    return CGPointMake(a.x + b.x, a.y + b.y);
}
static inline CGPoint rwSub(CGPoint a, CGPoint b)
{
    return CGPointMake(a.x - b.x, a.y - b.y);
}
static inline CGPoint rwMulti(CGPoint a, float b)
{
    return CGPointMake(a.x * b, a.y * b);
}
static inline float rwLength(CGPoint a)
{
    return sqrt(a.x * a.x + a.y + a.y);
}
static inline CGPoint rwNormalize(CGPoint a)
{
    float length = rwLength(a);
    return CGPointMake(a.x/length, a.y/length);
}

@implementation GameScene

- (id) initWithSize:(CGSize)size
{
    if(self = [super initWithSize:size])
    {
        NSLog(@"Size: %@", NSStringFromCGSize(size));
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    
        self.player = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
        self.player.position = CGPointMake(self.player.size.width/2,self.frame.size.height/2);
        [self addChild:self.player];
        
        self.physicsWorld.gravity = CGVectorMake(0, GRAVITY);
        self.physicsWorld.contactDelegate = self;
    }
    return self;
}

- (void) addMonster
{
    SKSpriteNode * monster = [SKSpriteNode spriteNodeWithImageNamed: @"monster"];
    
    monster.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:monster.size];
    monster.physicsBody.dynamic = YES;
    monster.physicsBody.categoryBitMask = monsterCategory;
    monster.physicsBody.contactTestBitMask = projectileCategory;
    monster.physicsBody.collisionBitMask = 0;
    
    int minY = monster.size.height/2;
    int maxY = self.frame.size.height - monster.size.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    monster.position = CGPointMake(self.frame.size.width + monster.size.width/2, actualY);
    [self addChild:monster];
    
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    SKAction *actionMove = [SKAction moveTo:CGPointMake(-monster.size.width/2, actualY)duration:actualDuration];
    SKAction *actionMoveDone = [SKAction removeFromParent];
    SKAction *loseAction = [SKAction runBlock:^{
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene *gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:NO];
        [self.view presentScene:gameOverScene transition: reveal];
    }];
    [monster runAction:[SKAction sequence:@[actionMove, loseAction, actionMoveDone]]];
}

- (void) updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast
{
    self.lastSpawnTimeInerval += timeSinceLast;
    if(self.lastSpawnTimeInerval > 1)
    {
        self.lastSpawnTimeInerval = 0;
        [self addMonster];
    }
}

- (void) update:(NSTimeInterval)currentTime
{
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
     self.lastUpdateTimeInterval = currentTime;
     if(timeSinceLast > 1)
     {
         timeSinceLast = 1.0/60.0;
         self.lastUpdateTimeInterval = currentTime;
     }
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self runAction:[SKAction playSoundFileNamed:@"pew-pew-lei.caf" waitForCompletion:NO]];
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    SKSpriteNode *projectile = [SKSpriteNode spriteNodeWithImageNamed:@"projectile"];
    projectile.position = self.player.position;
    
    CGPoint offset = rwSub(location, projectile.position);
    
    if(offset.x <= 0) return;
    
    projectile.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:projectile.size.width/2];
    projectile.physicsBody.dynamic = YES;
    projectile.physicsBody.categoryBitMask = projectileCategory;
    projectile.physicsBody.contactTestBitMask = monsterCategory;
    projectile.physicsBody.collisionBitMask = 0;
    projectile.physicsBody.usesPreciseCollisionDetection = YES;
    
    [self addChild:projectile];
    CGPoint direction = rwNormalize(offset);
    CGPoint shootAmount = rwMulti(direction, 1000);
    CGPoint realDest = rwAdd(shootAmount, projectile.position);
    
    float velocity = 480.0/1.0;
    float realMoveDuration = self.size.width / velocity;
    SKAction *actionMove = [SKAction moveTo:realDest duration:realMoveDuration];
    SKAction *actionMoveDone = [SKAction removeFromParent];
    [projectile runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
}

- (void) projectile:(SKSpriteNode *)projectile didCollideWithMonster:(SKSpriteNode *)monster
{
    NSLog(@"hit");
    [projectile removeFromParent];
    [monster removeFromParent];
    self.monstersDestroyed++;
    if(self.monstersDestroyed > 10)
    {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene *gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:YES];
        [self.view presentScene:gameOverScene transition:reveal];
    }
}

- (void) didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if((firstBody.categoryBitMask & projectileCategory) != 0 && (secondBody.categoryBitMask & monsterCategory) != 0)
    {
        [self projectile:(SKSpriteNode *) firstBody.node didCollideWithMonster:(SKSpriteNode *) secondBody.node];
    }
}

@end
