//
//  PTElementView.m
//  Periodic Table
//
//  Created by Thomas Denney on 01/09/2013.
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "PTElementView.h"

@implementation PTElementView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self generalInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self generalInit];
    }
    return self;
}

-(void)generalInit
{
    self.backgroundColor = [UIColor colorWithRed:0.15f green:0.3f blue:0.15f alpha:1];
    
    self.symbolLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.symbolLabel.textAlignment = NSTextAlignmentCenter;
    self.symbolLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.symbolLabel];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) * 0.1f, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) * 0.2f)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.nameLabel];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) * 0.7f, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) * 0.2f)];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.numberLabel];
}

-(void)layoutSubviews
{
    self.symbolLabel.frame = self.bounds;
    self.nameLabel.frame = CGRectMake(0, CGRectGetHeight(self.bounds) * 0.1f, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) * 0.2f);
    self.numberLabel.frame = CGRectMake(0, CGRectGetHeight(self.bounds) * 0.7f, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) * 0.2f);
    self.symbolLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.bounds) * 0.5f];
    self.nameLabel.font = self.numberLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.bounds) * 0.1f];
    self.nameLabel.hidden = self.numberLabel.hidden = CGRectGetHeight(self.bounds) < 100;
}

-(void)setElement:(PTElement *)element
{
    if (_element != element)
    {
        _element = element;
        self.symbolLabel.text = element.elementSymbol;
        self.nameLabel.text = element.elementName;
        self.numberLabel.text = element.elementNumber;
    }
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self layoutSubviews];
}

@end
