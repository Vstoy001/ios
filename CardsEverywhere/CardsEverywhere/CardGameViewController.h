//
//  CardGameViewController.h
//  CardsEverywhere
//
//  Created by Victor Stoyanov on 1/17/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *matchSetting;

@property (nonatomic) int flipsCount;
@property (nonatomic) int matchMode;
@property (strong) NSString *result;
@property (strong, nonatomic) IBOutlet UILabel *actionTaken;

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

- (IBAction)resetButton:(UIButton *)sender;
- (IBAction)matchToggle:(UISegmentedControl *)sender;

@end
