//
//  GameScene.m
//  DragDrop
//
//  Created by Victor Stoyanov on 1/12/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(id) initWithSize:(CGSize)size
{
    if(self = [super initWithSize:size])
    {
        _background = [SKSpriteNode spriteNodeWithImageNamed:@"blue-shooting-stars"];
        [_background setName:@"background"];
        [_background setAnchorPoint:CGPointZero];
        [self addChild:_background];
        
        NSArray *imageNames = @[@"bird",@"cat",@"dog",@"turtle"];
        for(int i = 0; i < [imageNames count]; ++i)
        {
            NSString *imageName = [imageNames objectAtIndex:i];
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:imageName];
            [sprite setName:kAnimalNodeName];
            float offsetFraction = ((float)(i + 1))/([imageNames count] +1);
            [sprite setPosition:CGPointMake(size.width * offsetFraction, size.height /2)];
            [_background addChild:sprite];
        }
    }
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanForm:)];
    [[self view] addGestureRecognizer:gestureRecognizer];
}

-(void) handlePanFrom:(UIPanGestureRecognizer *)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateBegan)
    {
        CGPoint touchLocation = [self convertPointFromView:touchLocation];
        [self selectNodeForTouch:touchLocation];
    } else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = CGPointMake(translation.x, -translation.y);
        [self panForTranslation:translation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
    } else if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        if(![[_selectedNode name] isEqualToString:kAnimalNodeName])
        {
            float scrollDuration = 0.2;
            CGPoint velocity = [recognizer velocityInView:recognizer.view];
            CGPoint pos = [_selectedNode position];
            CGPoint p = mult(velocity, scrollDuration);
            
            CGPoint newPos = CGPointMake(pos.x + p.x, pos.y + p.y);
            newPos = [self boundLayerPos:newPos];
            [_selectedNode removeAllActions];
            
            SKAction *moveTo = [SKAction moveTo:newPos duration:scrollDuration];
            [moveTo setTimingMode:SKActionTimingEaseOut];
            [_selectedNode runAction:moveTo];
        }
    }
}

/*
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    [self selectNodeForTouch:positionInScene];
}
*/
-(void)selectNodeForTouch:(CGPoint)touchLocation
{
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    
    if(![_selectedNode isEqual:touchedNode])
    {
        [_selectedNode removeAllActions];
        [_selectedNode runAction:[SKAction rotateToAngle:0.0f duration:0.1]];
        
        _selectedNode = touchedNode;
        if([[touchedNode name] isEqualToString:kAnimalNodeName])
        {
            SKAction *sequence = [SKAction sequence:@[
                                 [SKAction rotateByAngle:degToRad(-5.0f) duration:0.3],
                                 [SKAction rotateByAngle:0.0 duration:0.1],
                                 [SKAction rotateByAngle:degToRad(5.0f) duration:0.3]]];
            [_selectedNode runAction:[SKAction repeatActionForever:sequence]];
        }
    }
    
}

-(CGPoint)boundLayerPos:(CGPoint)newPos
{
    CGSize winSize = self.size;
    CGPoint retval = newPos;
    
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, -[_background size].width + winSize.width);
    retval.y = [self position].y;
    return retval;
}

-(void)panForTranslation:(CGPoint)translation
{
    CGPoint position = [_selectedNode position];
    if([[_selectedNode name] isEqualToString:kAnimalNodeName])
    {
        [_selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    } else {
        CGPoint newPos = CGPointMake(position.x + translation.x, position.y + translation.y);
        [_background setPosition:[self boundLayerPos:newPos]];
    }
}
/*
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    CGPoint previousPosition = [touch previousLocationInNode:self];
    
    CGPoint translation = CGPointMake(positionInScene.x - previousPosition.x, positionInScene.y - previousPosition.y);
    
    [self panForTranslation:translation];
}
*/
float degToRad(float degree)
{
    return degree /180.0f * M_PI;
}

CGPoint mult(const CGPoint v, const CGFloat s)
{
    return CGPointMake(v.x*s, v.y*s);
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
