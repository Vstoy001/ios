//
//  PlayingCardGameViewController.m
//  CardsEverywhere
//
//  Created by Victor Stoyanov on 1/19/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardGameViewController

-(void) viewDidLoad
{
    NSDictionary *tabText = [NSDictionary dictionaryWithObjectsAndKeys:
    [UIFont fontWithName:@"System" size:50.0f], UITextAttributeFont,
    [UIColor blackColor], UITextAttributeTextColor,
    nil,
    nil,
    nil];
    [self.tabBarItem setTitleTextAttributes:tabText forState:UIControlStateNormal];
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}
/*
- (void) updateUI
{
    for(UIButton *cardButton in self.cardButtons)
    {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        self.actionTaken.text = _result;
    }
}
*/
@end
