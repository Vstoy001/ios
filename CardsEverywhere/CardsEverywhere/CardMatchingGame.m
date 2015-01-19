//
//  CardMatchingGame.m
//  CardsEverywhere
//
//  Created by Victor Stoyanov on 1/17/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSUInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property BOOL secondPicked;
@end

@implementation CardMatchingGame

- (NSMutableArray *) cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if(self)
    {
        for(int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if(card)
            {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        self.secondPicked = NO;
    }
    return self;
}

- (Card *) cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

-(void) reset
{
    self.secondPicked = NO;
    self.score = 0;
}

static const int MIS_MATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
//static Card *prevCard = [[Card alloc] initEmptyCard];

- (void) chooseCardAtIndex:(NSUInteger)index inMode:(int)matchMode
{
    Card *card = [self cardAtIndex:index];
    Card *cardA = [self cardAtIndex:index];
    
    if(!card.isMatched)
    {
        if(card.isChosen)
        {
            card.chosen = NO;
        }
        else
        {
            if(matchMode == 2)
            {
                NSLog(@"going to matchTwo!");
                [self matchTwo:card];
            }
            else if(matchMode == 3)
            {
                NSLog(@"secondPicked is: %d", self.secondPicked);
                if(!self.secondPicked)
                {
                    cardA = card;
                    self.secondPicked = YES;
                }
                else
                {
                    NSLog(@"going to matchThree!");
                    [self matchThree:card :cardA];
                    self.secondPicked = NO;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (void) matchTwo:(Card *)card
{
    for(Card *otherCard in self.cards)
    {
        if(otherCard.isChosen && !otherCard.isMatched)
        {
            int matchScore = [card match:@[otherCard]];
            if(matchScore)
            {
                self.score += matchScore * MATCH_BONUS;
                otherCard.matched = YES;
                card.matched = YES;
            } else {
                self.score -= MIS_MATCH_PENALTY;
                otherCard.chosen = NO;
            }
            break;
        }
    }
}

-(void) matchThree:(Card *)cardA :(Card *)cardB
{
    for(Card *otherCard in self.cards)
    {
        if(otherCard.isChosen && !otherCard.isMatched)
        {
            int matchScore = [otherCard match:@[cardA, cardB]];
            if(matchScore)
            {
                self.score += matchScore * MATCH_BONUS;
                otherCard.matched = YES;
                cardA.matched = YES;
                cardB.matched = YES;
            } else {
                self.score -= MIS_MATCH_PENALTY;
                otherCard.chosen = NO;
            }
            break;
        }
    }
}

@end

