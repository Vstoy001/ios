//
//  CardMatchingGame.h
//  CardsEverywhere
//
//  Created by Victor Stoyanov on 1/17/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

-(instancetype) initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

-(void) reset;
-(NSString *) chooseCardAtIndex:(NSUInteger)index inMode:(int)matchMode;
-(Card *)cardAtIndex:(NSUInteger) index;

@property (nonatomic, readonly) NSUInteger score;
@property (strong) NSString *firstCard;
@property (strong) NSString *secondCard;
@property (strong) NSString *thirdCard;
@property (strong) NSString *result;

@end
