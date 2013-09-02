//
//  PTElement.h
//  Periodic Table
//
//  Created by Thomas Denney on 01/09/2013.
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTElement : NSObject

@property NSString * elementName;
@property NSString * elementNumber;
@property NSString * elementSymbol;

@property BOOL lanthanide;
@property BOOL actinide;

@property int group;
@property int period;

-(float)renderX;
-(float)renderY;

@end
