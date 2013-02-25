//
//  UIColor+Helpers.h
//  BigFish
//
//  Created by Matthew Pavlinsky on 1/20/13.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (Helpers)

- (UIColor *)lighterColor;
- (UIColor *)darkerColor;

- (UIColor*)adjustBrightness:(CGFloat)adjustment;
- (UIColor*)adjustSaturation:(CGFloat)adjustment;

@end
