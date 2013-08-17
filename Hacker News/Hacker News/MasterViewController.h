//
//  MasterViewController.h
//  Hacker News
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "ObjectiveGumbo.h"
#import "Article.h"

@interface MasterViewController : UITableViewController

@property NSArray * articles;

@property NSOperationQueue * backgroundOperationQueue;

- (IBAction)refresh:(id)sender;

@end
