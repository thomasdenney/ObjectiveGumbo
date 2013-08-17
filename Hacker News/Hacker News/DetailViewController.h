//
//  DetailViewController.h
//  Hacker News
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property NSString * detailUrl;
@property NSString * detailTitle;
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end
