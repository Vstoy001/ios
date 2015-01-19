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
@property Card *cardB;
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
        self.secondPicked = NO;
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

- (NSString *) chooseCardAtIndex:(NSUInteger)index inMode:(int)matchMode
{
    Card *card = [self cardAtIndex:index];
    
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
                [self matchTwo:card];
            }
            else if(matchMode == 3)
            {
                if(!self.secondPicked)
                {
                    self.cardB = card;
                    self.cardB.Chosen = YES;
                    self.secondPicked = YES;
                }
                else
                {
                    [self matchThree:card :self.cardB];
                    self.secondPicked = NO;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    return [[[self.firstCard
              stringByAppendingString:self.secondCard]
              stringByAppendingString:self.thirdCard]
              stringByAppendingString:self.result];
}

- (void) matchTwo:(Card *)card
{
    for(Card *otherCard in self.cards)
    {
        if(otherCard.isChosen && !otherCard.isMatched)
        {
            int matchScore = [card match:@[otherCard]];
            self.firstCard = card.contents;
            self.secondCard = otherCard.contents;
            self.thirdCard = @"";
            if(matchScore)
            {
                self.score += matchScore * MATCH_BONUS;
                otherCard.matched = YES;
                card.matched = YES;
                self.result = [NSString stringWithFormat:@"is a match for %d points", matchScore];
            } else {
                self.score -= MIS_MATCH_PENALTY;
                otherCard.chosen = NO;
                self.result = @"is a mismatch";
            }
            break;
        }
    }
}

-(void) matchThree:(Card *)cardA :(Card *)cardB
{
    for(Card *otherCard in self.cards)
    {
        if(otherCard.isChosen && !otherCard.isMatched && cardB.isChosen && ![cardB.contents isEqualToString: otherCard.contents])
        {
            int matchScore = [otherCard match:@[cardA, cardB]];
            self.firstCard = cardA.contents;
            self.secondCard = cardB.contents;
            self.thirdCard = otherCard.contents;
            if(matchScore)
            {
                self.score += matchScore * MATCH_BONUS;
                otherCard.matched = YES;
                cardA.matched = YES;
                cardB.matched = YES;
                self.result = [NSString stringWithFormat:@"is a match for %d points", matchScore];
            } else {
                self.score -= MIS_MATCH_PENALTY;
                otherCard.chosen = NO;
                cardA.chosen = NO;
                self.secondPicked = NO;
                self.result = @"is a mismatch";
            }
            break;
        }
    }
}

@end

