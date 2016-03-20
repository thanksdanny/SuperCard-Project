//
//  Card.m
//  CardGame
//
//  Created by Danny Ho on 2/7/16.
//  Copyright © 2016 thanksdanny. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards {
    int score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}
@end
