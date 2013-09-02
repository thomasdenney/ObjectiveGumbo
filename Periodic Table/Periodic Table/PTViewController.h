//
//  PTViewController.h
//  Periodic Table
//
//  Created by Thomas Denney on 01/09/2013.
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import "ObjectiveGumbo.h"
#import "PTElement.h"
#import "PTElementView.h"
#import "PTElementViewController.h"

const int ELEMENT_SIZE = 45;
const int ELEMENT_SPACING = 5;
const int ELEMENT_SIZE_PLUS_SPACING = ELEMENT_SIZE + ELEMENT_SPACING;

@interface PTViewController : UIViewController

@property NSArray * elements;

@end
