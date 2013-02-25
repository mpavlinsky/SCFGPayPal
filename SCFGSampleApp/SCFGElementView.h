//
//  SCFGElementView.h
//  SCFGSampleApp
//
//  Created by Matthew Pavlinsky on 2/18/13.
//  Copyright (c) 2013 Matthew Pavlinsky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SCFGElementGroupNone                = 0,
    SCFGElementGroupNobleGas            = (1<<0),
    SCFGElementGroupHalogen             = (1<<1),
    SCFGElementGroupNonmetal            = (1<<2),
    SCFGElementGroupSemimetal           = (1<<3),
    SCFGElementGroupBasicMetal          = (1<<4),
    SCFGElementGroupAlkaliMetal         = (1<<5),
    SCFGElementGroupAlkalineEarthMetal  = (1<<6),
    SCFGElementGroupTransitionMetal     = (1<<7),
    SCFGElementGroupMaxValue = SCFGElementGroupTransitionMetal,
} SCFGElementGroup;

static const NSInteger elementSize = 48;

@interface SCFGElementView : UIView

+ (SCFGElementView*)elementWithName:(NSString*)name symbol:(NSString*)symbol number:(NSInteger)number group:(SCFGElementGroup)group;
- (id)initWithName:(NSString*)name symbol:(NSString*)symbol number:(NSInteger)number group:(SCFGElementGroup)group;

- (void)reinitialize;

@end
