//
//  SetCard.h
//  CardsEverywhere
//
//  Created by Victor Stoyanov on 1/20/15.
//  Copyright (c) 2015 Victor Stoyanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetCard : NSObject

@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *color;
@property NSInteger *number;

+(NSArray *) validShapes;
+(NSArray *) validColors;

@end
