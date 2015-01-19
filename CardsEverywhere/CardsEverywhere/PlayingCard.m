//
//  PlayingCard.m
//  CardsEverywhere
//
//  Created by Victor Stoyanov on 1/17/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int) match:(NSArray *)otherCards
{
    int score = 0;
    //2 card match
    if([otherCards count] == 1)
    {
        PlayingCard *otherCard = [otherCards firstObject];
        if(otherCard.rank == self.rank)
        {
            score = 4;
        } else if([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
    }
    //3 card match
    if([otherCards count] == 2)
    {
        for(int i = 1; i < [otherCards count]; i++)
        {
            if([otherCards[0] rank] == [otherCards[i] rank])
            {
                score += 4;
            } else if([[otherCards[0] suit] isEqualToString:[otherCards[i] suit]]) {
                score += 1;
            }
        }
        //PlayingCard *otherCard = [otherCards firstObject];
        //PlayingCard *anotherCard = [otherCards objectAtIndex:1];
        for(PlayingCard *otherCard in otherCards)
        {
            if(otherCard.rank == self.rank)
            {
                score += 4;
            } else if ([otherCard.suit isEqualToString:self.suit]) {
                score += 1;
            }
        }
    }
    return score;
}

-(NSString *) contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+(NSArray *) validSuits
{
    return @[@"♥️",@"♦️",@"♠️",@"♣️"];
}

+(NSArray *) rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger) maxRank
{
    return [[self rankStrings] count] - 1;
}

-(void) setRank:(int)rank
{
    if(rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

-(void) setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

@end
