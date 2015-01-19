//
//  Card.m
//  CardsEverywhere
//
//  Created by Victor Stoyanov on 1/17/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int) match:(NSArray *) otherCards
{
    int score = 0;
    
    for(Card *card in otherCards)
    {
        if([card.contents isEqualToString:self.contents])
        {
            score = 1;
        }
    }
    
    return score;
}

-(Card *) initEmptyCard
{
    self.contents = @"";
    return self;
}

@end
