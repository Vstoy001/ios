//
//  SetCard.m
//  CardsEverywhere
//
//  Created by Victor Stoyanov on 1/20/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+(NSArray *) validShapes
{
    return @[@"triangle",@"square",@"circle"];
}

+(NSArray *) validColors
{
    return @[@"blue", @"red", @"green"];
}

@end
