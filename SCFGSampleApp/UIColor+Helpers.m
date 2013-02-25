//
//  UIColor+Helpers.m
//  BigFish
//
//  Created by Matthew Pavlinsky on 1/20/13.
//
//

#import "UIColor+Helpers.h"

@implementation UIColor (Helpers)


- (UIColor *)lighterColor
{
    return [self adjustBrightness:1.3f];
}

- (UIColor *)darkerColor
{
    return [self adjustBrightness:0.75f];
}

- (UIColor*)adjustBrightness:(CGFloat)adjustment {
    float h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:MIN(b * adjustment, 1.0)
                               alpha:a];
    return nil;
}

- (UIColor*)adjustSaturation:(CGFloat)adjustment {
    float h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:MIN(s * adjustment, 1.0)
                          brightness:b
                               alpha:a];
    return nil;
}

@end
