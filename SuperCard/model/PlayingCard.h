//
//  PlayingCard.h
//  CardGame
//
//  Created by Danny Ho on 2/7/16.
//  Copyright © 2016 thanksdanny. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (nonatomic, strong) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
