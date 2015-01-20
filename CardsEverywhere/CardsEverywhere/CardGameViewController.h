//
//  CardGameViewController.h
//  CardsEverywhere
//
//  Created by Victor Stoyanov on 1/17/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

- (Deck *) createDeck; //abstract

@end
