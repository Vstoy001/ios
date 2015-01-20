//
//  CardGameViewController.m
//  CardsEverywhere
//
//  Created by Victor Stoyanov on 1/17/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController()

@property (strong, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *matchSetting;

@property (nonatomic) int flipsCount;
@property (nonatomic) int matchMode;
@property (strong) NSString *result;
@property (strong, nonatomic) IBOutlet UILabel *actionTaken;

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation CardGameViewController

-(CardMatchingGame *) game
{
    if(!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

-(Deck *) createDeck
{
    return nil;//[[PlayingCardDeck alloc] init];
}

-(void) setFlipsCount:(int)flipsCount
{
    _flipsCount = flipsCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipsCount];
}

- (IBAction) touchCardButton:(UIButton *)sender
{
    int choseButtonIndex = [self.cardButtons indexOfObject:sender];
    self.result = [self.game chooseCardAtIndex:choseButtonIndex inMode:_matchMode];
    [[self actionTaken] setText:@"picked: "];
    [self updateUI];
    self.flipsCount++;
}

-(void) updateUI
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

-(NSString *)titleForCard:(Card *) card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *) backgroundForCard:(Card *) card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)resetButton:(UIButton *)sender
{
    self.flipsCount = 0;
    self.result = @"";
    [self.game reset];
    self.game = nil;
    [[self matchSetting] setSelectedSegmentIndex:0];
    self.matchMode = 2;
    [self updateUI];
}

- (IBAction)matchToggle:(UISegmentedControl *)sender
{
    
    int mode = [sender selectedSegmentIndex];
    if(mode == 0)
    {
        self.matchMode = 2;
    }
    else
    {
        self.matchMode = 3;
    }
    
}
@end
