//
//  PlayingCardGameViewController.m
//  CardsEverywhere
//
//  Created by Victor Stoyanov on 1/19/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end
