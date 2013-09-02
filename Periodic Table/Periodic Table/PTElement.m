//
//  PTElement.m
//  Periodic Table
//
//  Created by Thomas Denney on 01/09/2013.
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "PTElement.h"

@implementation PTElement

-(float)renderX
{
    if (self.lanthanide) return 2 + ([self.elementNumber intValue] - 57);
    else if (self.actinide) return 2 + ([self.elementNumber intValue] - 89);
    else return self.group - 1;
}

-(float)renderY
{
    if (self.lanthanide) return 7.5;
    else if (self.actinide) return 8.5;
    return self.period - 1;
}

@end
