//
//  CardMatchingGame.m
//  CardGame
//
//  Created by Danny Ho on 2/14/16.
//  Copyright © 2016 thanksdanny. All rights reserved.
//

#import "CardMatchingGame.h"


@interface CardMatchingGame ()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init]; // super's designated initializer
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;  // 为nil之后是返回nil？
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BOUNUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {  // 回头要在研究下这个方法
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {  // 没匹配才跳进去
        if (card.isChosen) { // 卡片被选才跳进去
            card.chosen = NO;
        } else {
            // match against other chose cards
            for (Card *otherCard in self.cards) { // cards怎么知道是16张
                if (otherCard.isChosen && !otherCard.isMatched) { // 如果otherCard被选 与 otherCard是不匹配的 才跳进去
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BOUNUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break; // can only choose 2 cards for now
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

@end

