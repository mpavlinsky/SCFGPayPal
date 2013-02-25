//
//  SCFGViewController.m
//  SCFGSampleApp
//
//  Created by Matthew Pavlinsky on 2/18/13.
//  Copyright (c) 2013 Matthew Pavlinsky. All rights reserved.
//

#import "SCFGViewController.h"

#import "SCFGElementView.h"


#pragma mark -
#pragma mark Constants

static const NSInteger tableColumnSize[18] = {7,6,4,4,4,4,4,4,4,4,4,4,6,6,6,6,6,7};
static const NSInteger tableColumnMaxSize = 7;

static const NSInteger elementPadding = 8;

static const NSInteger buttonPadding = 16;
static const NSInteger buttonHeight = 48;



@interface SCFGViewController ()

@property (strong, nonatomic) UIImageView* background;
@property (strong, nonatomic) UIScrollView* scrollView;
@property (strong, nonatomic) NSMutableArray* columnMap;
@property (strong, nonatomic) NSMutableArray* elements;

@property (strong, nonatomic) UIButton* resetButton;

@end



@implementation SCFGViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SCFGAppBackground"]];
    self.background.alpha = 0.5f;
    [self.view addSubview:self.background];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    
    [self generateElements];
    
    for (UIView* v in self.elements) {
        [self.scrollView addSubview:v];
    }
    
    [self layoutElements];
    
    CGRect resetButtonRect = CGRectZero;
    resetButtonRect.origin.x = buttonPadding;
    resetButtonRect.origin.y = self.view.bounds.size.height - buttonHeight - buttonPadding;
    resetButtonRect.size.width = self.view.bounds.size.width - buttonPadding * 2.0f;
    resetButtonRect.size.height = buttonHeight;
    
    self.resetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.resetButton.frame = resetButtonRect;
    [self.resetButton setTitle:@"Reset" forState:UIControlStateNormal];
    [self.resetButton addTarget:self action:@selector(resetElements:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.resetButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)layoutElements {
    CGSize maxSize = CGSizeZero;
    CGPoint runningPosition = CGPointZero;
    NSInteger currentColumn = 0;
    NSInteger runningColumnCount = 0;
    for (SCFGElementView* ev in self.elements) {
        CGRect newRect = ev.frame;
        newRect.origin = runningPosition;
        ev.frame = newRect;
        
        if (newRect.origin.x + newRect.size.width > maxSize.width) {
            maxSize.width = newRect.origin.x + newRect.size.width;
        }
      
        if (newRect.origin.y + newRect.size.height > maxSize.height) {
            maxSize.height = newRect.origin.y + newRect.size.height;
        }
        
        runningColumnCount++;
        if (runningColumnCount == tableColumnSize[currentColumn]) {
            runningColumnCount = 0;
            currentColumn++;
            
            runningPosition.x += elementSize + elementPadding;
            runningPosition.y = (tableColumnMaxSize - tableColumnSize[currentColumn]) * (elementSize + elementPadding);
        } else {
            runningPosition.y += elementSize + elementPadding;
        }
    }
    
    
    self.scrollView.contentSize = maxSize;
}

- (void)resetElements:(id)sender {
    for (SCFGElementView* ev in self.elements) {
        [ev reinitialize];
    }
    
    [self layoutElements];
}

- (void)generateElements {
    self.elements = [NSMutableArray array];
    
    [self.elements addObject:[SCFGElementView elementWithName:@"Hydrogen" symbol:@"H" number:1 group:SCFGElementGroupNonmetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Lithium" symbol:@"Li" number:3 group:SCFGElementGroupAlkaliMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Sodium" symbol:@"Na" number:11 group:SCFGElementGroupAlkaliMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Potassium" symbol:@"K" number:19 group:SCFGElementGroupAlkaliMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Rubidium" symbol:@"Rb" number:37 group:SCFGElementGroupAlkaliMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Caesium" symbol:@"Cs" number:55 group:SCFGElementGroupAlkaliMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Francium" symbol:@"Fr" number:87 group:SCFGElementGroupAlkaliMetal]];
    
    [self.elements addObject:[SCFGElementView elementWithName:@"Beryllium" symbol:@"Be" number:4 group:SCFGElementGroupAlkalineEarthMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Magnesium" symbol:@"Mg" number:12 group:SCFGElementGroupAlkalineEarthMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Calcium" symbol:@"Ca" number:20 group:SCFGElementGroupAlkalineEarthMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Strontium" symbol:@"Sr" number:38 group:SCFGElementGroupAlkalineEarthMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Barium" symbol:@"Ba" number:56 group:SCFGElementGroupAlkalineEarthMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Radium" symbol:@"Ra" number:88 group:SCFGElementGroupAlkalineEarthMetal]];
    
    [self.elements addObject:[SCFGElementView elementWithName:@"Scandium" symbol:@"Sc" number:21 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Yttrium" symbol:@"Y" number:39 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"" symbol:@"" number:57 group:SCFGElementGroupNone]];
    [self.elements addObject:[SCFGElementView elementWithName:@"" symbol:@"" number:89 group:SCFGElementGroupNone]];
    
    [self.elements addObject:[SCFGElementView elementWithName:@"Titanium" symbol:@"Ti" number:22 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Zirconium" symbol:@"Zr" number:40 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Halfnium" symbol:@"Hf" number:72 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Rutherfordium" symbol:@"Rf" number:104 group:SCFGElementGroupTransitionMetal]];
    
    [self.elements addObject:[SCFGElementView elementWithName:@"Vanadium" symbol:@"V" number:23 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Niobium" symbol:@"Nb" number:41 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Tantalum" symbol:@"Ta" number:73 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Dubnium" symbol:@"Db" number:105 group:SCFGElementGroupTransitionMetal]];
    
    [self.elements addObject:[SCFGElementView elementWithName:@"Chromium" symbol:@"Cr" number:24 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Molybdenum" symbol:@"Mo" number:42 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Tungsten" symbol:@"W" number:74 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Seaborgium" symbol:@"Sg" number:106 group:SCFGElementGroupTransitionMetal]];
    
    [self.elements addObject:[SCFGElementView elementWithName:@"Manganese" symbol:@"Mn" number:25 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Technetium" symbol:@"Tc" number:43 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Rhenium" symbol:@"Re" number:75 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Bohrium" symbol:@"Bh" number:107 group:SCFGElementGroupTransitionMetal]];
    
    [self.elements addObject:[SCFGElementView elementWithName:@"Iron" symbol:@"Fe" number:26 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Ruthenium" symbol:@"Ru" number:44 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Osmium" symbol:@"Os" number:76 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Hassium" symbol:@"Hs" number:108 group:SCFGElementGroupTransitionMetal]];
    
    [self.elements addObject:[SCFGElementView elementWithName:@"Cobalt" symbol:@"Co" number:27 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Rhodium" symbol:@"Rh" number:45 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Iridium" symbol:@"Ir" number:77 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Meitnerium" symbol:@"Mt" number:109 group:SCFGElementGroupTransitionMetal]];
    
    [self.elements addObject:[SCFGElementView elementWithName:@"Nickel" symbol:@"Ni" number:28 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Palladium" symbol:@"Pd" number:46 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Platinum" symbol:@"Pt" number:78 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Damstadium" symbol:@"Ds" number:110 group:SCFGElementGroupTransitionMetal]];
    
    [self.elements addObject:[SCFGElementView elementWithName:@"Copper" symbol:@"Cu" number:29 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Silver" symbol:@"Ag" number:47 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Gold" symbol:@"Au" number:79 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Roentgenium" symbol:@"Rg" number:111 group:SCFGElementGroupTransitionMetal]];
    
    [self.elements addObject:[SCFGElementView elementWithName:@"Zinc" symbol:@"Zn" number:30 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Cadmium" symbol:@"Cd" number:48 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Mercury" symbol:@"Hg" number:80 group:SCFGElementGroupTransitionMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Ununbium" symbol:@"Uub" number:112 group:SCFGElementGroupTransitionMetal]];
    
    [self.elements addObject:[SCFGElementView elementWithName:@"Boron" symbol:@"B" number:5 group:SCFGElementGroupSemimetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Aluminum" symbol:@"Al" number:13 group:SCFGElementGroupBasicMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Gallium" symbol:@"Ga" number:31 group:SCFGElementGroupBasicMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Indium" symbol:@"In" number:49 group:SCFGElementGroupBasicMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Thallium" symbol:@"Tl" number:81 group:SCFGElementGroupBasicMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Ununtrium" symbol:@"Uut" number:113 group:SCFGElementGroupBasicMetal]];
    
    [self.elements addObject:[SCFGElementView elementWithName:@"Carbon" symbol:@"C" number:6 group:SCFGElementGroupNonmetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Silicon" symbol:@"Si" number:14 group:SCFGElementGroupSemimetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Germanium" symbol:@"Ge" number:32 group:SCFGElementGroupSemimetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Tin" symbol:@"Sn" number:50 group:SCFGElementGroupBasicMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Lead" symbol:@"Pb" number:82 group:SCFGElementGroupBasicMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Ununquadium" symbol:@"Uuq" number:114 group:SCFGElementGroupBasicMetal]];
    
    [self.elements addObject:[SCFGElementView elementWithName:@"Nitrogen" symbol:@"N" number:7 group:SCFGElementGroupNonmetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Phosphorus" symbol:@"P" number:15 group:SCFGElementGroupNonmetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Arsenic" symbol:@"As" number:33 group:SCFGElementGroupSemimetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Antimony" symbol:@"Sb" number:51 group:SCFGElementGroupSemimetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Bismuth" symbol:@"Bi" number:83 group:SCFGElementGroupBasicMetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Ununpentium" symbol:@"Uup" number:115 group:SCFGElementGroupBasicMetal]];
    
    [self.elements addObject:[SCFGElementView elementWithName:@"Oxygen" symbol:@"O" number:8 group:SCFGElementGroupNonmetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Sulfur" symbol:@"S" number:16 group:SCFGElementGroupNonmetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Selenium" symbol:@"Se" number:34 group:SCFGElementGroupNonmetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Tellurium" symbol:@"Te" number:52 group:SCFGElementGroupSemimetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Polonium" symbol:@"Po" number:84 group:SCFGElementGroupSemimetal]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Ununhexium" symbol:@"Uuh" number:116 group:SCFGElementGroupBasicMetal]];
    
    [self.elements addObject:[SCFGElementView elementWithName:@"Flourine" symbol:@"F" number:9 group:SCFGElementGroupHalogen]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Chlorine" symbol:@"Cl" number:17 group:SCFGElementGroupHalogen]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Bromine" symbol:@"Br" number:35 group:SCFGElementGroupHalogen]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Iodine" symbol:@"I" number:53 group:SCFGElementGroupHalogen]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Astatine" symbol:@"At" number:85 group:SCFGElementGroupHalogen]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Ununseptium" symbol:@"Uus" number:117 group:SCFGElementGroupHalogen]];
    
    [self.elements addObject:[SCFGElementView elementWithName:@"Helium" symbol:@"He" number:2 group:SCFGElementGroupNobleGas]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Neon" symbol:@"Ne" number:10 group:SCFGElementGroupNobleGas]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Argon" symbol:@"Ar" number:18 group:SCFGElementGroupNobleGas]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Krypton" symbol:@"Kr" number:36 group:SCFGElementGroupNobleGas]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Xenon" symbol:@"Xe" number:54 group:SCFGElementGroupNobleGas]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Radon" symbol:@"Rn" number:86 group:SCFGElementGroupNobleGas]];
    [self.elements addObject:[SCFGElementView elementWithName:@"Ununoctium" symbol:@"Uuo" number:118 group:SCFGElementGroupNobleGas]];
}
@end
