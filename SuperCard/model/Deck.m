//
//  Deck.m
//  CardGame
//
//  Created by Danny Ho on 2/7/16.
//  Copyright © 2016 thanksdanny. All rights reserved.
//

#import "Deck.h"

@interface Deck ()

@property (nonatomic, strong) NSMutableArray *cards;

@end

@implementation Deck
// oc中所有实例变量开始都是nil，所以要修改getter
// 在堆中分配一个数组并指向他，并赋值给实例变量
- (NSMutableArray *)cards {
    if (!_cards) _cards =[[NSMutableArray alloc] init];  // 疑问 为啥这里创建完会有52张 答：应该是因为PlayingCardDeck里的init方法?
    

    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (void)addCard:(Card *)card {
    [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard {
    Card *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count]; // 获取0到[self.cards count]-1之间的整数
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}


@end
