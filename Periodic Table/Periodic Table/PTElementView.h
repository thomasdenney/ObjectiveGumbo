//
//  PTElementView.h
//  Periodic Table
//
//  Created by Thomas Denney on 01/09/2013.
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTElement.h"

@interface PTElementView : UIView

@property (nonatomic) PTElement * element;

@property UILabel * symbolLabel;
@property UILabel * nameLabel;
@property UILabel * numberLabel;

@end
