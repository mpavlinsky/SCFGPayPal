//
//  SCFGElementView.m
//  SCFGSampleApp
//
//  Created by Matthew Pavlinsky on 2/18/13.
//  Copyright (c) 2013 Matthew Pavlinsky. All rights reserved.
//

#import "SCFGElementView.h"

#import "UIColor+Helpers.h"
#import "SCFGImageGenerator.h"


#pragma mark -
#pragma mark Private

////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SCFGElementView ()

@property (strong, nonatomic) UIImageView* elementBackground;
@property (strong, nonatomic) UIButton* elementButton;
@property (strong, nonatomic) UILabel* elementSymbol;
@property (nonatomic) SCFGElementGroup group;

@property (strong, nonatomic) NSString* elementName;
@property (nonatomic) NSInteger elementNumber;

@property (nonatomic) CGFloat rotation;


@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SCFGElementView

+ (SCFGElementView*)elementWithName:(NSString*)name symbol:(NSString*)symbol number:(NSInteger)number group:(SCFGElementGroup)group {
    SCFGElementView* newElement = [[SCFGElementView alloc] initWithName:name symbol:symbol number:number group:group];

    return newElement;
}

- (id)initWithName:(NSString*)name symbol:(NSString*)symbol number:(NSInteger)number group:(SCFGElementGroup)group {
    CGRect viewRect = CGRectMake(0.0f, 0.0f, elementSize, elementSize);
    self = [super initWithFrame:viewRect];
    if (self) {
        self.elementBackground = [[UIImageView alloc] init];
        self.elementBackground.frame = self.bounds;
        [self addSubview:self.elementBackground];
        
        self.group = group;
        [self setProperBackgroundColorForGroup];

        self.elementNumber = number;
        self.elementName = name;
        
        self.autoresizesSubviews = YES;
        
        self.elementSymbol = [[UILabel alloc] initWithFrame:self.bounds];
        self.elementSymbol.text = symbol;
        self.elementSymbol.font = [UIFont boldSystemFontOfSize:24.0f];
        self.elementSymbol.textAlignment = NSTextAlignmentCenter;
        self.elementSymbol.backgroundColor = [UIColor clearColor];
        self.elementSymbol.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin);
        [self addSubview:self.elementSymbol];
        
        self.elementButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.elementButton.frame = self.bounds;
        [self.elementButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.elementButton];
    }
    return self;
}

- (void)reinitialize {
    self.transform = CGAffineTransformIdentity;
    self.alpha = 1.0f;
    self.frame = CGRectMake(0.0f, 0.0f, elementSize, elementSize);
    self.elementButton.frame = self.bounds;
    self.rotation = 0.0f;
}

- (void)setProperBackgroundColorForGroup {
    switch (self.group) {
        case SCFGElementGroupNobleGas:
            [self setColor:[UIColor blueColor]];
            break;
        case SCFGElementGroupHalogen:
            [self setColor:[UIColor blueColor]];
            break;
        case SCFGElementGroupNonmetal:
            [self setColor:[UIColor blueColor]];
            break;
        case SCFGElementGroupSemimetal:
            [self setColor:[UIColor blueColor]];
            break;
        case SCFGElementGroupBasicMetal:
            [self setColor:[UIColor blueColor]];
            break;
        case SCFGElementGroupAlkaliMetal:
            [self setColor:[UIColor blueColor]];
            break;
        case SCFGElementGroupAlkalineEarthMetal:
            [self setColor:[UIColor blueColor]];
            break;
        case SCFGElementGroupTransitionMetal:
            [self setColor:[UIColor blueColor]];
            break;
        default:
            self.alpha = 0.0f;
            [self.elementButton removeTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;
    }
}

- (void)setColor:(UIColor*)color {
    self.backgroundColor = [UIColor clearColor];
    self.elementBackground.image = [SCFGImageGenerator roundedRectImageWithRect:self.bounds andColor:color];
}



static const CGFloat touchScale = 1.25f;

- (void)buttonPressed:(id)sender {
    [self changeSizeByScalar:touchScale overSeconds:0.1f withCompletion:^(BOOL finished) {
        
        // Do a little pop back animation. For flare.
        [UIView animateWithDuration:0.06 animations:^{
            self.transform = CGAffineTransformScale(self.transform, 0.9f, 0.9f);
        }];
    }];
}

- (void)changeSizeByScalar:(CGFloat)scalar overSeconds:(CGFloat)seconds withCompletion:(void (^)(BOOL finished))completion {

    [UIView animateWithDuration:seconds animations:^{
        self.alpha -= 0.25f;
        self.transform = CGAffineTransformScale(self.transform, scalar, scalar);
        
        self.rotation += 1.0f;
        self.transform = CGAffineTransformRotate(self.transform, M_PI_2);
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}

@end
