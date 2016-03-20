//
//  PlayingCardView.m
//  SuperCard
//
//  Created by Danny Ho on 3/14/16.
//  Copyright © 2016 thanksdanny. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView()

@property (nonatomic) CGFloat faceCardScaleFactor;

@end

@implementation PlayingCardView

#pragma mark - properties

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90
- (CGFloat)faceCardScaleFactor {
    if (!_faceCardScaleFactor) {
        _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    }
    return  _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor {
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}


- (void)setSuit:(NSString *)suit{
    _suit = suit;
    [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank {
    _rank = rank;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp {
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    NSLog(@"pinch");
    if (gesture.state == UIGestureRecognizerStateChanged || gesture.state == UIGestureRecognizerStateEnded) {
        self.faceCardScaleFactor *= gesture.scale;
        gesture.scale = 1.0;
    }
}

#pragma mark - drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor{
    return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat)cornerRadius {
    return CORNER_RADIUS * [self cornerScaleFactor];
}

- (CGFloat)cornerOffSet {
    return [self cornerRadius] / 3.0;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    // 画黑边
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
    NSLog(@"%@", self.suit);
    if (faceImage) {
        CGRect imageRect = CGRectInset(self.bounds,
                                       self.bounds.size.width * (1.0 - self.faceCardScaleFactor),
                                       self.bounds.size.height * (1.0 - self.faceCardScaleFactor));
        [faceImage drawInRect:imageRect];
    } else {
        [self drawPips];
    }

    [self drawCorners];

//    if (self.faceUp) {
//        if (faceImage) {
//            CGRect imageRect = CGRectInset(self.bounds,
//                                           self.bounds.size.width * (1.0 - self.faceCardScaleFactor),
//                                           self.bounds.size.height * (1.0 - self.faceCardScaleFactor));
//            [faceImage drawInRect:imageRect];
//        } else {
//            [self drawPips];
//        }
//        
//        [self drawCorners];
//    } else {
//        [[UIImage imageNamed:@"card_back"] drawInRect:self.bounds];
//    }
}

- (void)drawPips {
    
}

- (NSString *)rankAsString {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"][self.rank];
}

- (void)drawCorners {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
    
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], [self suit]] attributes:@{NSFontAttributeName : cornerFont, NSParagraphStyleAttributeName : paragraphStyle}];
    
    CGRect textBounds;
    textBounds.origin = CGPointMake([self cornerOffSet], [self cornerOffSet]);
    textBounds.size = [cornerText size];
    [cornerText drawInRect:textBounds];
    
    // 画个翻转的
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    
    [cornerText drawInRect:textBounds];

}


#pragma mark - Initialization

- (void)setup {
    self.backgroundColor = nil; // 也可用[UIColor clearColor]，无区别，只想表达无背景
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib {
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //<#statements#>
    }
    return self;
}

@end
