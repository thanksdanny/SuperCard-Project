//
//  PlayingCard.m
//  CardGame
//
//  Created by Danny Ho on 2/7/16.
//  Copyright © 2016 thanksdanny. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
    }
    
    return score;
}

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];   
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
//    return [NSString stringWithFormat:@"%d%@", self.rank, self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits {
    return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?"; // 疑问：这个问号是传0的意思吗，到时翻视频看看，或者讲义
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {return [[self rankStrings] count] - 1;}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}



/*
他妈下面这段不知错什么鬼
*/
//- (int)match:(NSArray *)otherCards {
//    int score = 0;
//    
//    if ([otherCards count] == 1) {
//        PlayingCard *otherCard = [otherCards firstObject];
//        if (otherCard.rank == self.rank) {
//            score = 4;
//        } else if ([otherCard.suit isEqualToString:self.suit]) {
//            score = 1;
//        }
//    
//    return score;
//}
//
//- (NSString *)contents {
//    NSArray *rankStrings = [PlayingCard rankStrings];
//    return [[PlayingCard rankSuitStrings][self.rank] stringByAppendingString:self.suit];
//}
//
//#pragma mark - setter getter
//@synthesize suit = _suit;
//
//- (void)setSuit:(NSString *)suit {
//    if ([[PlayingCard validSuits] containsObject:suit]) {
//        _suit = suit;
//    }
//}
//
//- (NSString *)suit {
//    return _suit ? _suit : @"?";
//}
//
//#pragma mark - 工具
//
//+ (NSArray *)validSuits {
//    return @[@"♠️", @"♣️", @"♥️", @"♦️"];
//}
//
//+ (NSArray *)rankSuitStrings {
//    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
//}
//
//+ (NSUInteger)maxRank {return [[self rankSuitStrings] count] - 1;}


@end
