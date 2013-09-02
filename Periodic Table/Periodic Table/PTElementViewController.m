//
//  PTElementViewController.m
//  Periodic Table
//
//  Created by Thomas Denney on 01/09/2013.
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "PTElementViewController.h"

@interface PTElementViewController ()

@end

@implementation PTElementViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tapGesture];
}

-(void)configureView
{
    if (_element != nil && self.elementView)
    {
        self.elementView.element = self.element;
        [[NSOperationQueue new] addOperationWithBlock:^{
            NSString * stringUrl = @"http://en.wikipedia.org/wiki/";
            NSString * realUrl = [stringUrl stringByAppendingPathComponent:self.element.elementName];
            realUrl = [realUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            realUrl = [realUrl stringByReplacingOccurrencesOfString:@"%C2%AD" withString:@""];
            NSURL * url = [NSURL URLWithString:realUrl];
            
            OGDocument * document = [ObjectiveGumbo parseDocumentWithUrl:url];
            NSLog(@"Docuemnt = %@ (%@) (%@ + %@ = %@)", document, self.element.elementName, stringUrl, realUrl, url);
            OGElement * textContext = (OGElement*)[document first:@"#mw-content-text"];
            OGElement * firstParagraph = (OGElement*)[textContext first:@"p"];
            NSString * text = firstParagraph.text;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.textView.text = text;
                self.textView.alpha = 0;
                [UIView animateWithDuration:0.35f animations:^{
                    self.elementView.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 440, CGRectGetMidY(self.view.bounds) - 210, 420, 420);
                    self.textView.frame = CGRectMake(CGRectGetMidX(self.view.bounds) + 20, CGRectGetMidY(self.view.bounds) - 210, 420, 420);
                    self.textView.alpha = 1;
                }];
            }];
        }];
    }
}

-(void)setElement:(PTElement *)element
{
    if (_element != element)
    {
        _element = element;
        [self configureView];
    }
}

-(void)tap:(UITapGestureRecognizer*)tapGesture
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
