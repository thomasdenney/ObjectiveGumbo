//
//  PTElementViewController.h
//  Periodic Table
//
//  Created by Thomas Denney on 01/09/2013.
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTElementView.h"
#import "ObjectiveGumbo.h"

@interface PTElementViewController : UIViewController

@property (nonatomic) PTElement * element;
@property (weak, nonatomic) IBOutlet PTElementView *elementView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
