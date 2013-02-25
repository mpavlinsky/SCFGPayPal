//
//  SCFGImageGenerator.m
//  SCFGSampleApp
//
//  Created by Matthew Pavlinsky on 2/24/13.
//  Copyright (c) 2013 Matthew Pavlinsky. All rights reserved.
//

#import "SCFGImageGenerator.h"
#import "UIColor+Helpers.h"

@implementation SCFGImageGenerator


+ (UIImage*)roundedRectImageWithRect:(CGRect)rect andColor:(UIColor*)color {
    
    // Outline
    const CGFloat radius = 10.0f;
    CGFloat outlineWidth = 0.0f;
    if (rect.size.height > rect.size.width) {
        outlineWidth = rect.size.width * 0.05f;
    } else {
        outlineWidth = rect.size.height * 0.05f;
    }
    const CGFloat outlineHalfWidth = outlineWidth * 0.5f;
    
    UIColor* outlineColor = [color adjustBrightness:0.7f];
    UIColor* insideColor = [color adjustSaturation:0.7f];
    UIColor* edgeColor = [UIColor blackColor];
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, insideColor.CGColor);
    CGContextSetStrokeColorWithColor(ctx, outlineColor.CGColor);
    
    UIBezierPath* rectOutline = [SCFGImageGenerator getRoundedRectWithRadius:radius rect:rect shrink:outlineHalfWidth width:outlineWidth];
    
    [rectOutline fill];
    [rectOutline stroke];
    
    CGContextSetStrokeColorWithColor(ctx, edgeColor.CGColor);
    UIBezierPath* firstEdge  = [SCFGImageGenerator getRoundedRectWithRadius:radius rect:rect shrink:0.5f width:1.0f];
    [firstEdge stroke];
    
    UIBezierPath* secondEdge  = [SCFGImageGenerator getRoundedRectWithRadius:radius rect:rect shrink:outlineWidth+0.5f width:1.0f];
    [secondEdge stroke];
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIBezierPath*)getRoundedRectWithRadius:(CGFloat)radius rect:(CGRect)rect shrink:(CGFloat)shrink width:(CGFloat)width {
    // Outline
    CGRect insetRect = CGRectMake(CGRectGetMinX(rect) + shrink,
                                  CGRectGetMinY(rect) + shrink,
                                  rect.size.width - shrink * 2.0f,
                                  rect.size.height - shrink * 2.0f);
    
    const CGFloat outlineMinX = CGRectGetMinX(insetRect);
    const CGFloat outlineMinY = CGRectGetMinY(insetRect);
    
    const CGFloat outlineMaxX = CGRectGetMaxX(insetRect);
    const CGFloat outlineMaxY = CGRectGetMaxY(insetRect);
    
    radius = radius - shrink;
    
    UIBezierPath* rectOutline = [UIBezierPath bezierPath];
    
    [rectOutline moveToPoint:CGPointMake(outlineMaxX - radius, outlineMinY)];
    [rectOutline addArcWithCenter:CGPointMake(outlineMaxX - radius, outlineMinY + radius) radius:radius startAngle:-M_PI_2 endAngle:0.0f clockwise:YES];
    [rectOutline addArcWithCenter:CGPointMake(outlineMaxX - radius, outlineMaxY - radius) radius:radius startAngle:0.0f endAngle:M_PI_2 clockwise:YES];
    [rectOutline addArcWithCenter:CGPointMake(outlineMinX + radius, outlineMaxY - radius) radius:radius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    [rectOutline addArcWithCenter:CGPointMake(outlineMinX + radius, outlineMinY + radius) radius:radius startAngle:M_PI endAngle:-M_PI_2 clockwise:YES];
    [rectOutline closePath];
    
    rectOutline.lineWidth = width;
    
    return rectOutline;
}

@end
