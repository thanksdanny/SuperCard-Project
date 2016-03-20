//
//  ViewController.m
//  SuperCard
//
//  Created by Danny Ho on 3/14/16.
//  Copyright © 2016 thanksdanny. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@property (nonatomic, strong) Deck *deck;

@end

@implementation ViewController

- (Deck *)deck { // 忘记懒加载deck，导致没实现随机...
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    if (!self.playingCardView.faceUp) {
        [self drawRandomPlayingCard];
    }
    self.playingCardView.faceUp = !self.playingCardView.faceUp;
}

- (void)drawRandomPlayingCard {
    Card *card = [self.deck drawRandomCard];
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playingCard = (PlayingCard *)card;
        self.playingCardView.rank = playingCard.rank;
        self.playingCardView.suit = playingCard.suit;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.playingCardView.suit = @"♥";
    self.playingCardView.rank = 13;
    [self.playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView
                                                                                         action:@selector(pinch:)]];
}



@end
