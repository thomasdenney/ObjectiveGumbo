//
//  PTViewController.m
//  Periodic Table
//
//  Created by Thomas Denney on 01/09/2013.
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "PTViewController.h"

@interface PTViewController ()

@end

@implementation PTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Fetch the data
    [[NSOperationQueue new] addOperationWithBlock:^{
        
        NSMutableArray * elements = [NSMutableArray new];
        
        OGDocument * periodicTableDocument = [ObjectiveGumbo parseDocumentWithUrl:[NSURL URLWithString:@"http://en.wikipedia.org/wiki/Periodic_Table"]];
        OGElement * tableContainer = (OGElement*)[periodicTableDocument first:@".collapsible"];
        NSArray * tableRows = [tableContainer select:@"tr"];
        for (int n = 3; n < tableRows.count && n < 13; n++)
        {
            OGElement * tableRow = tableRows[n];
            BOOL lanthanides = n == 11;
            BOOL actinides = n == 12;
            int group = (lanthanides || actinides) ? 3 : 1;
            NSArray * cells = [tableRow select:@"td"];
            for (OGElement * cell in cells)
            {
                if (cell.children.count > 0)
                {
                    OGElement * infoDiv = (OGElement*)[cell first:@"div"];
                    NSArray * childDivs = [infoDiv select:@"div"];
                    if (childDivs.count >= 3)
                    {
                        PTElement * element = [PTElement new];
                        element.elementName = [childDivs[0] text];
                        element.elementNumber = [childDivs[1] text];
                        element.elementSymbol = [childDivs[2] text];
                        element.period = n - 2;
                        element.lanthanide = lanthanides;
                        element.actinide = actinides;
                        element.group = group;
                        if (lanthanides) element.period = 6;
                        if (actinides) element.period = 7;
                        [elements addObject:element];

                    }
                    if (!lanthanides && !actinides) group++;
                }
                else if (cell.attributes[@"colspan"] != nil && !lanthanides && !actinides)
                {
                    group += [cell.attributes[@"colspan"] intValue];
                }
            }
        }
        self.elements = elements;
        [self updateView];
    }];
    
    NSLog(@"Started");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateView
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        for (UIView * subview in self.view.subviews)
        {
            [subview removeFromSuperview];
        }
        
        float totalWidth = 18 * ELEMENT_SIZE_PLUS_SPACING;
        float totalHeight = 9.5 * ELEMENT_SIZE_PLUS_SPACING;
        float startX = CGRectGetMidX(self.view.bounds) - totalWidth / 2;
        float startY = CGRectGetMidY(self.view.bounds) - totalHeight / 2;
        
        for (PTElement * element in self.elements)
        {
            PTElementView * view = [[PTElementView alloc] initWithFrame:CGRectMake(startX + ELEMENT_SIZE_PLUS_SPACING * element.renderX, startY + ELEMENT_SIZE_PLUS_SPACING * element.renderY, ELEMENT_SIZE, ELEMENT_SIZE)];
            view.element = element;
            UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(elementTapped:)];
            [view addGestureRecognizer:tapGesture];
            [self.view addSubview:view];
        }
    }];
}

-(void)elementTapped:(UITapGestureRecognizer*)tapGesture
{
    PTElementView * elementView = (PTElementView*)tapGesture.view;
    PTElement * element = elementView.element;
    PTElementViewController * elementViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"elementViewController"];
    elementViewController.element = element;
    
    elementViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    elementViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:elementViewController animated:YES completion:nil];
}

@end
